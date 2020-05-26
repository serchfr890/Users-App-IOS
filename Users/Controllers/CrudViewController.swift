//
//  CrudViewController.swift
//  Users
//
//  Created by Axity on 13/05/20.
//  Copyright © 2020 Axity. All rights reserved.
//

import UIKit

class CrudViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createButton: UIButton!
    
    // MARK: -Variables
    var networkManager = NetworkManager()
    var utils = Utils()
    var firtsTime = false;
    var index: Int?
    var type: String?
    var motorcyclesResponse: [MotorcycleResponse] = []
    var motorcycleSelected: MotorcycleResponse?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: TAB_BAR_ITEMS.TITLE_CONTROLLER_2, image: UIImage(systemName: ICON_SYSTEM_NAMES.PENCIL), selectedImage: UIImage(systemName: ICON_SYSTEM_NAMES.PENCIL))
    }

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
                    self.tableView.tableFooterView = UIView()
        networkManager.getAllMotocycles() {motocicles in
            // print("MOTOS: \(motocicles)")
            self.motorcyclesResponse = motocicles!

            // print("Motocicletas: \(self.motocycles)")
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.register(UINib(nibName: VIEWS_CONTROLLER_IDENTIFIER.MOTORCYCLE_TABLE_VIEW_CELL, bundle: nil), forCellReuseIdentifier: VIEWS_CONTROLLER_IDENTIFIER.MOTORCYCLE_CELL)
            self.tableView.reloadData()
            self.tableView.tableFooterView = UIView()
        }
        
        createButton.setTitle(COMMON_MESSAGES.CREATE_BUTTON, for: .normal)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(firtsTime) {
            networkManager.getAllMotocycles() {motocicles in
                self.motorcyclesResponse = motocicles!
                self.tableView.reloadData()
            }
            self.utils.alertMessage(title: COMMON_MESSAGES.SUCCESSFUL_UPDATE, message: COMMON_MESSAGES.EMPTY, controller: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.firtsTime = true
    }
    
        // MARK: - Functions
    
    @objc func deleteMotocycle(sender: UIButton) {
        let id = motorcyclesResponse[sender.tag]._id
        networkManager.deleteMotocycle(id: id) { status in
            if (status == 200) {
                self.networkManager.getAllMotocycles() {motocicles in
                    
                    self.motorcyclesResponse = motocicles!
                    self.tableView.reloadData()
                    self.utils.alertMessage(title: COMMON_MESSAGES.EMPTY, message: COMMON_MESSAGES.SUCCESS_DELETE, controller: self)
                }
                return
            }
            self.utils.alertMessage(title: COMMON_MESSAGES.CAN_NOT_DELETE_ITEM_TITLE, message: COMMON_MESSAGES.CAN_NOT_DELETE_ITEM, controller: self)
        }
    }
    
    @objc func editMotocycle(sender: UIButton) {
                self.index = sender.tag
        self.type = CRUD_TYPE.UPDATE
        performSegue(withIdentifier: VIEWS_CONTROLLER_IDENTIFIER.CREATE_OR_UPDATE, sender: self)
        
    }
    
    @IBAction func createMotorcycleAction(_ sender: UIButton) {
        self.type = CRUD_TYPE.CREATE
        performSegue(withIdentifier: VIEWS_CONTROLLER_IDENTIFIER.CREATE_OR_UPDATE, sender: self)
    }
}

// MARK: - Extensions

extension CrudViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return motorcyclesResponse.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VIEWS_CONTROLLER_IDENTIFIER.MOTORCYCLE_CELL, for: indexPath) as?  MotocycleTableViewCell
        cell?.nameDescriptionLabel.text = motorcyclesResponse[indexPath.row].name
        cell?.brandDescriptionLabel.text = motorcyclesResponse[indexPath.row].brand
        cell?.displacementDescriptionLabel.text = String(motorcyclesResponse[indexPath.row].displacement)
        cell?.maximumSpeedDescriptionLabel.text = String(motorcyclesResponse[indexPath.row].maximumSpeed)
        cell?.finalTranssmitionDescriptionLabel.text = String(motorcyclesResponse[indexPath.row].finalTranssmition)
        cell?.fuelCapacityDescriptionLabel.text = String(motorcyclesResponse[indexPath.row].fuelCapacity)
        cell?.maximunPowerDescriptionLabel.text = String(motorcyclesResponse[indexPath.row].maximunPower)
        
        cell?.deleteButton.tag = indexPath.row
        cell?.deleteButton.addTarget(self, action: #selector(deleteMotocycle), for: .touchUpInside)
        
        cell?.editButton.tag = indexPath.row
        cell?.editButton.addTarget(self, action: #selector(editMotocycle), for: .touchUpInside)
        return cell!
    }
}

extension CrudViewController: UITableViewDelegate {
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CreateOrUpdateViewController {
            switch self.type {
            case CRUD_TYPE.UPDATE:
                destination.motorcycles =  motorcyclesResponse[index!]
                destination.type = self.type
            case CRUD_TYPE.CREATE:
                destination.type = self.type
            default:
                print(COMMON_MESSAGES.EMPTY)
            }
        }
    }
    
}

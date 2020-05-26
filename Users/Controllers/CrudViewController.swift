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
    // let motocycles = ["Vort-X 300","Dominar 400","Pulsar 200","Yamaha 150"]
    var motocycle: [MotorcycleResponse] = []
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
            self.motocycle = motocicles!

            // print("Motocicletas: \(self.motocycles)")
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.register(UINib(nibName: "MotocycleTableViewCell", bundle: nil), forCellReuseIdentifier: "motocycleCell")
            self.tableView.reloadData()
            self.tableView.tableFooterView = UIView()
        }
        
        createButton.setTitle("Crear", for: .normal)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(UINib(nibName: "MotocycleTableViewCell", bundle: nil), forCellReuseIdentifier: "motocycleCell")
        //tableView.reloadData();
        print("------------SE EJKECUTA CICLOP de Vida----------------------\(self.firtsTime)")
        
        if(firtsTime) {
            networkManager.getAllMotocycles() {motocicles in
                // print("MOTOS: \(motocicles)")
                self.motocycle = motocicles!
                self.tableView.reloadData()
            }
            self.utils.alertMessage(title: "Actualización exitosa", message: COMMON_MESSAGES.EMPTY, controller: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.firtsTime = true
    }
    
    @objc func deleteMotocycle(sender: UIButton) {
        print("SE PRESIONÓ EL BOTON DE BORRAR \(sender.tag)")
        let id = motocycle[sender.tag]._id
        networkManager.deleteMotocycle(id: id) { status in
            if (status == 200) {
                self.networkManager.getAllMotocycles() {motocicles in
                    
                    self.motocycle = motocicles!
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
        print("**************************** \(self.index)")
        self.type = "update"
        performSegue(withIdentifier: "CreateOrUpdate", sender: self)
        
    }
    
    @IBAction func createMotorcycleAction(_ sender: UIButton) {
        self.type = "create"
        performSegue(withIdentifier: "CreateOrUpdate", sender: self)
    }
    
    
    
}

// MARK: - Extensions

extension CrudViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return motocycle.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "motocycleCell", for: indexPath) as?  MotocycleTableViewCell
        cell?.nameDescriptionLabel.text = motocycle[indexPath.row].name
        cell?.brandDescriptionLabel.text = motocycle[indexPath.row].brand
        cell?.displacementDescriptionLabel.text = String(motocycle[indexPath.row].displacement)
        cell?.maximumSpeedDescriptionLabel.text = String(motocycle[indexPath.row].maximumSpeed)
        cell?.finalTranssmitionDescriptionLabel.text = String(motocycle[indexPath.row].finalTranssmition)
        cell?.fuelCapacityDescriptionLabel.text = String(motocycle[indexPath.row].fuelCapacity)
        cell?.maximunPowerDescriptionLabel.text = String(motocycle[indexPath.row].maximunPower)
        
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
            print("+++++++TYPE: \(self.type)************")
            switch self.type {
            case "update":
                destination.motorcycles =  motocycle[index!]
                destination.type = self.type
            case "create":
                destination.type = self.type
            default:
                print("")
            }
        }
    }
    
}

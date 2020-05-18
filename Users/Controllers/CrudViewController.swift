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
    
    // MARK: -Variables
        var networkManager = NetworkManager()
    let motocycles = ["Vort-X 300","Dominar 400","Pulsar 200","Yamaha 150"]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: TAB_BAR_ITEMS.TITLE_CONTROLLER_2, image: UIImage(systemName: ICON_SYSTEM_NAMES.PENCIL), selectedImage: UIImage(systemName: ICON_SYSTEM_NAMES.PENCIL))
    }

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MotocycleTableViewCell", bundle: nil), forCellReuseIdentifier: "motocycleCell")

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Extensions

extension CrudViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return motocycles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: "mycell")
//        if cell == nil {
//            cell = UITableViewCell(style: .default, reuseIdentifier: "mycell")
//            cell?.textLabel?.font = UIFont.systemFont(ofSize: 20)
//            cell?.accessoryType = .disclosureIndicator
//        }
//        cell?.textLabel?.text = motocycles[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "motocycleCell", for: indexPath) as?  MotocycleTableViewCell
        
        
        return cell!
    }
    
    
    
    
}

extension CrudViewController: UITableViewDelegate {
    
}

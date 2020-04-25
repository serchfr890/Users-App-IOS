//
//  UsersListViewController.swift
//  Users
//
//  Created by Axity on 24/04/20.
//  Copyright © 2020 Axity. All rights reserved.
//

import UIKit

class UsersListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    private let myCountries = ["España", "Mexico", "Peru", "Colombia", "Argentina"]
    private var result:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }
    

}

extension UsersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "myCell")
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
            cell?.accessoryType = .disclosureIndicator
        }
        cell!.textLabel?.text = myCountries[indexPath.row]
        return cell!
    }
    
    
}

extension UsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        result = myCountries[indexPath.row]
        print(myCountries[indexPath.row])
        performSegue(withIdentifier: "UserDetailVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserDetailViewController {
            destination.country = result
        }
    }
}

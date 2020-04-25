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
        
    // MARK: - Constants
    private let user0 = User(id: 0, name: "Fernamndo", surname: "Suarez Ramírez", emailAddress: "fernando.suarez@gmail.com" , userPhoto: "user0")
    private let user1 = User(id: 1, name: "Juan", surname: "Fernández Torres", emailAddress: "juan.fernandez@gmail.com", userPhoto: "user1")
    private let user2 = User(id: 2, name: "Belén", surname: "Fuentes Casales", emailAddress: "belen.fuentes@gmail.com", userPhoto: "user2")
    private let user3 = User(id: 3, name: "Alejandro", surname: "Tolentino Garcia", emailAddress: "alejandro.tolentino@gmail.com", userPhoto: "user3")
    private let user4 = User(id: 4, name: "Sandra", surname: "López Rodríguez", emailAddress: "sandra.lopez@gmail.com", userPhoto: "user4")
    private let user5 = User(id: 5, name: "Alexander", surname: "Juarez Ruiz", emailAddress: "alexander.juarez@gmail.com", userPhoto: "user5")
    
    // MARK: - Variables
    private var users: [User] = []
    private var userSelected: User?
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        view.backgroundColor = .brown
        tableView.backgroundColor = .brown
        initUsers()

    }
    
    private func initUsers() {
        users.append(user0)
        users.append(user1)
        users.append(user2)
        users.append(user3)
        users.append(user4)
        users.append(user5)
    }
    

}

// MARK: - Extensions
extension UsersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "myCell")
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
            cell?.accessoryType = .disclosureIndicator
            cell?.backgroundColor = .brown
        }
        cell!.textLabel?.text = users[indexPath.row].name
        return cell!
    }
    
    
}

extension UsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userSelected = users[indexPath.row]
        performSegue(withIdentifier: "UserDetailVC", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserDetailViewController {
            destination.user = userSelected
        }
    }
}

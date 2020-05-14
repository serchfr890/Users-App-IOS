//
//  UsersListViewController.swift
//  Users
//
//  Created by Axity on 24/04/20.
//  Copyright © 2020 Axity. All rights reserved.
//

import UIKit

class UsersListViewController: UIViewController {
    
    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: TAB_BAR_ITEMS.TITLE_COMTROLLER_1, image: UIImage(systemName: TAB_BAR_ITEMS.ICON_CONTROLLER_1), selectedImage: UIImage(systemName: TAB_BAR_ITEMS.ICON_CONTROLLER_1))
    }
    
    var networkManager = NetworkManager()
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    private var users: [User] = []
    private var userSelected: User?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        networkManager.getAllUsers() { (usersArraY) in
            self.users = usersArraY!
        }
        view.backgroundColor = .brown
        tableView.backgroundColor = .brown

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.delegate = self
    }
}

// MARK: - Extensions
extension UsersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: USER_LIST_VC_CONTANTS.TABLE_IDENTIFIER)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: USER_LIST_VC_CONTANTS.TABLE_IDENTIFIER)
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
        performSegue(withIdentifier: VIEWS_CONTROLLER_IDENTIFIER.USER_DETAIL, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserDetailViewController {
            destination.user = userSelected
        }
    }
}

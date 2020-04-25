//
//  UsersListViewController.swift
//  Users
//
//  Created by Axity on 24/04/20.
//  Copyright © 2020 Axity. All rights reserved.
//

import UIKit

class UsersListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToUserDetail(_ sender: UIButton) {
        performSegue(withIdentifier: "UserDetailVC", sender: self)
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

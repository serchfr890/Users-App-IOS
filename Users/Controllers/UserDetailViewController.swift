//
//  UserDetailViewController.swift
//  Users
//
//  Created by Axity on 24/04/20.
//  Copyright © 2020 Axity. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    // MARK: - Variables
    var user: User?
    
    // MARK: - Outlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var staticNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var staticSurnameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var staticEmailAddressLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var navBarModal: UINavigationBar!
    
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarModal.topItem?.title = user!.name
        setupItemsView()
    }
    
    // MARK: - Functions
    private func setupItemsView() -> Void{
        
        // Change backgroudcolor from View
        view.backgroundColor = UIColor.brown
        
        // Configure Image User
        let imageUrlString = user!.userPhoto
        let imageUrl = URL(string: imageUrlString)
        let imageData = try! Data(contentsOf: imageUrl!)
        userImage.image = UIImage(data: imageData)
        
        userImage.clipsToBounds = true
        
        // Configure staticNameLabel
        setupStaticsLabels(staticLabel: staticNameLabel, description: "Nombre:")
        
        // Configure nameLabel
        setupLabels(label: nameLabel, description: user!.name)
        
        // Configure staticSurname
        setupStaticsLabels(staticLabel: staticSurnameLabel, description: "Apellidos:")
        
        // Configure surmaneLabel
        setupLabels(label: surnameLabel, description: user!.surname)
        
        // Configure staticEmailAddressLabel
        setupStaticsLabels(staticLabel: staticEmailAddressLabel, description: "Coreeo Electrónico:")
        
        // Configure emailAddresLabel
        setupLabels(label: emailAddressLabel, description: user!.emailAddress)
    }
    
    private func setupStaticsLabels(staticLabel: UILabel, description: String) -> Void {
        staticLabel.text = description
        staticLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        staticLabel.clipsToBounds = true
        
    }
    
    private func setupLabels(label: UILabel, description: String) -> Void{
        label.text = description
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.backgroundColor = UIColor.white
        label.alpha = 0.6
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
    }

}

//
//  ViewController.swift
//  Users
//
//  Created by Axity on 24/04/20.
//  Copyright © 2020 Axity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARCK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupItemsView()
    }

    // MARK: - Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var userMailTextBox: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var initSessionButton: UIButton!
    @IBOutlet weak var forgottenPasswordButton: UIButton!
    
    // MARK: - Actions Buttons
    @IBAction func initSessionAction(_ sender: UIButton) {
        print("Iniciar sesion work´s")
        performSegue(withIdentifier: "UserListVC", sender: self)
        
    }
    
    @IBAction func forgottenPasswordAction(_ sender: Any) {
        print("Función no implementada")
    }
    
    // MARK: - Functions
    private func setupItemsView() {
        
        // Configuration header label
        headerLabel.text = "Bienvenido"
        headerLabel.textAlignment = NSTextAlignment.center
        headerLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
        headerLabel.textColor = UIColor.brown
        headerLabel.clipsToBounds = true
        
        // Configuration user mail text field
        userMailTextBox.placeholder = "Correo electrónico"
        userMailTextBox.textContentType = UITextContentType.emailAddress
        userMailTextBox.keyboardType = UIKeyboardType.emailAddress
        userMailTextBox.returnKeyType = UIReturnKeyType.continue
        userMailTextBox.textColor = UIColor.brown
        userMailTextBox.font = UIFont.boldSystemFont(ofSize: 20.0)
        userMailTextBox.autocapitalizationType = UITextAutocapitalizationType.allCharacters
        userMailTextBox.alpha = 0.6
        userMailTextBox.clipsToBounds = true
        
        // Configuration password text field
        passwordTextField.placeholder = "Contraseña"
        passwordTextField.textContentType = UITextContentType.password
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.textColor = UIColor.brown
        passwordTextField.font = UIFont.boldSystemFont(ofSize: 20.0)
        passwordTextField.alpha = 0.6
        passwordTextField.isSecureTextEntry = true
        passwordTextField.clipsToBounds = true
        
        // Configure InitSession Button
        initSessionButton.backgroundColor = UIColor.brown
        initSessionButton.setTitle("Iniciar sesión", for: .normal)
        initSessionButton.setTitleColor(UIColor.white, for: .normal)
        initSessionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        initSessionButton.layer.cornerRadius = 5
        initSessionButton.clipsToBounds = true
        
        // Configure forgotten password button
        forgottenPasswordButton.setTitle("¿Olvidaste tu Contraseña", for: .normal)
        forgottenPasswordButton.setTitleColor(UIColor.white, for: .normal)
        forgottenPasswordButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        forgottenPasswordButton.clipsToBounds = true
    }
    
    
}


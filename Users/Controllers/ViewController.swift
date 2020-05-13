//
//  ViewController.swift
//  Users
//
//  Created by Axity on 24/04/20.
//  Copyright © 2020 Axity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var utils = Utils()
    var networkManager = NetworkManager()

    // MARCK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        userMailTextBox.delegate = self
        passwordTextField.delegate = self
    
        setupItemsView()
    }

    // MARK: - Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var userMailTextBox: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var initSessionButton: UIButton!
    @IBOutlet weak var forgottenPasswordButton: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    
    // MARK: - Actions Buttons
    @IBAction func initSessionAction(_ sender: UIButton) {
        startLoadingAnimation()
        
        if (userMailTextBox.hasText && passwordTextField.hasText) {
            let userMail = userMailTextBox.text!
            let password = passwordTextField.text!
            
            networkManager.doLogin(emailAddress: userMail, password: password) {
                (statusCode) in
                if(statusCode == 200) {
                    self.performSegue(withIdentifier: VIEWS_CONTROLLER_IDENTIFIER.USER_LIST, sender: self)
                    self.loading.stopAnimating()
                    return
                }
                self.utils.alertMessage(title: COMMON_MESSAGES.SESSION_FAILED, message: COMMON_MESSAGES.INVALID_CREDENTIALS, controller: self)
                self.loading.stopAnimating()
            }
            
        }
        
        if (!userMailTextBox.hasText) {
            errorEmailLabel.text = "Ingresar un correo electrónico válido"
            errorEmailLabel.isHidden = false
            
        }
        
        if (!passwordTextField.hasText) {
            errorPasswordLabel.text = "Ingrsar contraseña"
            errorPasswordLabel.isHidden = false
        }
                
    }
    
    @IBAction func forgottenPasswordAction(_ sender: Any) {
        utils.alertMessage(title: COMMON_MESSAGES.EMPTY, message: COMMON_MESSAGES.FUNCTIONALITY_NOT_IMPLEMENTED, controller: self)
    }
    
    // MARK: - Functions
    private func setupItemsView() {
        // Configuration header label
        headerLabel.text = COMMON_MESSAGES.WELCOME
        headerLabel.textAlignment = NSTextAlignment.center
        headerLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
        headerLabel.textColor = UIColor.brown
        headerLabel.clipsToBounds = true
        
        // Configuration user mail text field
        userMailTextBox.placeholder = LOGIN_FIELD_NAMES.EMAIL
        userMailTextBox.textContentType = UITextContentType.emailAddress
        userMailTextBox.keyboardType = UIKeyboardType.emailAddress
        userMailTextBox.returnKeyType = UIReturnKeyType.continue
        userMailTextBox.textColor = UIColor.brown
        userMailTextBox.font = UIFont.boldSystemFont(ofSize: 20.0)
        userMailTextBox.alpha = 0.6
        userMailTextBox.text = LOGIN_FIELD_NAMES.EMAIL_MOCK_VALUE
        userMailTextBox.tag = 0
        userMailTextBox.clipsToBounds = true
        
        // Configuration password text field
        passwordTextField.placeholder = LOGIN_FIELD_NAMES.PASSWORD
        passwordTextField.textContentType = UITextContentType.password
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.textColor = UIColor.brown
        passwordTextField.font = UIFont.boldSystemFont(ofSize: 20.0)
        passwordTextField.alpha = 0.6
        passwordTextField.text = LOGIN_FIELD_NAMES.PASSWORD_MOCK_VALUE
        passwordTextField.tag = 1
        passwordTextField.isSecureTextEntry = true
        passwordTextField.clipsToBounds = true
        
        // Configure InitSession Button
        initSessionButton.backgroundColor = UIColor.brown
        initSessionButton.setTitle(COMMON_MESSAGES.INIT_SESSION, for: .normal)
        initSessionButton.setTitleColor(UIColor.white, for: .normal)
        initSessionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        initSessionButton.layer.cornerRadius = 5
        initSessionButton.clipsToBounds = true
        
        // Configure forgotten password button
        forgottenPasswordButton.setTitle(COMMON_MESSAGES.FORGOTTEN_PASSWORD, for: .normal)
        forgottenPasswordButton.setTitleColor(UIColor.white, for: .normal)
        forgottenPasswordButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        forgottenPasswordButton.clipsToBounds = true
        
        // Configuration errorLabel
        errorEmailLabel.isHidden = true
        errorEmailLabel.text = "Hola"
        errorEmailLabel.textColor = .red
        errorEmailLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        errorEmailLabel.clipsToBounds = true
        
        // Configuration errorPasswordLabel
        errorPasswordLabel.isHidden = true
        errorPasswordLabel.text = "Holi 2"
        errorPasswordLabel.textColor = .red
        errorPasswordLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        errorPasswordLabel.clipsToBounds = true
        
    }
    
    func startLoadingAnimation() {
        loading.color = .white
        loading.startAnimating()
        loading.hidesWhenStopped = true
    }
    
    
}

extension UIViewController: UITextFieldDelegate {
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            let retrunvAlue = true
            let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
            do {
                let regex = try NSRegularExpression(pattern: emailRegEx)
                let nsString = textField.text! as NSString
                let result = regex.matches(in: textField.text!, range: NSRange(location: 0, length: nsString.length))
                print("Result: \(result)")
                if (!(result.count == 0)) {
                    textField.layer.borderColor = UIColor.green.cgColor
                } else {
                    textField.layer.borderColor = UIColor.red.cgColor
                }
                
            } catch let error as NSError {
                print("invalid regex: \(error.localizedDescription)")
            }
            break
            
        case 1:
            
            break
        default:
            print("")
        }
    }
}

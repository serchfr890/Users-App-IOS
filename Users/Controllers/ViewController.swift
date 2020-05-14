//
//  ViewController.swift
//  Users
//
//  Created by Axity on 24/04/20.
//  Copyright © 2020 Axity. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - Observer Definitions
let disposeBagMail = DisposeBag()
var subscriptionMail: Disposable?
let disponseBagPassword = DisposeBag()
var subscriptionPassword: Disposable?

private var isValidEmailInput = BehaviorSubject<Bool>(value: false)
private var isValidPasswordInput = BehaviorSubject<Bool>(value: false)
var validateEmail: Observable<Bool> { return isValidEmailInput.asObservable() }
var validatePassword: Observable<Bool> { return isValidPasswordInput.asObservable()}
    var isFirstTimeAppLauched = false

class ViewController: UIViewController {
    
    var utils = Utils()
    var networkManager = NetworkManager()
    var isEmailValited = false
    var isPasswordValited = false

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItemsView()
        self.navigationController?.isNavigationBarHidden = true
        userMailTextBox.delegate = self
        passwordTextField.delegate = self
        isFirstTimeAppLauched = true
        
        subscriptionMail =  validateEmail.subscribe(onNext: { [weak self] isValidEmailInput in
            if (!isFirstTimeAppLauched) {
                self?.isEmailValited = isValidEmailInput
                self?.enableInitSessionButton(button: self!.initSessionButton)
                self?.changeBorderTextField(textField: self!.userMailTextBox, isValidInput: isValidEmailInput, label: self!.errorEmailLabel, errorMEssage: COMMON_MESSAGES.INVALID_MAIL)
            }
        })
        subscriptionMail?.disposed(by: disposeBagMail)
        
        subscriptionPassword =  validatePassword.subscribe(onNext: { [weak self ] isValidPasswordInput in
            if (!isFirstTimeAppLauched) {
                self?.isPasswordValited = isValidPasswordInput
                self?.enableInitSessionButton(button: self!.initSessionButton)
                self?.changeBorderTextField(textField: self!.passwordTextField, isValidInput: isValidPasswordInput, label: self!.errorPasswordLabel, errorMEssage: COMMON_MESSAGES.INVALID_PASSWORD)
            }
        
        })
        subscriptionPassword?.disposed(by: disponseBagPassword)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Unsubscribe observers
        subscriptionMail?.dispose()
        subscriptionPassword?.dispose()
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
        self.disableInitSessionButton(disable: true, button: self.initSessionButton)
        
        let userMail = userMailTextBox.text!
        let password = passwordTextField.text!

        networkManager.doLogin(emailAddress: userMail, password: password) {
            (statusCode) in
            if((statusCode == 200) || (statusCode == 201)) {
                self.performSegue(withIdentifier: "tab_vc", sender: self)
                self.loading.stopAnimating()
                return
            }
            self.utils.alertMessage(title: COMMON_MESSAGES.SESSION_FAILED, message: COMMON_MESSAGES.INVALID_CREDENTIALS, controller: self)
            self.loading.stopAnimating()
            self.disableInitSessionButton(disable: false, button: self.initSessionButton)
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
        userMailTextBox.tag = 0
        userMailTextBox.clipsToBounds = true
        
        // Configuration password text field
        passwordTextField.placeholder = LOGIN_FIELD_NAMES.PASSWORD
        passwordTextField.textContentType = UITextContentType.password
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.textColor = UIColor.brown
        passwordTextField.font = UIFont.boldSystemFont(ofSize: 20.0)
        passwordTextField.alpha = 0.6
        passwordTextField.tag = 1
        passwordTextField.isSecureTextEntry = true
        passwordTextField.clipsToBounds = true
        
        // Configuration InitSession Button
        initSessionButton.setTitle(COMMON_MESSAGES.INIT_SESSION, for: .normal)
        initSessionButton.setTitleColor(UIColor.white, for: .normal)
        initSessionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        initSessionButton.layer.cornerRadius = 5
        initSessionButton.isEnabled = false
        initSessionButton.backgroundColor = UIColor.lightGray
        initSessionButton.clipsToBounds = true
        
        // Configuration forgotten password button
        forgottenPasswordButton.setTitle(COMMON_MESSAGES.FORGOTTEN_PASSWORD, for: .normal)
        forgottenPasswordButton.setTitleColor(UIColor.white, for: .normal)
        forgottenPasswordButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        forgottenPasswordButton.clipsToBounds = true
        
        // Configuration errorLabel
        errorEmailLabel.isHidden = true
        errorEmailLabel.text = COMMON_MESSAGES.EMPTY
        errorEmailLabel.textColor = .red
        errorEmailLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        errorEmailLabel.clipsToBounds = true
        
        // Configuration errorPasswordLabel
        errorPasswordLabel.isHidden = true
        errorPasswordLabel.text = COMMON_MESSAGES.EMPTY
        errorPasswordLabel.textColor = .red
        errorPasswordLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        errorPasswordLabel.clipsToBounds = true
        
        // Configuration loading
        loading.color = .white
        loading.isHidden = true
        
    }
    
    // Loading animation starts
    func startLoadingAnimation() {
        loading.isHidden = false
        loading.startAnimating()
        loading.hidesWhenStopped = true
    }
    // Enable or disable the login button if the field values ​​were correct or not
    func enableInitSessionButton(button: UIButton) {
        if (isPasswordValited && isEmailValited) {
            button.backgroundColor = UIColor.brown
            button.isEnabled = true
            return
        }
        button.backgroundColor = UIColor.lightGray
        button.isEnabled = false
    }
    
    // Enable or disable init session button
    func disableInitSessionButton(disable: Bool, button: UIButton) {
        if (!disable) {
            button.backgroundColor = UIColor.brown
            button.isEnabled = true
            return
        }
        button.backgroundColor = UIColor.lightGray
        button.isEnabled = false
    }
    
    func changeBorderTextField(textField: UITextField, isValidInput: Bool, label: UILabel, errorMEssage: String) {
            textField.layer.borderWidth = 1.5
            textField.layer.cornerRadius = 5
            if (isValidInput) {
                textField.layer.borderColor = UIColor.green.cgColor
                label.isHidden = true
                return
            }
            textField.layer.borderColor = UIColor.red.cgColor
            label.text = errorMEssage
            label.isHidden = false
        }
    
}

// MARK: - Extensions
extension UIViewController: UITextFieldDelegate {
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        isFirstTimeAppLauched = false
        switch textField.tag {
        case 0:
            do {
                let regex = try NSRegularExpression(pattern: REGEX.MAIL)
                let nsString = textField.text! as NSString
                let result = regex.matches(in: textField.text!, range: NSRange(location: 0, length: nsString.length))
                if (!(result.count == 0)) {
                    isValidEmailInput.onNext(true)
                } else {
                    isValidEmailInput.onNext(false)
                    textField.layer.borderColor = UIColor.red.cgColor
                }
                
            } catch let error as NSError {
                print("\(COMMON_MESSAGES.INVALID_REGEX) \(error.localizedDescription)")
                isValidEmailInput.onNext(false)
            }
            break
        case 1:
            if(textField.text!.count >= 8 ){
                isValidPasswordInput.onNext(true)
                return
            }
            isValidPasswordInput.onNext(false)
            break
        default:
            print(COMMON_MESSAGES.EMPTY)
        }
    }
}

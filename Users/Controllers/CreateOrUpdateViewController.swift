//
//  CreateOrUpdateViewController.swift
//  Users
//
//  Created by Axity on 25/05/20.
//  Copyright © 2020 Axity. All rights reserved.
//

import UIKit
import RxSwift

//MARK: - Observers Definitions
private let disposeBagInputBrand = DisposeBag()
private var subscriptionInputBrand: Disposable?
private var isValidInputBrand = BehaviorSubject<Bool>(value: false)
private var validateInputBrand: Observable<Bool> { return isValidInputBrand.asObservable() }

private let disposeBagInputName = DisposeBag()
private var subscriptionInputName: Disposable?
private var isValidInputName = BehaviorSubject<Bool>(value: false)
private var validateInputName: Observable<Bool> { return isValidInputName.asObservable() }

private let disposeBagInputDissplacement = DisposeBag()
private var subscriptionInputDissplacement: Disposable?
private var isValidInputDissplacement = BehaviorSubject<Bool>(value: false)
private var validateInputDissplacement: Observable<Bool> { return isValidInputDissplacement.asObservable() }

private let disposeBagInputFinalTransmition = DisposeBag()
private var subscriptionInputFinalTransmition: Disposable?
private var isValidInputFinalTransmition = BehaviorSubject<Bool>(value: false)
private var validateInputFinalTransmitiont: Observable<Bool> { return isValidInputFinalTransmition.asObservable() }

private let disposeBagInputMaximunSpeed = DisposeBag()
private var subscriptionInputMaximunSpeed: Disposable?
private var isValidInputMaximunSpeed = BehaviorSubject<Bool>(value: false)
private var validateInputMaximunSpeed: Observable<Bool> { return isValidInputMaximunSpeed.asObservable() }

private let disposeBagInputFuelCapacity = DisposeBag()
private var subscriptionInputFuelCapacity: Disposable?
private var isValidInputFuelCapacity = BehaviorSubject<Bool>(value: false)
private var validateInputFuelCapacity: Observable<Bool> { return isValidInputFuelCapacity.asObservable() }

private let disposeBagInputMaximunPower = DisposeBag()
private var subscriptionInputMaximunPower: Disposable?
private var isValidInputMaximunPower = BehaviorSubject<Bool>(value: false)
private var validateInputMaximunPower: Observable<Bool> { return isValidInputMaximunPower.asObservable() }

var isFirstTimeAppLauchedCU = false

class CreateOrUpdateViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var dissplacementTextField: UITextField!
    @IBOutlet weak var finalTransmitionTextField: UITextField!
    @IBOutlet weak var fuelCapacityTextField: UITextField!
    @IBOutlet weak var maximunSpeed: UITextField!
    @IBOutlet weak var maximunPower: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var createOrUpdateButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var dissplacementLabel: UILabel!
    @IBOutlet weak var finalTransmitionLabel: UILabel!
    @IBOutlet weak var fuelCapacityLabel: UILabel!
    @IBOutlet weak var maximunSpeedLabel: UILabel!
    @IBOutlet weak var maximunPowerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    // MARK: - Variables
    var motorcycles: MotorcycleResponse?
    var type: String?
    var networkManager = NetworkManager()
    var utils = Utils()
    var isValidatedBrand = false
    var isValidatedName = false
    var isValidatedDissplacement = false
    var isValidatedFinalTransmition = false
    var isValidatedFuelCapacity = false
    var isValidatedMaximunSpeed = false
    var isValidatedMaximunPower = false
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewItems()
        isFirstTimeAppLauchedCU = true
        createOrUpdateMotorcycle()
        brandTextField.delegate = self
        dissplacementTextField.delegate = self
        finalTransmitionTextField.delegate = self
        fuelCapacityTextField.delegate = self
        maximunSpeed.delegate = self
        maximunPower.delegate = self
        nameTextField.delegate = self
        
        subscriptionInputBrand = validateInputBrand.subscribe(onNext: { isValidated in
            
            if(!(isFirstTimeAppLauchedCU)) {
                self.isValidatedBrand = isValidated
                self.enableCreateOrUpdateButton(button: self.createOrUpdateButton)
                self.changeBorderTextField(textField: self.brandTextField, isValidInput: isValidated, label: self.brandLabel, errorMEssage: COMMON_MESSAGES.ONLY_CONTENT_TEXT)
            }
        })
        subscriptionInputBrand?.disposed(by: disposeBagInputBrand)
        
        subscriptionInputName = validateInputName.subscribe(onNext: { isValidate in
            if(!(isFirstTimeAppLauchedCU)) {
                self.isValidatedName = isValidate
                self.enableCreateOrUpdateButton(button: self.createOrUpdateButton)
                self.changeBorderTextField(textField: self.nameTextField, isValidInput: isValidate, label: self.nameLabel, errorMEssage: COMMON_MESSAGES.ONLY_CONTENT_NUMBERS)
            }
        })
        subscriptionInputName?.disposed(by: disposeBagInputName)
        
        subscriptionInputDissplacement = validateInputDissplacement.subscribe(onNext: { isValidate in
            
            if(!(isFirstTimeAppLauchedCU)) {
                self.isValidatedDissplacement = isValidate
                self.enableCreateOrUpdateButton(button: self.createOrUpdateButton)
                self.changeBorderTextField(textField: self.dissplacementTextField, isValidInput: isValidate, label: self.dissplacementLabel, errorMEssage: COMMON_MESSAGES.ONLY_CONTENT_NUMBERS)
            }
        })
        subscriptionInputDissplacement?.disposed(by: disposeBagInputDissplacement)
        
        
        subscriptionInputFinalTransmition = validateInputFinalTransmitiont.subscribe(onNext: { isValidate in
            
            if(!(isFirstTimeAppLauchedCU)) {
                self.isValidatedFinalTransmition = isValidate
                self.enableCreateOrUpdateButton(button: self.createOrUpdateButton)
                self.changeBorderTextField(textField: self.finalTransmitionTextField, isValidInput: isValidate, label: self.finalTransmitionLabel, errorMEssage: COMMON_MESSAGES.ONLY_CONTENT_NUMBERS)
            }
        })
        subscriptionInputFinalTransmition?.disposed(by: disposeBagInputFinalTransmition)
        
        subscriptionInputFuelCapacity = validateInputFuelCapacity.subscribe(onNext: { isValidate in
            
            if(!(isFirstTimeAppLauchedCU)) {
                self.isValidatedFuelCapacity = isValidate
                self.enableCreateOrUpdateButton(button: self.createOrUpdateButton)
                self.changeBorderTextField(textField: self.fuelCapacityTextField, isValidInput: isValidate, label: self.fuelCapacityLabel, errorMEssage: COMMON_MESSAGES.ONLY_CONTENT_NUMBERS)
            }
        })
        subscriptionInputFuelCapacity?.disposed(by: disposeBagInputFuelCapacity)
        
        subscriptionInputMaximunSpeed = validateInputMaximunSpeed.subscribe(onNext: { isValidate in
            
            if(!(isFirstTimeAppLauchedCU)) {
                self.isValidatedMaximunSpeed = isValidate
                self.enableCreateOrUpdateButton(button: self.createOrUpdateButton)
                self.changeBorderTextField(textField: self.maximunSpeed, isValidInput: isValidate, label: self.maximunSpeedLabel, errorMEssage: COMMON_MESSAGES.ONLY_CONTENT_NUMBERS)
            }
        })
        subscriptionInputMaximunSpeed?.disposed(by: disposeBagInputMaximunSpeed)
        
        subscriptionInputMaximunPower = validateInputMaximunPower.subscribe(onNext: { isValidate in
            
            if(!(isFirstTimeAppLauchedCU)) {
                self.isValidatedMaximunPower = isValidate
                self.enableCreateOrUpdateButton(button: self.createOrUpdateButton)
                self.changeBorderTextField(textField: self.maximunPower, isValidInput: isValidate, label: self.maximunPowerLabel, errorMEssage: COMMON_MESSAGES.ONLY_CONTENT_NUMBERS)
            }
        })
        subscriptionInputMaximunPower?.disposed(by: disposeBagInputMaximunPower)
        
    }
    
    // MARK: Button Actions
    @IBAction func createOrUpdateButtonAction(_ sender: Any) {
        
        let motocycleCreateOrUpdate =  MotorcycleRequest(brand: brandTextField.text!, displacement: Int(dissplacementTextField!.text!)!, finalTranssmition: Int(finalTransmitionTextField.text!)!, fuelCapacity: Int(fuelCapacityTextField.text!)!, maximumSpeed: Int(maximunSpeed.text!)!, maximunPower: Double(maximunPower.text!)!, name: nameTextField.text!)

        indicator.isHidden = false
        indicator.startAnimating()
        
        
        switch self.type {
        case CRUD_TYPE.UPDATE:
            networkManager.updateMotocycle(id: motorcycles!._id, motorcycle: motocycleCreateOrUpdate) {response in
                if(!(response == 200)) {
                    self.utils.alertMessage(title: COMMON_MESSAGES.ERROR, message: COMMON_MESSAGES.ERROR_UPDATE, controller: self)
                    return
                }
                self.navigationController?.popViewController(animated: true)
                self.indicator.stopAnimating()
            }
        case CRUD_TYPE.CREATE:
            let newMotorcycle = MotorcycleRequest(brand: brandTextField.text!, displacement: Int(dissplacementTextField!.text!)!, finalTranssmition: Int(finalTransmitionTextField.text!)!, fuelCapacity: Int(fuelCapacityTextField.text!)!, maximumSpeed: Int(maximunSpeed.text!)!, maximunPower: Double(maximunPower.text!)!, name: nameTextField.text!)
            
            networkManager.createMotorcycle(motorcycle: newMotorcycle) { response in
                if((response == 200) || (response == 201)) {
                    self.indicator.stopAnimating()
                    self.navigationController?.popViewController(animated: true)
                    return
                }
                self.utils.alertMessage(title: COMMON_MESSAGES.ERROR, message: COMMON_MESSAGES.ERROR_CREATE, controller: self)
            }
        default:
            print(COMMON_MESSAGES.EMPTY)
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Functions
    
    private func setupViewItems() {
        brandTextField.placeholder = PLACEHOLDERS_CREATE_OR_UPDATE_VIEW.BRAND
        brandTextField.tag = 0
        dissplacementTextField.placeholder = PLACEHOLDERS_CREATE_OR_UPDATE_VIEW.DISSPLACEMENT
        dissplacementTextField.tag = 1
        finalTransmitionTextField.placeholder = PLACEHOLDERS_CREATE_OR_UPDATE_VIEW.FINAL_TRANSMITION
        finalTransmitionTextField.tag = 2
        fuelCapacityTextField.placeholder = PLACEHOLDERS_CREATE_OR_UPDATE_VIEW.FUEL_CAPACITY
        fuelCapacityTextField.tag = 3
        maximunSpeed.placeholder = PLACEHOLDERS_CREATE_OR_UPDATE_VIEW.MAXIMUM_SPEED
        maximunSpeed.tag = 4
        maximunPower.placeholder = PLACEHOLDERS_CREATE_OR_UPDATE_VIEW.MAXIMUM_POWER
        maximunPower.tag = 5
        nameTextField.placeholder = PLACEHOLDERS_CREATE_OR_UPDATE_VIEW.NAME
        nameTextField.tag = 6
        cancelButton.setTitle(COMMON_MESSAGES.CANCEL_BUTTON, for: .normal)
        createOrUpdateButton.isEnabled = false
        indicator.isHidden = true
        
        setupLabels(label: brandLabel)
        setupLabels(label: dissplacementLabel)
        setupLabels(label: finalTransmitionLabel)
        setupLabels(label: fuelCapacityLabel)
        setupLabels(label: maximunSpeedLabel)
        setupLabels(label: maximunPowerLabel)
        setupLabels(label: nameLabel)
    }
    
    private func createOrUpdateMotorcycle() {
        
        switch self.type {
        case CRUD_TYPE.UPDATE:
            brandTextField.text = motorcycles?.brand;
            dissplacementTextField.text = String(motorcycles!.displacement)
            finalTransmitionTextField.text = String(motorcycles!.finalTranssmition)
            fuelCapacityTextField.text = String(motorcycles!.fuelCapacity)
            maximunPower.text = String(motorcycles!.maximunPower)
            maximunSpeed.text = String(motorcycles!.maximumSpeed)
            nameTextField.text = motorcycles?.name
            createOrUpdateButton.setTitle(COMMON_MESSAGES.UPDATE_BUTTON, for: .normal)
        case CRUD_TYPE.CREATE:
            createOrUpdateButton.setTitle(COMMON_MESSAGES.CREATE_BUTTON, for: .normal)
        default:
            print(COMMON_MESSAGES.EMPTY)
        }
    }
    
    override func textFieldDidChangeSelection(_ textField: UITextField) {
        isFirstTimeAppLauchedCU = false
        switch textField.tag {
        case 0:
            do {
                let regex = try NSRegularExpression(pattern: REGEX.ONLY_TEXT)
                let nsString = textField.text! as NSString
                let result = regex.matches(in: textField.text!, range: NSRange(location: 0, length: nsString.length))
                if(!(result.count == 0)) {
                    isValidInputBrand.onNext(true)
                } else {
                    isValidInputBrand.onNext(false)
                }
            } catch let error as NSError {
                print(error)
                isValidInputBrand.onNext(false)
            }
        case 1:
            do {
                let regex = try NSRegularExpression(pattern: REGEX.ONLY_NUMBERS)
                let nsString = textField.text! as NSString
                let result = regex.matches(in: textField.text!, range: NSRange(location: 0, length: nsString.length))
                if(!(result.count == 0)) {
                    isValidInputDissplacement.onNext(true)
                } else {
                    isValidInputDissplacement.onNext(false)
                }
            } catch let error as NSError {
                print(error)
                isValidInputDissplacement.onNext(false)
            }
        case 2:
            do {
                let regex = try NSRegularExpression(pattern: REGEX.ONLY_NUMBERS)
                let nsString = textField.text! as NSString
                let result = regex.matches(in: textField.text!, range: NSRange(location: 0, length: nsString.length))
                if(!(result.count == 0)) {
                    isValidInputFinalTransmition.onNext(true)
                } else {
                    isValidInputFinalTransmition.onNext(false)
                }
            } catch let error as NSError {
                print(error)
                isValidInputFinalTransmition.onNext(false)
            }
        case 3:
            do {
                let regex = try NSRegularExpression(pattern: REGEX.ONLY_NUMBERS)
                let nsString = textField.text! as NSString
                let result = regex.matches(in: textField.text!, range: NSRange(location: 0, length: nsString.length))
                if(!(result.count == 0)) {
                    isValidInputFuelCapacity.onNext(true)
                } else {
                    isValidInputFuelCapacity.onNext(false)
                }
            } catch let error as NSError {
                print(error)
                isValidInputFuelCapacity.onNext(false)
            }
        case 4:
            do {
                let regex = try NSRegularExpression(pattern: REGEX.ONLY_NUMBERS)
                let nsString = textField.text! as NSString
                let result = regex.matches(in: textField.text!, range: NSRange(location: 0, length: nsString.length))
                if(!(result.count == 0)) {
                    isValidInputMaximunSpeed.onNext(true)
                } else {
                    isValidInputMaximunSpeed.onNext(false)
                }
            } catch let error as NSError {
                print(error)
                isValidInputMaximunSpeed.onNext(false)
            }
        case 5:
            do {
                let regex = try NSRegularExpression(pattern: REGEX.ONLY_NUMBERS)
                let nsString = textField.text! as NSString
                let result = regex.matches(in: textField.text!, range: NSRange(location: 0, length: nsString.length))
                if(!(result.count == 0)) {
                    isValidInputMaximunPower.onNext(true)
                } else {
                    isValidInputMaximunPower.onNext(false)
                }
            } catch let error as NSError {
                print(error)
                isValidInputMaximunPower.onNext(false)
            }
        case 6:
            do {
                let regex = try NSRegularExpression(pattern: REGEX.ONLY_TEXT)
                let nsString = textField.text! as NSString
                let result = regex.matches(in: textField.text!, range: NSRange(location: 0, length: nsString.length))
                if(!(result.count == 0)) {
                    isValidInputName.onNext(true)
                } else {
                    isValidInputName.onNext(false)
                }
            } catch let error as NSError {
                print(error)
                isValidInputName.onNext(false)
            }
        default:
            print(COMMON_MESSAGES.EMPTY)
        }
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
    
    func setupLabels(label: UILabel) {
        label.isHidden = true
        label.text = COMMON_MESSAGES.EMPTY
        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.clipsToBounds = true
    }
    
    func enableCreateOrUpdateButton(button: UIButton) {
        if (isValidatedBrand && isValidatedName && isValidatedDissplacement && isValidatedFinalTransmition && isValidatedFuelCapacity &&  isValidatedMaximunSpeed && isValidatedMaximunPower) {
            button.isEnabled = true
            return
        }
        button.isEnabled = false
    }
    
}

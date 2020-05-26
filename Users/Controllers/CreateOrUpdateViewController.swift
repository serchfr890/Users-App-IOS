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
    
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewItems()
        createOrUpdateMotorcycle()
        brandTextField.delegate = self
        dissplacementTextField.delegate = self
        finalTransmitionTextField.delegate = self
        fuelCapacityTextField.delegate = self
        maximunSpeed.delegate = self
        maximunPower.delegate = self
        nameTextField.delegate = self
        
       /* validateInputBrand.subscribe({ [ weak self ] isValidInputBrad in
            self?.changeBorderTextField(textField: self!.brandTextField, isValidInput: isValidInputBrad, label: nil, errorMEssage: "")
        })*/
        
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
        maximunPower.placeholder = PLACEHOLDERS_CREATE_OR_UPDATE_VIEW.MAXIMUM_POWER
        maximunPower.tag = 4
        maximunSpeed.placeholder = PLACEHOLDERS_CREATE_OR_UPDATE_VIEW.MAXIMUM_SPEED
        maximunSpeed.tag = 5
        nameTextField.placeholder = PLACEHOLDERS_CREATE_OR_UPDATE_VIEW.NAME
        nameTextField.tag = 6
        cancelButton.setTitle(COMMON_MESSAGES.CANCEL_BUTTON, for: .normal)
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
        switch textField.tag {
        case 0:
            do {
                let regex = try NSRegularExpression(pattern: "^[a-z]")
                let nsString = textField.text! as NSString
                let result = regex.matches(in: textField.text!, range: NSRange(location: 0, length: nsString.length))
                if(!(result.count == 0)) {
                    isValidInputBrand.onNext(true)
                }
            } catch let error as NSError {
                print(error)
                isValidInputBrand.onNext(false)
            }
            print("TEXTFIELD 0")
        case 1:
            print("TEXTFIELD 1")
        case 2:
            print("TEXTFIELD 2")
        case 3:
            print("TEXTFIELD 3")
        case 4:
            print("TEXTFIELD 4")
        case 5:
            print("TEXTFIELD 5")
        case 6:
            print("TEXTFIELD 6")
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
    
}

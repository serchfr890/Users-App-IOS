//
//  CreateOrUpdateViewController.swift
//  Users
//
//  Created by Axity on 25/05/20.
//  Copyright © 2020 Axity. All rights reserved.
//

import UIKit

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
        dissplacementTextField.placeholder = PLACEHOLDERS_CREATE_OR_UPDATE_VIEW.DISSPLACEMENT
        finalTransmitionTextField.placeholder = PLACEHOLDERS_CREATE_OR_UPDATE_VIEW.FINAL_TRANSMITION
        fuelCapacityTextField.placeholder = PLACEHOLDERS_CREATE_OR_UPDATE_VIEW.FUEL_CAPACITY
        maximunPower.placeholder = PLACEHOLDERS_CREATE_OR_UPDATE_VIEW.MAXIMUM_POWER
        maximunSpeed.placeholder = PLACEHOLDERS_CREATE_OR_UPDATE_VIEW.MAXIMUM_SPEED
        nameTextField.placeholder = PLACEHOLDERS_CREATE_OR_UPDATE_VIEW.NAME
        cancelButton.setTitle(COMMON_MESSAGES.CANCEL_BUTTON, for: .normal)
        indicator.isHidden = true
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
    
}

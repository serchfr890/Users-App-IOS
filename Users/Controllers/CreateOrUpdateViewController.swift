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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewItems()
        createOrUpdateMotorcycle()
    }
    
    // MARK: Button Actions
    @IBAction func createOrUpdateButtonAction(_ sender: Any) {
        print("pintar un campo: \(brandTextField.text!)")
        
        var motocycleCreateOrUpdate =  MotorcycleRequest(brand: brandTextField.text!, displacement: Int(dissplacementTextField!.text!)!, finalTranssmition: Int(finalTransmitionTextField.text!)!, fuelCapacity: Int(fuelCapacityTextField.text!)!, maximumSpeed: Int(maximunSpeed.text!)!, maximunPower: Double(maximunPower.text!)!, name: nameTextField.text!)

        indicator.isHidden = false
        indicator.startAnimating()
        
        
        switch self.type {
        case "update":
            print("Motorcicleta update \(motocycleCreateOrUpdate)")
            networkManager.updateMotocycle(id: motorcycles!._id, motorcycle: motocycleCreateOrUpdate) {response in print("RESPONSE UPDATE: \(response)")
                if(!(response == 200)) {
                    self.utils.alertMessage(title: "Error !!!", message: "Lo sentimos. Hubo un error al actualizar elemento", controller: self)
                    return
                }
                self.navigationController?.popViewController(animated: true)
                self.indicator.stopAnimating()
            }
        case "create":
            var newMotorcycle = MotorcycleRequest(brand: brandTextField.text!, displacement: Int(dissplacementTextField!.text!)!, finalTranssmition: Int(finalTransmitionTextField.text!)!, fuelCapacity: Int(fuelCapacityTextField.text!)!, maximumSpeed: Int(maximunSpeed.text!)!, maximunPower: Double(maximunPower.text!)!, name: nameTextField.text!)
            
            networkManager.createMotorcycle(motorcycle: newMotorcycle) { response in
                if((response == 200) || (response == 201)) {
                    self.indicator.stopAnimating()
                    self.navigationController?.popViewController(animated: true)
                    return
                }
                self.utils.alertMessage(title: "Error!!!", message: "Hubo un error al crear el elemento", controller: self)
            }
            print("")
        default:
            print("")
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    // MARK: - Functions
    
    private func setupViewItems() {
        brandTextField.placeholder = "Ingresar Marca"
        dissplacementTextField.placeholder = "Ingresar cilindrada"
        finalTransmitionTextField.placeholder = "Ingresar # velocidades"
        fuelCapacityTextField.placeholder = "Ingresar capacidad de combustible"
        maximunPower.placeholder = "Ingresar Caballos de fuerza"
        maximunSpeed.placeholder = "Ingresar velocidad maxima"
        nameTextField.placeholder = "Ingresar nombre"
        cancelButton.setTitle("Cancelar", for: .normal)
        indicator.isHidden = true
    }
    
    private func createOrUpdateMotorcycle() {
        print("MOTORCYCLE \(motorcycles)")
        
        switch self.type {
        case "update":
            brandTextField.text = motorcycles?.brand;
            dissplacementTextField.text = String(motorcycles!.displacement)
            finalTransmitionTextField.text = String(motorcycles!.finalTranssmition)
            fuelCapacityTextField.text = String(motorcycles!.fuelCapacity)
            maximunPower.text = String(motorcycles!.maximunPower)
            maximunSpeed.text = String(motorcycles!.maximumSpeed)
            nameTextField.text = motorcycles?.name
            createOrUpdateButton.setTitle("Actualizar", for: .normal)
        case "create":
            createOrUpdateButton.setTitle("Crear", for: .normal)
        default:
            print("")
        }
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

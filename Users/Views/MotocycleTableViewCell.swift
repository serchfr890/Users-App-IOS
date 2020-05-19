//
//  MotocycleTableViewCell.swift
//  Users
//
//  Created by Axity on 14/05/20.
//  Copyright © 2020 Axity. All rights reserved.
//

import UIKit

class MotocycleTableViewCell: UITableViewCell {
    
    // Variables
    
    var rowSeleted: Int = 0
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var displacementLabel: UILabel!
    @IBOutlet weak var maximumSpeedLabel: UILabel!
    @IBOutlet weak var finalTranssmitionLabel: UILabel!
    @IBOutlet weak var fuelCapacityLabel: UILabel!
    @IBOutlet weak var maximunPowerLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var nameDescriptionLabel: UILabel!
    @IBOutlet weak var brandDescriptionLabel: UILabel!
    @IBOutlet weak var displacementDescriptionLabel: UILabel!
    @IBOutlet weak var maximumSpeedDescriptionLabel: UILabel!
    @IBOutlet weak var finalTranssmitionDescriptionLabel: UILabel!
    @IBOutlet weak var fuelCapacityDescriptionLabel: UILabel!
    @IBOutlet weak var maximunPowerDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupLabel(label: nameLabel, description: MOTOCYCLE_ATTRIBUTES.NAME)
        setupLabel(label: brandLabel, description: MOTOCYCLE_ATTRIBUTES.BRAND)
        setupLabel(label: displacementLabel, description: MOTOCYCLE_ATTRIBUTES.DISPLACEMENT)
        setupLabel(label: maximumSpeedLabel, description: MOTOCYCLE_ATTRIBUTES.MAXIMUN_SPEED)
        setupLabel(label: finalTranssmitionLabel, description: MOTOCYCLE_ATTRIBUTES.FINAL_TRANSSMITION)
        setupLabel(label: fuelCapacityLabel, description: MOTOCYCLE_ATTRIBUTES.FUEL_CAPACITY)
        setupLabel(label: maximunPowerLabel, description: MOTOCYCLE_ATTRIBUTES.MAXIMUN_POWER)
        
        setupDescriptionLabel(label: nameDescriptionLabel)
        setupDescriptionLabel(label: brandDescriptionLabel)
        setupDescriptionLabel(label: displacementDescriptionLabel)
        setupDescriptionLabel(label: maximumSpeedDescriptionLabel)
        setupDescriptionLabel(label: finalTranssmitionDescriptionLabel)
        setupDescriptionLabel(label: fuelCapacityDescriptionLabel)
        setupDescriptionLabel(label: maximunPowerDescriptionLabel)
        
        setupButton(button: deleteButton, iconSystemName: ICON_SYSTEM_NAMES.TRASH, iconColor: .red)
        setupButton(button: editButton, iconSystemName: ICON_SYSTEM_NAMES.PENCIL, iconColor: .blue)
        
    }
    
    
    // MARK: - Functions
    
    private func setupLabel(label: UILabel, description: String) {
        label.text = description
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
    }
    
    private func setupDescriptionLabel(label: UILabel) {
        label.text = COMMON_MESSAGES.EMPTY
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
    }
    
    private func setupButton(button: UIButton, iconSystemName: String, iconColor: UIColor) {
        button.setImage(UIImage(systemName: iconSystemName), for: .normal)
        button.tintColor = iconColor
        button.setTitle(COMMON_MESSAGES.EMPTY, for: .normal)
    }
    
    
}

//
//  Utils.swift
//  Users
//
//  Created by Axity on 06/05/20.
//  Copyright © 2020 Axity. All rights reserved.
//

import UIKit


class Utils: NSObject {
    
    func alertMessage(title: String, message: String, controller: UIViewController) -> Void{
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default))
        controller.present(alert, animated: true)
    }
}

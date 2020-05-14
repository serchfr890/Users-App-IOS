//
//  Utils.swift
//  Users
//
//  Created by Axity on 06/05/20.
//  Copyright © 2020 Axity. All rights reserved.
//

import UIKit


class Utils: NSObject{
    
    // MARK: - Functions
    func alertMessage(title: String, message: String, controller: UIViewController) -> Void{
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default))
        controller.present(alert, animated: true)
    }
}

// MARK - CONSTANTS
struct USER_LIST_VC_CONTANTS {
    static let TABLE_IDENTIFIER = "myCell"
}

struct VIEWS_CONTROLLER_IDENTIFIER {
    static let USER_DETAIL = "UserDetailVC"
    static let USER_LIST = "UserListVC"
    static let TAB_BAR = "Tab_Bar_VC"
}

struct COMMON_MESSAGES {
    static let SESSION_FAILED = "No se pudo iniciar sesión!!"
    static let INVALID_CREDENTIALS = "Las credenciales son inválidas"
    static let FUNCTIONALITY_NOT_IMPLEMENTED = "Funcionalidad no implementada"
    static let EMPTY = ""
    static let INIT_SESSION = "Iniciar sesión"
    static let FORGOTTEN_PASSWORD = "¿Olvidaste tu contraseña?"
    static let WELCOME = "Bienvenido"
    static let INVALID_MAIL = "Ingresar un correo electrónico válido"
    static let INVALID_PASSWORD = "La contraseña debe tener al menos 8 caractéres"
    static let INVALID_REGEX = "Invalid regex: "
}

struct LOGIN_FIELD_NAMES {
    static let EMAIL = "Correo electrónico"
    static let EMAIL_MOCK_VALUE = "eve.holt@reqres.in"
    static let PASSWORD = "Contraseña"
    static let PASSWORD_MOCK_VALUE = "cityslica"
}

struct DETAIL_FIELDS_NAMES {
    static let NAME = "Nombre:"
    static let SURNAME = "Apellidos:"
    static let EMAIL = "Correo electrónico:"
}

struct REGEX {
    static let MAIL = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
}

struct TAB_BAR_ITEMS {
    static let TITLE_COMTROLLER_1 = "Lista de Usuarios"
    static let TITLE_CONTROLLER_2 = "CRUD"
}

struct MOTOCYCLE_ATTRIBUTES {
    static let NAME = "Nombre: "
    static let BRAND = "Marca: "
    static let DISPLACEMENT = "Cilindrada: "
    static let MAXIMUN_SPEED = "Velocidad Máxima: "
    static let FINAL_TRANSSMITION = "Velocidades: "
    static let FUEL_CAPACITY = "Cap de combustible: "
    static let MAXIMUN_POWER = "Potencia Máxima: "
}

struct ICON_SYSTEM_NAMES {
    static let TRASH = "trash"
    static let PENCIL = "pencil"
    static let PERSON_3_FILL = "person.3.fill"
}

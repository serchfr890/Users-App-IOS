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
    static let MOTORCYCLE_TABLE_VIEW_CELL = "MotocycleTableViewCell"
    static let MOTORCYCLE_CELL = "motocycleCell"
    static let CREATE_OR_UPDATE = "CreateOrUpdate"
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
    static let CAN_NOT_DELETE_ITEM = "No se puede eliminar elemento"
    static let CAN_NOT_DELETE_ITEM_TITLE = "Lo sentimos !!!"
    static let SUCCESS_DELETE = "Se ha borrqrdo correctamente!!!"
    static let CREATE_BUTTON = "Crear"
    static let SUCCESSFUL_UPDATE = "Actualización exitosa"
    static let ERROR = "Error !!!"
    static let ERROR_UPDATE = "Lo sentimos. Hubo un error al actualizar elemento"
    static let ERROR_CREATE = "Hubo un error al crear el elemento"
    static let CANCEL_BUTTON = "Cancelar"
    static let UPDATE_BUTTON = "Actualizar"
    static let ONLY_CONTENT_TEXT = "El contenido debe ser solo texto"
    static let ONLY_CONTENT_NUMBERS = "El contenido debe ser solo números"
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
    static let ONLY_NUMBERS = "[0-9]"
    static let ONLY_TEXT = "[a-z]"
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

struct CRUD_TYPE {
    static let CREATE = "create"
    static let UPDATE = "update"
}

struct PLACEHOLDERS_CREATE_OR_UPDATE_VIEW {
    static let BRAND = "Ingresar Marca"
    static let DISSPLACEMENT = "Ingresar cilindrada"
    static let FINAL_TRANSMITION = "Ingresar # velocidades"
    static let FUEL_CAPACITY = "Ingresar capacidad de combustible"
    static let MAXIMUM_POWER = "Ingresar Caballos de fuerza"
    static let MAXIMUM_SPEED = "ngresar velocidad maxima"
    static let NAME = "Ingresar nombre"
}

struct NETWORK_CONSTANST {
    static let URL_BASE_USERS = "https://reqres.in"
    static let ENDPOINT_IDENTIFIER = "81e3457d39504d4c96dcaee48f27ee10"
    static let RESOURCE_CRUD = "motorcycles"
    static let CRUD_BASE_URL = "https://crudcrud.com/api/"
}

//
//  CrudViewController.swift
//  Users
//
//  Created by Axity on 13/05/20.
//  Copyright © 2020 Axity. All rights reserved.
//

import UIKit

class CrudViewController: UIViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: TAB_BAR_ITEMS.TITLE_CONTROLLER_2, image: UIImage(systemName: TAB_BAR_ITEMS.ICON_CONTROLLER_2), selectedImage: UIImage(systemName: TAB_BAR_ITEMS.ICON_CONTROLLER_2))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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

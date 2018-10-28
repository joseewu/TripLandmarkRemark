//
//  Coordinator.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/28.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation
import UIKit

class Coordinator {
    let appDelegate = UIApplication.shared.delegate
    let userState = UserManager.shared.isUserLogin
    func updateRootViewController() {
        if userState {
             let rootStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = rootStoryboard.instantiateViewController(withIdentifier: "BaseNavigationViewController")
            appDelegate?.window??.rootViewController = rootVC

        } else {
            let rootStoryboard:UIStoryboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
            let loginVC = rootStoryboard.instantiateViewController(withIdentifier: "TLLoginViewController")
            appDelegate?.window??.rootViewController = loginVC
        }

    }
}

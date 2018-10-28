//
//  TLLoginViewController.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/27.
//  Copyright © 2018 com.josee. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class TLLoginViewController: UIViewController {

    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["public_profile","email"]
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
}
extension TLLoginViewController:FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        UserManager.shared.login()
        
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        UserManager.shared.logOut()
    }

}

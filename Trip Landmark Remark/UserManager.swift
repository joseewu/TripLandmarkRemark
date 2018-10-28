//
//  UserManager.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/28.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import FirebaseAuth
class UserManager:NSObject {
    static var shared:UserManager = {
        let _shared = UserManager()
        return _shared
    }()
    public var user:User? {
        return getUserProfile()
    }
    public var isUserLogin:Bool = false {
        didSet {
            if oldValue != isUserLogin {
                Coordinator().updateRootViewController()
            }
        }
    }
    override init() {
        super.init()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            print(auth)
            if let _ = user {
                self.isUserLogin = true
            } else {
                self.isUserLogin = false
            }
        }
    }
    private var userToken:String? {
        return Auth.auth().currentUser?.uid
    }
    func login() {
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.isUserLogin = true
        }
    }
    func getUserProfile() -> User? {
        if let firUser = Auth.auth().currentUser {
            let user = User.init(name: firUser.displayName, userid: Auth.auth().currentUser?.uid, currentLocation: nil)
            return user
        } else {
             return nil
        }
    }
    func logOut() {
        do {
            try Auth.auth().signOut()
            FBSDKAccessToken.setCurrent(nil)
            isUserLogin = false
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

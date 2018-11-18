//
//  TLMainMapRouter.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/11/18.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation
import UIKit

class TLMainMapRouter {
    init() {
        //init
    }
    // MARK: Properties
    weak var view: UIViewController?
    // MARK: Static methods
    static func setupModule() -> UINavigationController {

        if let rootVC = UIStoryboard(name: "TLMainMapViewController", bundle: nil).instantiateViewController(withIdentifier: "TLMainMapViewController") as? TLMainMapViewController {
            let baseNavigationVC = UINavigationController(rootViewController: rootVC)
            return baseNavigationVC
        } else {
            let rootVC = TLMainMapViewController()
            let tempNavi = UINavigationController(rootViewController: rootVC)
            return tempNavi
        }
    }
    func pushUserEnterNotePage() {
        let notePage = TLUserNoteRouter.setupModule()
        view?.navigationController?.pushViewController(notePage, animated: true)
    }
    deinit{
        print("router deinit")
    }
}

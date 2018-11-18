//
//  TLUserNoteRouter.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/11/18.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation
import UIKit

class TLUserNoteRouter {
    // MARK: Properties
    weak var view: UIViewController?
    // MARK: Static methods
    static func setupModule() -> TLUserNoteViewController {
        let storyboard:UIStoryboard = UIStoryboard(name: "TripNote", bundle: nil)
        if let rootVC = storyboard.instantiateInitialViewController() as? TLUserNoteViewController {
            let router = TLUserNoteRouter()
            let presentor = TLUserNotePresentor(with: rootVC)
            presentor.router = router
            return rootVC
        }
        let anotherVC = TLUserNoteViewController()
        return anotherVC
    }
    deinit {
        print("TLUserNoteRouter deinit")
    }
}

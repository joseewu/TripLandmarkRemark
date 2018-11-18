//
//  TLUserNotePresentor.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/11/18.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation
import UIKit

class TLUserNotePresentor {
    weak var view: UIViewController!
    weak var router: TLUserNoteRouter?
    let interactor = TLMainMapInteractor()
    init(with viewController:UIViewController) {
        self.view = viewController
    }
    func didSendReport() {
        view?.navigationController?.popViewController(animated: true)
    }
    func prepareCellType() {
//        let cellTypes:[TLUserNotePageCellType] = [.name(title: "Name", name: "ocation"), .location(location: ("\(currentLocation?.latitude ?? 0)", "\(currentLocation?.longitude ?? 0)")),.note(title: "YourNote!", note: nil)]
    }
    deinit {
        print("presentor deinit")
    }
}


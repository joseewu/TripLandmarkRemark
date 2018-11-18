//
//  TLMainMapPresentor.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/11/18.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation
import UIKit
import MapKit
protocol PresentorSpec {
    associatedtype Fail
    var success: ((_ T:Array<Any>) -> Void)? {get set}
    var fail:Fail? {get set}
}
class TLMainMapPresentor:PresentorSpec {
    var fail: ((String?) -> Void)?

    var success: ((Array<Any>) -> Void)?

    typealias Fail = ((String?)->Void)

    weak var view: TLMainMapViewController!
    var router: TLMainMapRouter = TLMainMapRouter()
    let interactor = TLMainMapInteractor()
    init(with viewController:TLMainMapViewController) {
        self.view = viewController
        router.view = viewController
        getAllTripNode()
    }
    func getAllTripNode() {
        interactor.getAllTripNote { [weak self](allNote, error) in
            if let _ = allNote {
                guard let allNote = allNote as? [TripNote] else {return}
                let annotations = self?.transformToAnnotation(allNote)
                self?.success?(annotations ?? [MKAnnotation]())
            } else {
                self?.fail?(error ?? "")
            }
        }
    }
    func transformToAnnotation(_ notes:[TripNote]) -> [MKAnnotation] {
        var annotations:[MKAnnotation] = [MKAnnotation]()
        for note in notes {
            let tripNote = MDTripNoteAnnotaion(with: note, location: nil)
            let annotationImage = UIImage(named: "coffeePin")?.withRenderingMode(.alwaysTemplate)
            let noteAnnotation = TripNoteAnnotation(note: tripNote, annotationImg: annotationImage)
            annotations.append(noteAnnotation)
        }
        return annotations
    }
    func didTapButton() {
        router.pushUserEnterNotePage()
    }
    deinit {
        print("presentor deinit")
    }
}

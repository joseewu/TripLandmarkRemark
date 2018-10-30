//
//  TLMainMapViewModel.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/23.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation
import CoreLocation

public typealias BindinfAction<T:Codable> = (_ data: T?) -> ()
class TLMainMapViewModel:Dependency,Bindings {
    var output: TLMainMapViewModel.Output!

    func bind(with input: TLMainMapViewModel.Input) {

    }

    struct Output {

    }
    struct Input {
        
    }
    public var tripNotes:[TripNote] = [TripNote]() {
        didSet {
            update?(tripNotes)
        }
    }
    public var update:BindinfAction<[TripNote]>?
    private let service:TripNoteService

    required init(with service:TripNoteService) {
        self.service = service
    }
    func getAllNotes() {
        service.getAllTripNote {  (resuts, _) in
            self.tripNotes = resuts ?? [TripNote]()
            self.update?(resuts)
        }
    }
}

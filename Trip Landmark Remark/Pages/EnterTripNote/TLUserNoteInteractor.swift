//
//  TLUserNoteInteractor.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/11/18.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation

class TLUserNoteInteractor {
    private let service:TripNoteService
    init(with service:TripNoteService) {
        self.service = service
    }
    func add(note tripNote:TripNote) {
        service.postTripNote(tripNote)
    }
}

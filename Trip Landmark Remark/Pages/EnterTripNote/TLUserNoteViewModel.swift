//
//  TLUserNoteViewModel.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/24.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation

class TLUserNoteViewModel {
    private let service:TripNoteService
    var cellTypes:[TLUserNotePageCellType]?
    init(with service:TripNoteService, _ cellTypes:[TLUserNotePageCellType]) {
        self.service = service
        self.cellTypes = cellTypes
    }
    func sendUserNote(_ tripNote:TripNote) {
        service.postTripNote(tripNote)
    }
}

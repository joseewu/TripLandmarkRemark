//
//  MDTripNoteAnnotaion.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/11/18.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation

struct MDTripNoteAnnotaion {
    private(set) var locationName:String?
    let userId:Int?
    let noteId:Int?
    let latitude:Double?
    let longitude:Double?
    private(set) var note:String?
    init(with note:TripNote?, location:(Double?,Double?)?) {

        self.locationName = note?.locationName
        self.userId = note?.userId
        self.latitude = note?.latitude ?? location?.0
        self.longitude = note?.longitude ?? location?.1
        self.note = note?.note
        self.noteId = note?.noteId
    }
    mutating func updateNote(_ note:String?) {
        self.note = note
    }
    mutating func updateLocationName(_ name:String?) {
        self.locationName = name
    }
}


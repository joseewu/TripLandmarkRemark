//
//  TripNote.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/11/18.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation
import CoreLocation

struct TripNote:Codable {
    internal enum CodingKeys:String,CodingKey {
        case locationName
        case userId
        case noteId
        case latitude
        case longitude
        case note
    }

    internal(set) var locationName:String?
    let userId:Int?
    let noteId:Int?
    let latitude:Double?
    let longitude:Double?
    internal(set) var note:String?

    init(with note:MDTripNoteAnnotaion) {
        self.locationName = note.locationName
        self.userId = note.userId
        self.latitude = note.latitude
        self.longitude = note.longitude
        self.note = note.note
        self.noteId = note.noteId
    }

}
extension TripNote {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        locationName = try? container.decode(String.self, forKey: .locationName)
        userId = try? container.decode(Int.self, forKey: .userId)
        latitude = try? container.decode(Double.self, forKey: .latitude)
        longitude = try? container.decode(Double.self, forKey: .longitude)
        note = try? container.decode(String.self, forKey: .note)
        noteId = try? container.decode(Int.self, forKey: .noteId)
    }
    func encode(to encoder: Encoder) throws {

    }
}

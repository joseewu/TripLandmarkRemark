//
//  TripNote.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/22.
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
    internal(set) var latitude:Double?
    internal(set) var longitude:Double?
    internal(set) var note:String?
    mutating func updateNote(_ note:String?) {
        self.note = note
    }
    mutating func updateLocation(_ location:CLLocationCoordinate2D?) {
        self.latitude = location?.latitude
        self.longitude = location?.longitude
    }
    init(locationName:String?, userId:Int?, latitude:Double?, longitude:Double?, note:String?) {
        self.locationName = locationName
        self.userId = userId
        self.latitude = latitude
        self.longitude = longitude
        self.note = note
        self.noteId = 0
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

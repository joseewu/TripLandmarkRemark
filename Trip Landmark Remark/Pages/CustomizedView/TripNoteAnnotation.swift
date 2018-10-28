//
//  TripNoteAnnotation.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/23.
//  Copyright © 2018 com.josee. All rights reserved.
//

import UIKit
import MapKit

class TripNoteAnnotation:NSObject,MKAnnotation {
    let title: String?
    let userId:Int?
    let noteContent:String?
    var coordinate: CLLocationCoordinate2D
    private let image:UIImage?
    let color:UIColor = MainColors.TLCoffee
    init(note:TripNote, annotationImg:UIImage?) {
        self.title = note.locationName
        self.userId = note.userId
        self.noteContent = note.note
        self.coordinate = CLLocationCoordinate2D(latitude: note.latitude ?? 0, longitude: note.longitude ?? 0)
        self.image = annotationImg?.withRenderingMode(.alwaysTemplate)
        super.init()
    }
    var subtitle: String? {
        return title
    }
    var annotationImage: UIImage? {
        return image
    }
}

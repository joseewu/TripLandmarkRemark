//
//  TripNoteAnnotationView.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/23.
//  Copyright © 2018 com.josee. All rights reserved.
//

import UIKit
import MapKit
class TripNoteAnnotationView: MKAnnotationView {
    let emoji: UIImageView = UIImageView()
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? TripNoteAnnotation else {return}
            canShowCallout = false
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            if let annotationImg = artwork.annotationImage?.withRenderingMode(.alwaysTemplate) {
                image = annotationImg
            } else {
                image = nil
            }
        }
    }
//    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
//        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
//        emoji.image = UIImage(named: "plus_icon")?.withRenderingMode(.alwaysTemplate)
//        emoji.tintColor = UIColor.white
//        emoji.frame.size = CGSize(width: self.frame.size.width * 0.3, height: self.frame.size.width * 0.3)
//        emoji.frame.origin.y = self.frame.size.width * 0.3
//        emoji.frame.origin.x = self.frame.size.width * 0.3
//        tintColor = UIColor.yellow
//        layoutIfNeeded()
//        addSubview(emoji)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}

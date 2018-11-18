//
//  TLMainMapViewController.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/23.
//  Copyright © 2018 com.josee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TLMainMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
            if #available(iOS 11.0, *) {
                mapView.register(TripNoteAnnotationView.self,
                                 forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
            }
        }
    }
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var floatyButton: TLFloatButton! {
        didSet {
            floatyButton.bgColor = MainColors.TLGreen
            floatyButton.tintColor = UIColor.white
            floatyButton.iconImg = UIImage(named: "plus_icon")?.withRenderingMode(.alwaysTemplate)
        }
    }
    var presentor:TLMainMapPresentor?
    private let locationManager:CLLocationManager = CLLocationManager()
    internal var initialLocation:CLLocationCoordinate2D? {
        didSet{
            moveToUserLocation()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        renderUI()
        setLocationManager()
        presentor = TLMainMapPresentor(with: self)
        presentor?.success = { [weak self] (result) in
            guard let allAnnotation = result as? [MKAnnotation] else {return}
            self?.mapView.addAnnotations(allAnnotation)
        }
        let service = TripNoteService()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.startUpdatingLocation()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    private func setLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    private func renderUI() {
        self.title = "Trip landmark remark!"
    }
    @IBAction func addNote(_ sender: Any) {
        presentor?.didTapButton()
    }
    private func moveToUserLocation() {
        guard let currentLocation = initialLocation else {
            return
        }
        let region = MKCoordinateRegion(center: currentLocation, span: MKCoordinateSpan(latitudeDelta: 0.0275, longitudeDelta: 0.0275))

        mapView.setVisibleMapRect(mapView.visibleMapRect, edgePadding: UIEdgeInsetsMake(40.0, 20.0, 20, 20.0), animated: true)
        mapView.setRegion(region, animated: true)
        addCurrentLocation()
    }
    private func addCurrentLocation() {
    guard let currentLocation = initialLocation else {
    return
    }
        let myLocaion = mapView.annotations.filter { (item) -> Bool in
            return item.isKind(of: TripNoteAnnotation.self)
        }
        if let myLocationAnnotation = myLocaion.first as? TripNoteAnnotation {
            mapView.removeAnnotation(myLocationAnnotation)
        }
    let noteTest = MDTripNoteAnnotaion(with: nil, location: (currentLocation.latitude, currentLocation.longitude))
    let annotationImage = UIImage(named:"currentLocationPin")?.withRenderingMode(.alwaysTemplate)
    let noteAnnotation = TripNoteAnnotation(note: noteTest, annotationImg: annotationImage)
    mapView.addAnnotation(noteAnnotation)
    }
}
extension TLMainMapViewController:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            initialLocation = center
        }
    }
}

extension TLMainMapViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if #available(iOS 11.0, *) {
            guard let annotation = annotation as? TripNoteAnnotation else { return nil }
            // 3
            let identifier = "TripNoteAnnotationView"
            var view: TripNoteAnnotationView
            // 4
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? TripNoteAnnotationView {
                view = dequeuedView
            } else {
                // 5
                view = TripNoteAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.tintColor = UIColor.purple
            }
            return view

        } else {
            return nil
        }
    }
}
extension TLMainMapViewController:UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

    }
}

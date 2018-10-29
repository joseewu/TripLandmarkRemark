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
    private let locationManager:CLLocationManager = CLLocationManager()
    private var viewModel:TLMainMapViewModel?
    internal var initialLocation:CLLocationCoordinate2D? {
        didSet{
//            UserManager.shared.user?.currentLocation = ("\(initialLocation?.latitude)","\(initialLocation?.longitude)")
            moveToUserLocation()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        renderUI()
        let service = TripNoteService()
        viewModel = TLMainMapViewModel(with: service)
        viewModel?.getAllNotes()
        viewModel?.update = {[weak self] data in
            if let data = data {
                self?.addAnnotation(data)
            }
        }
        setLocationManager()
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
        performSegue(withIdentifier: "ShowTripNotePage", sender: 2)
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
    let noteTest = TripNote(locationName: "", userId: 1, latitude: currentLocation.latitude, longitude: currentLocation.longitude, note: "")
    let annotationImage = UIImage(named:"currentLocationPin")?.withRenderingMode(.alwaysTemplate)
    let noteAnnotation = TripNoteAnnotation(note: noteTest, annotationImg: annotationImage)
    mapView.addAnnotation(noteAnnotation)
    }
    private func addAnnotation(_ notes:[TripNote]) {
        var annotations:[MKAnnotation] = [MKAnnotation]()
        for note in notes {
            let tripNote = TripNote(locationName:note.locationName, userId: note.userId, latitude: note.latitude, longitude: note.longitude, note: note.note)
            let annotationImage = UIImage(named: "coffeePin")?.withRenderingMode(.alwaysTemplate)
            let noteAnnotation = TripNoteAnnotation(note: tripNote, annotationImg: annotationImage)
            annotations.append(noteAnnotation)
        }
        mapView.addAnnotations(annotations)
    }
    
    private func startTrackUser() {
        locationManager.startUpdatingLocation()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "ShowTripNotePage":
            if let vc = segue.destination as? TLUserNoteViewController {
                vc.currentLocation = initialLocation
            }
        default:
            break
        }
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
                //view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
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

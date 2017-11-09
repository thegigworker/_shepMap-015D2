/*
//
//  MapViewController.swift
//  Trax
//
//  Created by CS193p Instructor.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIPopoverPresentationControllerDelegate
{
    // MARK: Public Model

    var gpxURL: URL? {
        didSet {
            // clearWaypoints()
            mapView?.removeAnnotations(mapView.annotations)
            
            
            if let url = gpxURL {
                shepDataSource.parse(url) { gpx in
                    if gpx != nil {
                        self.addWaypoints(gpx!.shepArrayOfAnnotations)
                    }
                }
            }
        }
    }
    
    // MARK: View Controller Lifecycle
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        gpxURL = URL(string: "http://cs193p.stanford.edu/Vacation.gpx")
//    }
//    
    
    
    let locationManager = CLLocationManager()
    let initialLocation = CLLocation(latitude: THOMPSON_GPS.latitude, longitude: THOMPSON_GPS.longitude)
    // search range?
    let initialDistance = CLLocationDistance(20000)
    var mySubtitleString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create region for map
        let region1 = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, initialDistance, initialDistance)
        mapView.setRegion(region1, animated: true)
        
        searchMap("park")
        
        // create region
        //        let region2 = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, initialDistance, initialDistance)
        //        mapView.setRegion(region2, animated: true)
        
        
        // Request for a user's authorization for location services
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
    }
    
    // LocalSearchRequest
    //
    // 搜索
    func searchMap(_ place:String) {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = place
        // 搜索当前区域
        // search radius
        let span = MKCoordinateSpanMake(0.09, 0.09)
        request.region = MKCoordinateRegion(center: initialLocation.coordinate, span: span)
        //启动搜索,并且把返回结果保存到数组中
        let search = MKLocalSearch(request: request)
        search.start { (response, error) -> Void in
            guard let response = response else {
                if let error = error {
                    print(error)
                }
                return
            }
            
            let mapItems = response.mapItems
            for item in (mapItems) {
                if let myOtherVar = item.placemark.addressDictionary {
                    print ("THIS IS DICTIONARY ITEM Name: \(myOtherVar ["Name"] ?? "nada")")
                     print ("THIS IS DICTIONARY ITEM FormattedAddressLines: \(myOtherVar ["FormattedAddressLines"] ?? "nada")")
                    print ("\n")
                    
                    var tempVar = (myOtherVar ["Street"] ?? "... ") as! String
                    tempVar = tempVar + ", \(((myOtherVar ["City"] ?? "... ") as! String)), \((myOtherVar ["State"] ?? "got nothing") as! String)"
                    self.mySubtitleString = tempVar
                }
   
                self.addAnnotation(item.name!, subtitle: self.mySubtitleString, latitude: (item.placemark.location?.coordinate.latitude)!, longitude: (item.placemark.location?.coordinate.longitude)!)
            }
        }
    }
    
    func addAnnotation(_ title:String, subtitle:String, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MyAnnotation(coordinate: location, title: title, subtitle: subtitle)
        // annotation.pinTintColor
        mapView.addAnnotation(annotation)
       
    }

    
    
    // MARK: Outlets

    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            
            //mapView.mapType = .satellite
            mapView.mapType = .hybrid
            mapView.delegate = self
        }
    }
    
    // MARK: Private Implementation

//    fileprivate func clearWaypoints() {
//        mapView?.removeAnnotations(mapView.annotations)
//    }
    
    fileprivate func addWaypoints(_ shepArrayofSngAnts: [shepDataSource.shepSingleAnnotation]) {
        mapView?.addAnnotations(shepArrayofSngAnts)
        mapView?.showAnnotations(shepArrayofSngAnts, animated: true)
    }
    
    fileprivate func selectWaypoint(_ waypoint: shepDataSource.shepSingleAnnotation?) {
        if waypoint != nil {
            mapView.selectAnnotation(waypoint!, animated: true)
        }
    }

    
    // MARK: MKMapViewDelegate
    
    //        func pinTintColor() -> UIColor  {
    //            if GPX.shepSingleAnnotationData.shepsVariable <= 3 {
    //                return MKPinAnnotationView.redPinColor()
    //            } else if (GPX.shepSingleAnnotationData.shepsVariable > 3.0 && self.shepsVariable <= 10) {
    //                return MKPinAnnotationView.purplePinColor()
    //            } else {
    //                return MKPinAnnotationView.greenPinColor()
    //            }
    //        }
    
    
    //    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
    //
    //        if annotation is MKUserLocation {
    //            //return nil so map view draws "blue dot" for standard user location
    //            return nil
    //        }
    //
    //        let reuseId = "pin"
    //
    //        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
    //        if pinView == nil {
    //            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
    //            pinView!.canShowCallout = true
    //            pinView!.animatesDrop = true
    //            pinView!.pinTintColor = .purple
    //        }
    //        else {
    //            pinView!.annotation = annotation
    //        }
    //        
    //        return pinView
    //    }

    
    // from ShepMap2
    // inside:  class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIPopoverPresentationControllerDelegate
    //
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view: MKAnnotationView! = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.AnnotationViewReuseIdentifier)
        //
        let reuseId = "temp" // Constants.AnnotationViewReuseIdentifier
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinTintColor = .purple
            // pinView!.pinTintColor = GPX.shepSingleAnnotationData.pinTintColor(GPX.shepSingleAnnotationData)()
        } else {
            pinView!.pinTintColor = .green
            pinView!.annotation = annotation
        }
//        if annotation is GPX.shepSingleAnnotationData {
//            let shepsPinView: MKPinAnnotationView  = MKPinAnnotationView.redPinColor()
//            shepsPinView.pinTintColor = .purple // annotation.pinTintColor()
//            // shepsPinView.pinTintColor = annotation.pinTintColor() as! UIColor
//        }
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: Constants.AnnotationViewReuseIdentifier)
            view.canShowCallout = true
        } else {
            view.annotation = annotation
        }
        view.isDraggable = annotation is EditableWaypoint
        view.leftCalloutAccessoryView = nil
        view.rightCalloutAccessoryView = nil
        if let waypoint = annotation as? shepDataSource.shepSingleAnnotation {
            if waypoint.thumbnailURL != nil {
                view.leftCalloutAccessoryView = UIButton(frame: Constants.LeftCalloutFrame)
            }
            if waypoint is EditableWaypoint {
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
        }
        
        return view
    }
    
  
    // this is where we draw an image on the leftCalloutAccessoryView
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let thumbnailImageButton = view.leftCalloutAccessoryView as? UIButton,
            let url = (view.annotation as? shepDataSource.shepSingleAnnotation)?.thumbnailURL,
            let imageData = try? Data(contentsOf: url as URL), // blocks main queue
            let image = UIImage(data: imageData) {
            thumbnailImageButton.setImage(image, for: UIControlState())
        }
    }
    
    // calloutAccessoryControlTapped
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.leftCalloutAccessoryView {
            performSegue(withIdentifier: Constants.ShowImageSegue, sender: view)
        } else if control == view.rightCalloutAccessoryView  {
            mapView.deselectAnnotation(view.annotation, animated: true)
            performSegue(withIdentifier: Constants.EditUserWaypoint, sender: view)
        }
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination.contentViewController
        let annotationView = sender as? MKAnnotationView
        let waypoint = annotationView?.annotation as? shepDataSource.shepSingleAnnotation
        
        if segue.identifier == Constants.ShowImageSegue {
            if let ivc = destination as? ImageViewController {
                ivc.imageURL = waypoint?.imageURL
                ivc.title = waypoint?.name
            }
        } else if segue.identifier == Constants.EditUserWaypoint {
            if let editableWaypoint = waypoint as? EditableWaypoint,
                let ewvc = destination as? EditWaypointViewController {
                if let ppc = ewvc.popoverPresentationController {
                    ppc.sourceRect = annotationView!.frame
                    ppc.delegate = self
                }
                ewvc.waypointToEdit = editableWaypoint
            }
        }
    }
    
    
    // Long press gesture adds a waypoint
    @IBAction func addWaypoint(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let coordinate = mapView.convert(sender.location(in: mapView), toCoordinateFrom: mapView)
            let waypoint = EditableWaypoint(latitude: coordinate.latitude, longitude: coordinate.longitude)
            waypoint.name = "Dropped"
            mapView.addAnnotation(waypoint)
        }
    }
    
    // Unwind target (selects just-edited waypoint)
    @IBAction func updatedUserWaypoint(_ segue: UIStoryboardSegue) {
        selectWaypoint((segue.source.contentViewController as? EditWaypointViewController)?.waypointToEdit)
    }
    
    // MARK: UIPopoverPresentationControllerDelegate
    
    // when popover is dismissed, selected the just-edited waypoint
    // see also unwind target above (does the same thing for adapted UI)

    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        selectWaypoint((popoverPresentationController.presentedViewController as? EditWaypointViewController)?.waypointToEdit)
    }
    
    // if we're horizontally compact
    // then adapt by going to .OverFullScreen
    // .OverFullScreen fills the whole screen, but lets underlying MVC show through

    func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
    ) -> UIModalPresentationStyle {
        return traitCollection.horizontalSizeClass == .compact ? .overFullScreen : .none
    }
    
    // when adapting to full screen
    // wrap the MVC in a navigation controller
    // and install a blurring visual effect behind all the navigation controller draws
    // autoresizingMask is "old style" constraints
    
    func presentationController(
        _ controller: UIPresentationController,
        viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle
    ) -> UIViewController? {
        if style == .fullScreen || style == .overFullScreen {
            let navcon = UINavigationController(rootViewController: controller.presentedViewController)
            let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
            visualEffectView.frame = navcon.view.bounds
            visualEffectView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
            navcon.view.insertSubview(visualEffectView, at: 0)
            return navcon
        } else {
            return nil
        }
    }
    
    // MARK: Constants
    
    fileprivate struct Constants {
        static let LeftCalloutFrame = CGRect(x: 0, y: 0, width: 59, height: 59) // sad face
        static let AnnotationViewReuseIdentifier = "waypoint"
        static let ShowImageSegue = "Show Image"
        static let EditUserWaypoint = "Edit Waypoint"
    }
}


extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? navcon
        } else {
            return self
        }
    }
}

/*
 
 
 */*/

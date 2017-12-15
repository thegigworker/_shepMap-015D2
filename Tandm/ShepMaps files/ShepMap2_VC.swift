/*
//  MapViewController.swift
//  Trax
//
//  Created by CS193p Instructor.
//  Copyright © 2016 Stanford University. All rights reserved.
//

    func addAnnotation(_ title:String, subtitle:String, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MyAnnotation(coordinate: location, title: title, subtitle: subtitle)
        // annotation.pinTintColor
        myMapView.addAnnotation(annotation)
       
    }
    
    // MARK: Private Implementation
//    fileprivate func clearWaypoints() {
//        myMapView?.removeAnnotations(myMapView.annotations)
//    }
    
    fileprivate func addWaypoints(_ shepArrayofSngAnts: [shepDataSource.shepSingleAnnotation]) {
        myMapView?.addAnnotations(shepArrayofSngAnts)
        myMapView?.showAnnotations(shepArrayofSngAnts, animated: true)
    }
    
    fileprivate func selectWaypoint(_ waypoint: shepDataSource.shepSingleAnnotation?) {
        if waypoint != nil {
            myMapView.selectAnnotation(waypoint!, animated: true)
        }
    }

 //// from ShepMap2
    // inside:  class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIPopoverPresentationControllerDelegate
    //
    func myMapView(_ myMapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view: MKAnnotationView! = myMapView.dequeueReusableAnnotationView(withIdentifier: Constants.AnnotationViewReuseIdentifier)
        //
        let reuseId = "temp" // Constants.AnnotationViewReuseIdentifier
        
        var pinView = myMapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinTintColor = .purple
            // pinView!.pinTintColor = GPX.shepShepSingleAnnotation.pinTintColor(GPX.shepShepSingleAnnotation)()
        } else {
            pinView!.pinTintColor = .green
            pinView!.annotation = annotation
        }
//        if annotation is GPX.shepShepSingleAnnotation {
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
            let coordinate = myMapView.convert(sender.location(in: myMapView), toCoordinateFrom: myMapView)
            let waypoint = EditableWaypoint(latitude: coordinate.latitude, longitude: coordinate.longitude)
            waypoint.name = "Dropped"
            myMapView.addAnnotation(waypoint)
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
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
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
 
*/


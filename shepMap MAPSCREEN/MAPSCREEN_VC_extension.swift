//  MAPSCREEN_VC_extension.swift
//
//

import UIKit
import MapKit
import Contacts
// This adds the Contacts framework, which contains dictionary key constants such as CNPostalAddressStreetKey,
// for when you need to set the address, city or state fields of a location.

class CustomDisplayUISlider : UISlider {
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        //keeps original origin and width, changes height, you get the idea
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 4.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
    
    //while we are here, why not change the image here as well? (bonus material)
    override func awakeFromNib() {
        self.setThumbImage(UIImage(named: "displayDistanceThumb2"), for: .normal)
        super.awakeFromNib()
    }
}


//MARK: - MAPSCREEN_VC  EXTENSION
extension MAPSCREEN_VC : DataModelMapScreenDelegate {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Protocol functions
    func showValidSearchResults(validSearchResults: [ShepSingleAnnotation]) {
        print ("In showValidSearchResults, showValidSearchResults count was: \(validSearchResults.count)")
        print ("In showValidSearchResults, myDataModel.theMASTERAnnotationsArray count was: \(shepDataModel.theMASTERAnnotationsArray.count)")
        //myMapView.addAnnotations(validSearchResults)
        print ("in showValidSearchResults and doTheSearchAgain == \(doTheSearchAgain)")
        print ("in showValidSearchResults and myDataModel.theMASTERAnnotationsArray.count == \(shepDataModel.theMASTERAnnotationsArray.count) \n")
        if doTheSearchAgain == true && shepDataModel.theMASTERAnnotationsArray.count > 0 { // do two searches before showAnnotations
            doTheSearchAgain = false
        } else {
            doTheSearchAgain = true
            //myMapView.addAnnotations(validSearchResults)
            myMapView.showAnnotations(shepDataModel.theMASTERAnnotationsArray, animated: true)
        }
    }
    
    func drawNewRoute(thisRoute: MKRoute) {
        //print("drawNewRoute: \(thisRoute)")
        myDataModel.currentRoute = thisRoute
        print ("\n drawNewRoute.thisRoute:  \(String(describing: myDataModel.currentRoute))\n")
        myMapView.removeOverlays(myMapView.overlays)
        drawPolyline(theRoute: thisRoute)
        let drivingDistance = meters2miles(meters: (thisRoute.distance)) // response distance in meters
        let drivingTime = ((thisRoute.expectedTravelTime) / 60)  //expectedTravelTime is in secs
        RouteDataView.alpha = 0.9
        lblCrowFlies.text = "As crow flies: \(String(format: "%.02f", myDataModel.crowFliesDistance)) miles"
        lblDrivingDistance.text = "Driving distance: \(String(format: "%.02f", drivingDistance)) miles"
        lblDrivingTime.text = "Driving time: \(String(format: "%.02f", drivingTime)) minutes"
    }
    
    
    // MARK: - mapView DELEGATE FUNCTIONS
    
    // route polyline related
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay.isKind(of: MKCircle.self){
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.fillColor = UIColor.blue.withAlphaComponent(0.06)
            circleRenderer.strokeColor = UIColor.blue
            circleRenderer.lineWidth = 1
            return circleRenderer
        }
        // not a circle, therefore is MKPolylineRenderer
        let myLineRenderer = MKPolylineRenderer(polyline: myDataModel.currentRoute.polyline)
        if myDataModel.whichRouteStyle == "random" {
            myLineRenderer.lineWidth = 5
            myLineRenderer.strokeColor = .blue
        } else { // "gold" or anything else right now
            myLineRenderer.lineWidth = 5
            myLineRenderer.strokeColor = .red
        }
        return myLineRenderer
    }
    
    // mapView annotation calloutAccessoryControl was tapped, open Maps
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! ShepSingleAnnotation
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        // Note: Explore the MKMapItem documentation to see other launch option dictionary keys,
        // and the openMaps(with:launchOptions:) method that lets you pass an array of MKMapItem objects.
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    // Updating the Map View based on User Movement
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        myMapView.centerCoordinate = userLocation.location!.coordinate
        myUserLocation = myMapView.userLocation.location!
    }
    
    //func mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view NS_AVAILABLE(10_9, 4_0);
    
    //
    // set up compass as UIBarButtonItem, separate from map itself
    //    func setupCompassButton() {
    //        let compass = MKCompassButton(mapView: myMapView)
    //        compass.compassVisibility = .visible
    //        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: compass)
    //        myMapView.showsCompass = false
    //    }

    //MARK: - UI type functions
    func resetTwirlButtons() {
        UIView.animate(withDuration: 0.2, delay: 0.2, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.btnTwirlMenu.transform = CGAffineTransform(rotationAngle: 0.25*3.1415927)
            self.btnEasyShift.alpha = 0
            self.btnEasyShift.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            self.btnGigWalk.alpha = 0
            self.btnGigWalk.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            self.btnTaskRabbit.alpha = 0
            self.btnTaskRabbit.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            self.btnFieldAgent.alpha = 0
            self.btnFieldAgent.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            self.btnMobee.alpha = 0.0
            self.btnMobee.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            self.btnSafari.alpha = 0.0
            self.btnSafari.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            self.twirlMenuIsUntwirled = false
        }, completion: nil)
        RouteDataView.alpha = 0.0
        theGoldRouteView.alpha = 0.0
        GigIconsBackdrop.alpha = 0.0
    }
    
    func setupUserTrackingButtonAndScaleView() {
        myMapView.showsUserLocation = true
        let button = MKUserTrackingButton(mapView: myMapView)
        button.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        let scale = MKScaleView(mapView: myMapView)
        // scale.legendAlignment = .trailing
        scale.legendAlignment = .leading
        scale.translatesAutoresizingMaskIntoConstraints = false
        scale.scaleVisibility = .adaptive
        // scale.scaleVisibility = .visible // SCALE ALWAYS VISIBLE
        view.addSubview(scale)
        
        NSLayoutConstraint.activate([button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -54),
                                     button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -05),
                                     scale.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -115),
                                     scale.centerYAnchor.constraint(equalTo: button.centerYAnchor)])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination
        if let searchRadiusPopOver = controller.popoverPresentationController{
            //nv.delegate = self
            searchRadiusPopOver.delegate = self
        }
        if segue.identifier == "popoverViewSegue" {
            let mySearchRadiusViewController: searchRadiusViewController = segue.destination as! searchRadiusViewController
            mySearchRadiusViewController.mySearchDistanceSliderDelegate = self
        }
    }
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) { // func for popover
    //    if segue.identifier == "popoverViewSegue" {
    //            let vc = segue.destinationViewController
    //            vc.preferredContentSize = CGSize(width: 200, height: 300)
    //            let controller = vc.popoverPresentationController
    //            controller?.delegate = self
    //            //you could set the following in your storyboard
    //            controller?.sourceView = self.view
    //            controller?.sourceRect = CGRect(x:CGRectGetMidX(self.view.bounds), y: CGRectGetMidY(self.view.bounds),width: 315,height: 230)
    //            controller?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
    //        }
    //    }
    
    //MARK: - Helper functions
    func registerAnnotationViewClasses() {
        //myMapView.register(BikeView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        myMapView.register(SingleAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    func drawPolyline (theRoute: MKRoute) {
        self.myMapView.add(theRoute.polyline, level: MKOverlayLevel.aboveRoads)
        // self.myMapView.add(theRoute.polyline)
        let myMKMapRect = theRoute.polyline.boundingMapRect
        self.myMapView.setVisibleMapRect(myMKMapRect, edgePadding: UIEdgeInsetsMake(18.0, 18.0, 18.0, 18.0), animated: true)
    }
    /*
     func plotPolyline(route: MKRoute) {
     // 1
     mapView.addOverlay(route.polyline)
     // 2
     if mapView.overlays.count == 1 {
     mapView.setVisibleMapRect(route.polyline.boundingMapRect,
     edgePadding: UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0),
     animated: false)
     }
     // 3
     else {
     let polylineBoundingRect =  MKMapRectUnion(mapView.visibleMapRect,
     route.polyline.boundingMapRect)
     mapView.setVisibleMapRect(polylineBoundingRect,
     edgePadding: UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0),
     animated: false)
     }
     }
     plotPolyline(_:) does the following:
     Adds the MKRoute's polyline to the map as an overlay.
     If the plotted route is the first overlay, sets the map's visible area so it's just big enough to fit the overlay with 10 extra points of padding.
     If the plotted route is not the first, set the map's visible area to the union of the new and old visible map areas with 10 extra points of padding.
     */
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, myDataModel.currentDisplayDistance, myDataModel.currentDisplayDistance)
        myMapView.setRegion(coordinateRegion, animated: true)
    }
    
    // ????
    //newRegion.center.latitude = self.userCoordinate.latitude
    //newRegion.center.longitude = self.userCoordinate.longitude
    
    // Setup the area spanned by the map region:
    // We use the delta values to indicate the desired zoom level of the map,
    //      (smaller delta values corresponding to a higher zoom level).
    //      The numbers used here correspond to a roughly 8 mi
    //      diameter area.
    //
    //newRegion.span.latitudeDelta = 0.112872;
    //newRegion.span.longitudeDelta = 0.109863;
}


//// calloutAccessoryControlTapped
//func myMapView(_ myMapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//    if control == view.leftCalloutAccessoryView {
//        performSegue(withIdentifier: Constants.ShowImageSegue, sender: view)
//    } else if control == view.rightCalloutAccessoryView  {
//        myMapView.deselectAnnotation(view.annotation, animated: true)
//        performSegue(withIdentifier: Constants.EditUserWaypoint, sender: view)
//    }
//}

    /* Next, you have to tell MapKit what to do when the user taps the callout button.
     When the user taps a map annotation marker, the callout shows an info button. If the user taps this info button, the myMapView(_:annotationView:calloutAccessoryControlTapped:) method is called.
     In this method, you grab the ShepSingleAnnotation object that this tap refers to, and then launch the Maps app by creating an associated MKMapItem, and calling openInMaps(launchOptions:) on the map item.
     Notice you’re passing a dictionary to this method. This allows you to specify a few different options; here the DirectionModeKey is set to Driving. This causes the Maps app to show driving directions from the user’s current location to this pin. Neat!
     */
    
    /*  Configuring the Annotation View
     One way to configure the annotation view is to implement the map view’s myMapView(_:viewFor:) delegate method. Your job in this delegate method is to return an instance of MKAnnotationView, to present as a visual indicator of the annotation.
     In this case, ViewController will be the delegate for the map view. To avoid clutter and improve readability, you’ll create an extension of the ViewController class.
     */

    
// Shep:  we're currently using an alternative way to set up annotations.  We're using the separate class SingleAnnotationView
// And we're registering using the map view’s default reuse identifier with myMapView.register --- registerAnnotationViewClasses
// Below is a commented out alternative way to set up annotations -- HAS GOOD TEXT COMMENTS
// ------------
//    func myMapView(_ myMapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        // 2
//       // Your app might use other annotations, like user location, so check that this annotation is an ShepSingleAnnotation object.
//        // If it isn’t, return nil to let the map view use its default annotation view.
//        guard let annotation = annotation as? ShepSingleAnnotation else { return nil }
//        // 3
//       // To make markers appear, you create each view as an MKMarkerAnnotationView.
//        // Later in this tutorial, you’ll create MKAnnotationView objects, to display images instead of markers.
//        let identifier = "marker"
//        var view: MKMarkerAnnotationView
//        /* 4
//        Note: When you dequeue a reusable annotation, you give it an identifier. If you have multiple styles of annotations, be sure to have a unique identifier for each one, otherwise you might mistakenly dequeue an identifier of a different type, and have unexpected behavior in your app.
//         */
//        if let dequeuedView = myMapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//            as? MKMarkerAnnotationView {
//            dequeuedView.annotation = annotation
//            view = dequeuedView
//        } else {
//            // 5
//            // Here you create a new MKMarkerAnnotationView object, if an annotation view could not be dequeued.
//            // It uses the title and subtitle properties of your ShepSingleAnnotation class to determine what to show in the callout.
//            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            view.canShowCallout = true
//            view.calloutOffset = CGPoint(x: -5, y: 5)
//            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        }
//        return view
//    }


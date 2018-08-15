//  MAPSCREEN_VC.swift
//
//

//let THOMPSON_GPS = (latitude: 41.93636, longitude: -71.79837)
//Old North Church Boston, MA   42.366364, -71.054389
//Yankee Stadium, New York, NY  40.830304, -73.926089
//Wrigley Field, Chicago, IL.   41.948450, -87.655329
//Transamerica Pyramid,  San Francisco, CA.  37.795315, -122.402833
//The Alamo, Alamo Plaza, San Antonio, TX.    29.425976, -98.486139
//Kurt Cobain's house: Seattle, WA  47.619281, -122.282161
//McCoy Tamler's apartment, Corte Madera, CA.  37.928940, -122.526666
//Obama's birthplace in Oahu,Hawaii, 6085 Kalanianaole Hwy:  21.285900, -157.723680
//Sarah Palin's street in Wasilla, Alaska   61.577718, -149.492511

import UIKit
import MapKit
import Contacts
// This adds the Contacts framework, which contains dictionary key constants such as CNPostalAddressStreetKey,
// for when you need to set the address, city or state fields of a location.
import os.log
//This imports the unified logging system. Like the print() function, the unified logging system lets you send messages to the console.
//However, the unified logging system gives you more control over when messages appear and how they are saved.
//For more information on the unified logging system, see Logging Reference.


class MAPSCREEN_VC: UIViewController, MKMapViewDelegate, DataModel4MapScreenDelegate, UIPopoverPresentationControllerDelegate {
    
    //MARK: - Properties
    let myDataModel = shepDataModel()
    var twirlMenuIsUntwirled: Bool = false
    var searchDistanceCircle:MKCircle!
    var doTheSearchAgain = true
    //var myMAPSCREEN_VC2 = MAPSCREEN_VC2()

    
    //MARK: - @IBActions
    
//    @IBAction func showPopOver(){
//       // popoverView.contentViewController.preferredContentSize =  CGSizeMake(320, 1400)
//        self.performSegue(withIdentifier: "popoverViewSegue", sender: self)
//    }
    
    @IBAction func DisplayDistanceSliderMoved(_ sender: UISlider) {
        // Get Float value from Slider when it is moved.
        let value = DisplayDistanceSlider.value
        myDataModel.currentDisplayDistance = miles2meters(miles: Double(value))
        let mapRegion1 = MKCoordinateRegionMakeWithDistance(myMapView.centerCoordinate, myDataModel.currentDisplayDistance, myDataModel.currentDisplayDistance)
        //let mapRegion1 = MKCoordinateRegionMakeWithDistance(myMapView.centerCoordinate, myDataModel.currentDisplayDistance * 20, myDataModel.currentDisplayDistance * 20)
//        let mapRegion1 = MKCoordinateRegionMakeWithDistance(myUserLocation.coordinate, myDataModel.currentDisplayDistance * 2, myDataModel.currentDisplayDistance * 2)
        myMapView.setRegion(mapRegion1, animated: true)
    }
    
    @IBAction func SearchDistanceSliderMoved(_ sender: UISlider) {
        let value = SearchDistanceSlider.value
        SearchRadiusText.text = String(format: "%.01f", value) + " mi."
        myDataModel.currentSearchDistance = miles2meters(miles: Double(value))
        //myDataModel.currentSearchDistance = miles2meters(miles: Double(value))
        if searchDistanceCircle != nil {myMapView.remove(searchDistanceCircle)}
        searchDistanceCircle = MKCircle(center: myUserLocation.coordinate, radius:CLLocationDistance(myDataModel.currentSearchDistance))
        myMapView.add(searchDistanceCircle)
        
    }
    
    @IBAction func touchDOWNInSearchDistanceSlider(_ sender: UISlider) {
        print ("Touch DOWN in slider.")
    }

    @IBAction func touchUPInSearchDistanceSlider(_ sender: UISlider) {
        print ("Touch UP in slider.")
        if searchDistanceCircle != nil {myMapView.remove(searchDistanceCircle)}
    }
    
    @IBAction func btnToggleMapType(_ sender: UIButton) {
        let whichMapTypeValue = myMapView.mapType.rawValue
        //whichMapTypeValue == 0 == myMapView.mapType.standard
        if whichMapTypeValue != 0 {
            myMapView.mapType = .standard
        } else {
            myMapView.mapType = .hybrid
        }
    }
    
    @IBAction func btnClearMap(_ sender: UIButton) {
        myMapView.removeOverlays(myMapView.overlays)
        myMapView.removeAnnotations(myMapView.annotations)
        RouteDataView.alpha = 0.0
        theGoldRouteView.alpha = 0.0
        myDataModel.whichRouteStyle = ""
        myDataModel.shepAnnotationsArray.removeAll()
    }
    
    @IBAction func btnClearRoute(_ sender: Any) {
        myMapView.removeOverlays(myMapView.overlays)
        RouteDataView.alpha = 0.0
        theGoldRouteView.alpha = 0.0
    }
    
    @IBAction func btnXChangeHeight(_ sender: Any) {
//        let tempTranslator = Double(CLLocationDistance(DisplayDistanceSlider.value))
//        print ("currentDisplayDistance is \(String(format: "%.02f", tempTranslator))")
//        let tempTranslator2 = meters2miles(meters: myDataModel.currentDisplayDistance)
//        print ("currentDisplayDistance is \(String(format: "%.02f", tempTranslator2))")

//        // create region for map
        
//        let mapRegion1 = MKCoordinateRegionMakeWithDistance(myUserLocation.coordinate, myDataModel.currentDisplayDistance, myDataModel.currentDisplayDistance)
//
//        myMapView.setRegion(mapRegion1, animated: true)
    }
    
    @IBAction func btnMakeRandomRoute(_ sender: UIButton) {
        if myDataModel.shepAnnotationsArray.count < 2 {
            print ("less than 2 items in shepAnnotationsArray \n")
            return
        }
        let howMany = UInt32(myDataModel.shepAnnotationsArray.count)
        //for _ in shepAnnotationsArray {
        let sourceAnnotation = Int(arc4random_uniform(howMany))
        let destinationItem = Int(arc4random_uniform(howMany))
        if sourceAnnotation != destinationItem {
            myDataModel.whichRouteStyle = "random"
            //print ("thisisCrowFliesDistanceInMiles:  \(myRouteData.thisisCrowFliesDistanceInMiles)")
            myDataModel.howManyRouteInfosCompleted = 0
            myDataModel.getRouteInfoVia2Annotations(source: myDataModel.shepAnnotationsArray[sourceAnnotation], destination: myDataModel.shepAnnotationsArray[destinationItem])
            theGoldRouteView.alpha = 0.0
            RouteDataView.alpha = 0.9
            //let myRoute = myDataModel.currentRoute
            //drawNewRoute(thisRoute: myRoute)
        } else { print ("\n source and destination are the same \n") }
    }

//    func didReceiveMethodCallFromDataModel() {
//        print("In ViewController, didReceiveMethodCallFromDataModel happenned")
//    }
//
//    func didReceiveDataUpdate(data: String) {
//        print ("In ViewController, didReceiveDataUpdate was: \(data)")
//    }
 
    @IBAction func btnMakeGoldRoute(_ sender: UIButton) {
        if myDataModel.shepAnnotationsArray.count < 1 {
            print ("in btnMaketheGoldRoute NO items in shepAnnotationsArray \n")
            return
        }

        if myDataModel.shepAnnotationsArray.count < 2 {
            print ("less than 2 items in shepAnnotationsArray \n")
            return
        }
        
        let myChosenGoldAnnotation = myDataModel.choosetheGoldRoute()
        //let destinationAnnotation_location = CLLocation(latitude: mytheChosenRoute.coordinate.latitude, longitude: mytheChosenRoute.coordinate.longitude)
        let myTitle = myChosenGoldAnnotation.title
        let myDrivingDistance = myChosenGoldAnnotation.routeDrivingDistance
        let routeExpense : Double = myDrivingDistance * Double(myDataModel.centsPerMileExpense)/100
        let myGoldRouteScore = myChosenGoldAnnotation.routeProfit
        //getRouteInfoVia2Annotations
        //let myFormattedtheChosenRouteScore = (shepCurrencyFromDouble(shepNumber: mytheChosenRouteScore))
        //print ("-mytheChosenRouteScore \(myFormattedtheChosenRouteScore) ---  \(myFormattedtheChosenRouteScore) \n        --------------")
        lblPay.text = "PAY:           \(String(describing: myTitle!))"
        lblExpense.text = "EXPENSE:  \(shepCurrencyFromDouble(shepNumber: routeExpense))      (60¢ / mile)"
        lblEarning.text = "EARNING: \(shepCurrencyFromDouble(shepNumber: myGoldRouteScore))"
        myDataModel.whichRouteStyle = "gold"
        //myDataModel.getRouteInfoVia2Annotations(source: sourceAnnotation, destination: mytheChosenRoute)
        drawNewRoute(thisRoute: myChosenGoldAnnotation.currentLinkedRoute)
        theGoldRouteView.alpha = 0.9
        RouteDataView.alpha = 0.9
    }
    
    //MARK: - @IBActions re twirl button
    @IBAction func twirlButtonTapped(_ sender: AnyObject) {
        if twirlMenuIsUntwirled == false {
        
        UIView.animate(withDuration: 0.1, delay: 0.05, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.btnTwirlMenu.transform = CGAffineTransform(rotationAngle: 0)
            
            self.btnGigWalk.alpha = 1.0
            self.btnGigWalk.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: 60, y: 165))
            self.btnFieldAgent.alpha = 1.0
            self.btnFieldAgent.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: 160, y: 165))
            self.btnSafari.alpha = 1.0
            self.btnSafari.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: 260, y: 165))
            self.btnEasyShift.alpha = 1.0
            self.btnEasyShift.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: 60, y: 275))
            self.btnTaskRabbit.alpha = 1.0
            self.btnTaskRabbit.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: 160, y: 275))
            self.btnMobee.alpha = 1.0
            self.btnMobee.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: 260, y: 275))
            self.twirlMenuIsUntwirled = true
        }, completion: nil)
            self.GigIconsBackdrop.alpha = 0.8
        } else {
            resetTwirlButtons()
        }
    }
    
    @IBAction func btnGigwalkClick(_ sender: AnyObject) {
        myGigSource = GigSource.GigWalk
        myDataModel.buildShepAnnotationsArrayViaAppleLocalSearch (searchString: "McDonalds")
        myDataModel.buildShepAnnotationsArrayViaAppleLocalSearch (searchString: "Burger King")
        resetTwirlButtons()
    }
    
    @IBAction func btnEasyShiftClick(_ sender: AnyObject) {
        myGigSource = GigSource.EasyShift
        myDataModel.buildShepAnnotationsArrayViaAppleLocalSearch (searchString: "Target")
        myDataModel.buildShepAnnotationsArrayViaAppleLocalSearch (searchString: "Walmart")
        resetTwirlButtons()
    }
    
    @IBAction func btnFieldAgentClick(_ sender: AnyObject) {
        myGigSource = GigSource.FieldAgent
        myDataModel.buildShepAnnotationsArrayViaAppleLocalSearch (searchString: "gas station")
        myDataModel.buildShepAnnotationsArrayViaAppleLocalSearch (searchString: "market")
        resetTwirlButtons()
    }
    
    @IBAction func btnSafariClick(_ sender: AnyObject) {
        myGigSource = GigSource.Safari
        myDataModel.buildShepAnnotationsArrayViaAppleLocalSearch (searchString: "Pub")
        myDataModel.buildShepAnnotationsArrayViaAppleLocalSearch (searchString: "Diner")
        resetTwirlButtons()
    }
    
    @IBAction func btnMobeeClick(_ sender: AnyObject) {
        myGigSource = GigSource.Mobee
        myDataModel.buildShepAnnotationsArrayViaAppleLocalSearch (searchString: "Lowes")
        myDataModel.buildShepAnnotationsArrayViaAppleLocalSearch (searchString: "Home Depot")
        resetTwirlButtons()
    }
    
    @IBAction func btnTaskRabbit(_ sender: AnyObject) {
        myGigSource = GigSource.TaskRabbit
        myDataModel.buildShepAnnotationsArrayViaAppleLocalSearch (searchString: "pizza")
        myDataModel.buildShepAnnotationsArrayViaAppleLocalSearch (searchString: "bbq")
        resetTwirlButtons()
    }
    
    //MARK: - popoverPresentationController functions
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }

    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        print ("Dismissed")
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    //    internal func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    //        return .none
    //    }
    
//    //MARK: - Location functions
    // Create a location manager to trigger user tracking
    let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        return manager
    }()
    
    //    You have to override CLLocationManager.didUpdateLocations (part of CLLocationManagerDelegate) to get notified when the location manager retrieves the current location:
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        // DOESN'T SEEM TO BE GETTING CALLED??
        let currentLocation = locations.last as! CLLocation
        myUserLocation = currentLocation
        //myUserLocation = CLLocation(latitude: THOMPSON_GPS.latitude, longitude: THOMPSON_GPS.longitude)
    }
    

//    //  THIS IS SUPPOSED TO BE ABLE TO DETECT TAPS ON THE MAPVIEW, but I haven't gotten it to work
//    //
//    //    In ViewWillAppear method :
//    //          let gestureRecognizer = UITapGestureRecognizer(target: self, action:"mapViewTapped:")
//    //          mapView.addGestureRecognizer(gestureRecognizer)
//    //
//    //    And Whatever information you want to show just add code in following method :
//    //          func mapViewTapped(gestureReconizer: UITapGestureRecognizer) {
//    //              //Add alert to show it works
//    //          }
//    //   ////////////////////
    
    ////    FUNC HANDLETHECHOSENROUTE(thisRoute: MKRoute) {
    //        print("handletheChosenRoute: \(thisRoute)")
    //        myDataModel.currentLinkedRoute = thisRoute
    //        print ("handletheChosenRoute.thisRoute:  \(String(describing: myDataModel.currentLinkedRoute))")
    //        myMapView.removeOverlays(myMapView.overlays)
    //        drawPolyline(theRoute: thisRoute)
    //        let drivingDistance = meters2miles(meters: (thisRoute.distance)) // response distance in meters
    //        let drivingTime = ((thisRoute.expectedTravelTime) / 60)  //expectedTravelTime is in secs
    //        RouteDataView.alpha = 1
    //        lblCrowFlies.text = "As crow flies: \(String(format: "%.02f", myDataModel.crowFliesDistance)) miles"
    //        lblDrivingDistance.text = "Driving distance: \(String(format: "%.02f", drivingDistance)) miles"
    //        lblDrivingTime.text = "Driving time: \(String(format: "%.02f", drivingTime)) minutes"
    //    }
    
    
    
    ////////////////////////////////////////
    // When a view controller is loaded from a storyboard, the system instantiates the view hierarchy and assigns the appropriate values to all the view controller’s outlets. By the time the view controller’s viewDidLoad() method is called, the system has assigned valid values to all of the controller’s outlets, and you can safely access their contents.
    
    //MARK: - viewDidLoad()
    // When a view controller is loaded from a storyboard, the system instantiates the view hierarchy and assigns the appropriate values to all the view controller’s outlets. By the time the view controller’s viewDidLoad() method is called, the system has assigned valid values to all of the controller’s outlets, and you can safely access their contents.
    override func viewDidLoad() {
        super.viewDidLoad()
        myDataModel.myDataModel4MapScreenDelegate = self
        //Comparing to the callback way, Delegation pattern is easier to reuse across the app: you can create a base class that conforms to the protocol delegate and avoid code redundancy. However, delegation is harder to implement: you need to create a protocol, set the protocol methods, create Delegate property, assign Delegate to ViewController, and make this ViewController conform to the protocol. Also, the Delegate has to implement every method of the protocol by default.
        
        // A DELEGATE is an object that acts on behalf of, or in coordination with, another object. The delegating object—in this case, the text field—keeps a reference to the other object—the delegate—and at the appropriate time, the delegating object sends a message to the delegate. The message tells the delegate about an event that the delegating object is about to handle or has just handled.
        // "Setting ViewController as the delegate of the map view.  You can do this in Main.storyboard, but I prefer to do it in code, where it’s more visible."
        myMapView.delegate = self
        
        //        print ("in **viewDidLoad** shepAnnotationsArray count is \(myDataModel.shepAnnotationsArray.count) \n")
        //        print ("in ***viewDidLoad BEFORE SEARCH Current search distance: \(meters2miles(meters: myDataModel.currentSearchDistance))")
       // myDataModel.buildShepAnnotationsArrayViaAppleLocalSearch(searchString: "park")
        //        print ("in viewDidLoad AFTER SEARCH shepAnnotationsArray count is \(myDataModel.shepAnnotationsArray.count)")
        //        print ("in ***viewDidLoad AFTER SEARCH Current search distance: \(meters2miles(meters: myDataModel.currentSearchDistance))")
        
        setupUserTrackingButtonAndScaleView()
        registerAnnotationViewClasses()
        centerMapOnLocation(location: myUserLocation)
        
        btnGigWalk.layer.cornerRadius = 10
        btnEasyShift.layer.cornerRadius = 10
        btnTaskRabbit.layer.cornerRadius = 10
        btnFieldAgent.layer.cornerRadius = 10
        btnTwirlMenu.layer.cornerRadius = 10
        btnMobee.layer.cornerRadius = 10
        btnSafari.layer.cornerRadius = 10
        
        DisplayDistanceSlider.value = Float(initialDisplay)
        print ("initialDisplay is: \(initialDisplay)")
        SearchDistanceSlider.value = Float(initialSearch)
        print ("SearchDistanceSlider.value: \(SearchDistanceSlider.value)")
        SearchRadiusText.text = String(initialSearch) + " mi."
        theGoldRouteView.layer.cornerRadius = 10
        RouteDataView.layer.cornerRadius = 10
        GigIconsBackdrop.layer.cornerRadius = 10
        GigIconsBackdrop.alpha = 0.0
        theGoldRouteView.alpha = 0.0
        RouteDataView.alpha = 0.0
        
        //set up the twirl button
        UIView.animate(withDuration: 0.2, delay: 0.2, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.btnTwirlMenu.alpha = 1
            self.btnTwirlMenu.transform = CGAffineTransform(rotationAngle: 0.25*3.1415927)
        }, completion: nil)
    }
    
    //MARK: - @IBOutlets
    @IBOutlet weak var myMapView: MKMapView!
    //    @IBOutlet weak var myMapView: MKMapView! {
    //        didSet {
    //            myMapView.mapType = .hybrid
    //            myMapView.delegate = self
    //        }
    //    }
    
    @IBOutlet weak var btnGigWalk: UIButton!
    @IBOutlet weak var lblGigwalk: UILabel!
    @IBOutlet weak var btnEasyShift: UIButton!
    @IBOutlet weak var btnFieldAgent: UIButton!
    @IBOutlet weak var btnTaskRabbit: UIButton!
    @IBOutlet weak var btnMobee: UIButton!
    @IBOutlet weak var btnSafari: UIButton!
    @IBOutlet weak var btnTwirlMenu: UIButton!
    @IBOutlet weak var btnXChangeHeight: UIButton!
    @IBOutlet weak var btnClearMap: UIButton!
    @IBOutlet weak var SearchDistanceSlider: UISlider!
    @IBOutlet weak var DisplayDistanceSlider: UISlider! {
        didSet{       // rotate slider
            DisplayDistanceSlider.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        }
    }
    @IBOutlet weak var SearchRadiusText: UILabel!
    @IBOutlet weak var RouteDataView: UIView!
    @IBOutlet weak var GigIconsBackdrop: UIView!
    @IBOutlet weak var theGoldRouteView: UIView!
    @IBOutlet weak var lblCrowFlies: UILabel!
    @IBOutlet weak var lblDrivingDistance: UILabel!
    @IBOutlet weak var lblDrivingTime: UILabel!
    @IBOutlet weak var lblPay: UILabel!
    @IBOutlet weak var lblExpense: UILabel!
    @IBOutlet weak var lblEarning: UILabel!
    
}

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


protocol showRouteInfoDelegate {
    func showRouteInfo (asCrowFlies: String, DrivingDistance: String, DrivingTime: String)
    func showGoldRouteInfo (Pay: String, Expense: String, Earning: String)
    func clearRouteInfo()
}

class MAPSCREEN_VC: UIViewController, MKMapViewDelegate {
    
    //MARK: - Properties
    let myDataModel = shepDataModel()
    var myshowRouteInfoDelegate: showRouteInfoDelegate?  // wouldn't let me make this a "weak" variable.  Why?
    var twirlMenuIsUntwirled: Bool = false
    var searchDistanceCircle:MKCircle!
    var doTheSearchAgain = true
    //var myMAPSCREENRouteInfo : whichRouteInfo = .Route
    var myChosenGoldAnnotation : ShepSingleAnnotation?
    
    //MARK: - @IBActions
    
    @IBAction func DisplayDistanceSliderMoved(_ sender: UISlider) {
        // Get Float value from Slider when it is moved.
        let value = DisplayDistanceSlider.value * 2
        myDataModel.currentDisplayDistance = miles2meters(miles: Double(value))
        let mapRegion1 = MKCoordinateRegionMakeWithDistance(myMapView.centerCoordinate, myDataModel.currentDisplayDistance, myDataModel.currentDisplayDistance)
        myMapView.setRegion(mapRegion1, animated: true)
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
        //myMAPSCREENRouteInfo = .None
        myDataModel.whichRouteStyle = ""
        shepDataModel.theMASTERAnnotationsArray.removeAll()
        shepDataModel.MASTERAnnotationsArrayUpdated = true
        myshowRouteInfoDelegate?.clearRouteInfo()
    }
    
    @IBAction func btnClearRoute(_ sender: Any) {
        myMapView.removeOverlays(myMapView.overlays)
        myshowRouteInfoDelegate?.clearRouteInfo()
    }
    
    @IBAction func btnTempButton(_ sender: Any) {

    }
    
    @IBAction func btnMakeRandomRoute(_ sender: UIButton) {
        if shepDataModel.theMASTERAnnotationsArray.count < 2 {
            print ("less than 2 items in theMASTERAnnotationsArray \n")
            return
        }
        let howMany = UInt32(shepDataModel.theMASTERAnnotationsArray.count)
        //for _ in theMASTERAnnotationsArray {
        let sourceAnnotation = Int(arc4random_uniform(howMany))
        let destinationItem = Int(arc4random_uniform(howMany))
        if sourceAnnotation != destinationItem {
            myDataModel.whichRouteStyle = "route"
            //print ("thisisCrowFliesDistanceInMiles:  \(myRouteData.thisisCrowFliesDistanceInMiles)")
            myDataModel.howManyRouteInfosCompleted = 0
            myDataModel.getRouteInfoVia2Annotations(source: shepDataModel.theMASTERAnnotationsArray[sourceAnnotation], destination: shepDataModel.theMASTERAnnotationsArray[destinationItem])
            //myMAPSCREENRouteInfo = .Route
            if (myshowRouteInfoDelegate) != nil {
                let thisRoute = myDataModel.currentRoute
                let drivingDistance = meters2miles(meters: (thisRoute.distance)) // response distance in meters
                let drivingTime = ((thisRoute.expectedTravelTime) / 60)  //expectedTravelTime is in secs
                let crowFlies = "As crow flies: \(String(format: "%.02f", myDataModel.crowFliesDistance)) miles"
                let theDrivingDistance = "Driving distance: \(String(format: "%.02f", drivingDistance)) miles"
                let theDrivingTime = "Driving time: \(String(format: "%.02f", drivingTime)) minutes"
                myshowRouteInfoDelegate?.showRouteInfo(asCrowFlies: crowFlies, DrivingDistance: theDrivingDistance, DrivingTime: theDrivingTime)
            }
        } else { print ("\n source and destination are the same \n") }
    }
 

    @IBAction func btnMakeGoldRoute(_ sender: UIButton) {
        if shepDataModel.theMASTERAnnotationsArray.count < 1 {
            print ("in btnMaketheGoldRoute NO items in theMASTERAnnotationsArray \n")
            return
        }

        if shepDataModel.theMASTERAnnotationsArray.count < 2 {
            print ("less than 2 items in theMASTERAnnotationsArray \n")
            return
        }
        
        myChosenGoldAnnotation = myDataModel.choosetheGoldRoute()
        myDataModel.whichRouteStyle = "gold"
        drawNewRoute(thisRoute: (myChosenGoldAnnotation?.currentLinkedRoute)!)
        
        let myTitle = myChosenGoldAnnotation?.title
        let myDrivingDistance = myChosenGoldAnnotation?.routeDrivingDistance
        let routeExpense : Double = (myDrivingDistance)! * Double(myDataModel.centsPerMileExpense)/100
        let myGoldRouteScore = myChosenGoldAnnotation?.routeProfit
        let thePay = "PAY:           \(String(describing: myTitle!))"
        let theExpense = "EXPENSE:  \(shepCurrencyFromDouble(shepNumber: routeExpense))      (60¢ / mile)"
        let theEarning = "EARNING: \(shepCurrencyFromDouble(shepNumber: myGoldRouteScore!))"
        myshowRouteInfoDelegate?.showGoldRouteInfo(Pay: thePay, Expense: theExpense, Earning: theEarning)
        
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
        myDataModel.buildMASTERAnnotationsArrayViaAppleLocalSearch (searchString: "McDonalds")
        myDataModel.buildMASTERAnnotationsArrayViaAppleLocalSearch (searchString: "Burger King")
        resetTwirlButtons()
    }
    
    @IBAction func btnEasyShiftClick(_ sender: AnyObject) {
        myGigSource = GigSource.EasyShift
        myDataModel.buildMASTERAnnotationsArrayViaAppleLocalSearch (searchString: "Target")
        myDataModel.buildMASTERAnnotationsArrayViaAppleLocalSearch (searchString: "Walmart")
        resetTwirlButtons()
    }
    
    @IBAction func btnFieldAgentClick(_ sender: AnyObject) {
        myGigSource = GigSource.FieldAgent
        myDataModel.buildMASTERAnnotationsArrayViaAppleLocalSearch (searchString: "gas station")
        myDataModel.buildMASTERAnnotationsArrayViaAppleLocalSearch (searchString: "market")
        resetTwirlButtons()
    }
    
    @IBAction func btnSafariClick(_ sender: AnyObject) {
        myGigSource = GigSource.Safari
        myDataModel.buildMASTERAnnotationsArrayViaAppleLocalSearch (searchString: "Pub")
        myDataModel.buildMASTERAnnotationsArrayViaAppleLocalSearch (searchString: "Diner")
        resetTwirlButtons()
    }
    
    @IBAction func btnMobeeClick(_ sender: AnyObject) {
        myGigSource = GigSource.Mobee
        myDataModel.buildMASTERAnnotationsArrayViaAppleLocalSearch (searchString: "Lowes")
        myDataModel.buildMASTERAnnotationsArrayViaAppleLocalSearch (searchString: "Home Depot")
        resetTwirlButtons()
    }
    
    @IBAction func btnTaskRabbit(_ sender: AnyObject) {
        myGigSource = GigSource.TaskRabbit
        myDataModel.buildMASTERAnnotationsArrayViaAppleLocalSearch (searchString: "pizza")
        myDataModel.buildMASTERAnnotationsArrayViaAppleLocalSearch (searchString: "bbq")
        resetTwirlButtons()
    }
    
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
        myDataModel.myDataModelMapScreenDelegate = self
        //Comparing to the callback way, Delegation pattern is easier to reuse across the app: you can create a base class that conforms to the protocol delegate and avoid code redundancy. However, delegation is harder to implement: you need to create a protocol, set the protocol methods, create Delegate property, assign Delegate to ViewController, and make this ViewController conform to the protocol. Also, the Delegate has to implement every method of the protocol by default.
        
        // A DELEGATE is an object that acts on behalf of, or in coordination with, another object. The delegating object—in this case, the text field—keeps a reference to the other object—the delegate—and at the appropriate time, the delegating object sends a message to the delegate. The message tells the delegate about an event that the delegating object is about to handle or has just handled.
        // "Setting ViewController as the delegate of the map view.  You can do this in Main.storyboard, but I prefer to do it in code, where it’s more visible."
        myMapView.delegate = self
        
        //        print ("in **viewDidLoad** theMASTERAnnotationsArray count is \(myDataModel.theMASTERAnnotationsArray.count) \n")
        //        print ("in ***viewDidLoad BEFORE SEARCH Current search distance: \(meters2miles(meters: myDataModel.currentSearchDistance))")
       // myDataModel.buildMASTERAnnotationsArrayViaAppleLocalSearch(searchString: "park")
        //        print ("in viewDidLoad AFTER SEARCH theMASTERAnnotationsArray count is \(myDataModel.theMASTERAnnotationsArray.count)")
        //        print ("in ***viewDidLoad AFTER SEARCH Current search distance: \(meters2miles(meters: myDataModel.currentSearchDistance))")
        
        setupUserTrackingButtonAndScaleView()
        registerAnnotationViewClasses()
        centerMapOnLocation(location: myUserLocation)
        
//        btnGigWalk.layer.cornerRadius = 10
//        btnEasyShift.layer.cornerRadius = 10
//        btnTaskRabbit.layer.cornerRadius = 10
//        btnFieldAgent.layer.cornerRadius = 10
//        btnTwirlMenu.layer.cornerRadius = 10
//        btnMobee.layer.cornerRadius = 10
//        btnSafari.layer.cornerRadius = 10
        
        DisplayDistanceSlider.value = Float(initialDisplay)
        print ("initialDisplay is: \(initialDisplay)")

        GigIconsBackdrop.alpha = 0.0
        
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
    
    @IBOutlet weak var GigIconsBackdrop: UIView!
    @IBOutlet weak var btnGigWalk: UIButton!
    @IBOutlet weak var lblGigwalk: UILabel!
    @IBOutlet weak var btnEasyShift: UIButton!
    @IBOutlet weak var btnFieldAgent: UIButton!
    @IBOutlet weak var btnTaskRabbit: UIButton!
    @IBOutlet weak var btnMobee: UIButton!
    @IBOutlet weak var btnSafari: UIButton!
    @IBOutlet weak var btnTwirlMenu: UIButton!
    @IBOutlet weak var btnClearMap: UIButton!
    @IBOutlet weak var DisplayDistanceSlider: UISlider! {
        didSet{       // rotate slider
            DisplayDistanceSlider.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        }
    }
    
}

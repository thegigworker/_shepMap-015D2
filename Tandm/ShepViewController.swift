//  ShepMapController.swift
//
//let THOMPSON_GPS = (latitude: 41.93636, longitude: -71.79837)
//HARTFORD_GPS = (latitude: 41.767603, longitude: -72.684036)
//109 Pixley Ave, Corte Madera, CA.  37.928940, -122.526666
//Transamerica Pyramid,  San Francisco, CA.  37.795315, -122.402833
//Yankee Stadium:  40.830304, -73.926089// Honolulu    CLLocation(latitude: 21.282778, longitude: -157.829444)
//Wrigley Field, Chicago, IL.   41.948450, -87.655329
//The Alamo, Alamo Plaza, San Antonio, TX.    29.425976, -98.486139
//Supreme Court Building, Washington, DC.  38.890734, -77.004214
//Kurt Cobain's House: 151 Lake Washington Blvd E, Seattle  47.619281, -122.282161
//Sarah Palin's street in Wasilla, Alaska   61.577718, -149.492511

import UIKit
import MapKit
import Contacts
// This adds the Contacts framework, which contains dictionary key constants such as CNPostalAddressStreetKey,
// for when you need to set the address, city or state fields of a location.

var myUserLocation: CLLocation = CLLocation()
//var myMapItem: MKMapItem = forCurrentLocation()
//let initialDisplay: Double = 20
//let initialSearch: Double = 15
//let initialDisplayDistance = CLLocationDistance(miles2meters(miles: initialDisplay))
//let initialSearchDistance = CLLocationDistance(miles2meters(miles: initialSearch))

//let initialMapSearch = "gas stations"

//MARK: puts this comment into the jump bar
/// THREE SLASHES above a custom method puts that comment into the Xcode quickhelp
func miles2meters (miles: Double) -> Double {
    let meters = miles * 1609.34
    return meters
}

func meters2miles (meters: Double) -> Double {
    let miles = meters * 0.00062137
    return miles
}

func shepCurrencyFromDouble(shepNumber : Double) -> String  {
    let buckaroos = shepNumber as NSNumber
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    // formatter.locale = NSLocale.currentLocale() // This is the default
    return formatter.string(from: buckaroos)!
}


class ViewController: UIViewController, MKMapViewDelegate, DataModelDelegate {

    @IBOutlet weak var myMapView: MKMapView!
    //    @IBOutlet weak var myMapView: MKMapView! {
    //        didSet {
    //            myMapView.mapType = .hybrid
    //            myMapView.delegate = self
    //        }
    //    }
    
    @IBOutlet weak var btnHospital: UIButton!
    @IBOutlet weak var btnTarget: UIButton!
    @IBOutlet weak var btnGas: UIButton!
    @IBOutlet weak var btnPizza: UIButton!
    @IBOutlet weak var btnPark: UIButton!
    @IBOutlet weak var btnMcD: UIButton!
    @IBOutlet weak var btnTwirlMenu: UIButton!
    @IBOutlet weak var btnChangeHeight: UIButton!
    @IBOutlet weak var btnClearMap: UIButton!
    
    @IBOutlet weak var DisplayDistanceSlider: UISlider!
    @IBOutlet weak var SearchDistanceSlider: UISlider!
    
    @IBOutlet weak var DisplayDistanceText: UILabel!
    @IBOutlet weak var SearchDistanceText: UILabel!
    @IBOutlet weak var RouteDataView: UIView!
    @IBOutlet weak var GoldenRouteView: UIView!
    @IBOutlet weak var lblCrowFlies: UILabel!
    @IBOutlet weak var lblDrivingDistance: UILabel!
    @IBOutlet weak var lblDrivingTime: UILabel!
    @IBOutlet weak var lblPay: UILabel!
    @IBOutlet weak var lblExpense: UILabel!
    @IBOutlet weak var lblEarning: UILabel!
    
   // @IBOutlet weak var GoldenRouteView: UIView!
    //var currentDisplayDistance = initialDisplayDistance
    //var currentSearchDistanceX= initialSearchDistance
    //var whichRouteStyle : String = "random"
    let myDataModel = shepDataModel()
    
//    func didReceiveMethodCallFromDataModel() {
//        print("In ViewController, didReceiveMethodCallFromDataModel happened")
//    }
//    
//    func didReceiveDataUpdate(data: String) {
//        print ("In ViewController, didReceiveDataUpdate was: \(data) \n")
//    }

    @IBAction func DisplayDistanceSliderMoved(_ sender: AnyObject) {
        // Get Float value from Slider when it is moved.
        let value = DisplayDistanceSlider.value
        // Assign text to string representation of float.
        DisplayDistanceText.text = String(format: "%.02f", value)
        myDataModel.currentDisplayDistance = miles2meters(miles: Double(value))
    }
    
    @IBAction func SearchDistanceSliderMoved(_ sender: AnyObject) {
        let value = SearchDistanceSlider.value
        SearchDistanceText.text = String(format: "%.02f", value)
        myDataModel.currentSearchDistance = miles2meters(miles: Double(value))
        //myDataModel.currentSearchDistance = miles2meters(miles: Double(value))
    }
    
    //   RE DETECTING END OF SLIDER CHANGE
    // You can add an action that takes two parameters, sender and an event, for UIControlEventValueChanged:
    //
    //    slider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
    //
    // Note in Interface Builder when adding an action you also have the option to add both sender and event parameters to the action.
    // -------
    
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
        GoldenRouteView.alpha = 0.0
        myDataModel.shepAnnotationsArray.removeAll()
    }
    
    @IBAction func btnChangeHeight(_ sender: Any) {
//        let tempTranslator = Double(CLLocationDistance(DisplayDistanceSlider.value))
//        print ("currentDisplayDistance is \(String(format: "%.02f", tempTranslator))")
//        let tempTranslator2 = meters2miles(meters: myDataModel.currentDisplayDistance)
//        print ("currentDisplayDistance is \(String(format: "%.02f", tempTranslator2))")

//        // create region for map
        let mapRegion1 = MKCoordinateRegionMakeWithDistance(myUserLocation.coordinate, myDataModel.currentDisplayDistance, myDataModel.currentDisplayDistance)
        
        myMapView.setRegion(mapRegion1, animated: true)
    }
    
    @IBAction func btnMakeRandomRoute(_ sender: UIButton) {
        if myDataModel.shepAnnotationsArray.count < 2 {
            print ("less than 2 items in shepAnnotationsArray \n")
            return
        }
        GoldenRouteView.alpha = 0.0
        RouteDataView.alpha = 1.0
        let howMany = UInt32(myDataModel.shepAnnotationsArray.count)
        //for _ in shepAnnotationsArray {
        let sourceAnnotation = Int(arc4random_uniform(howMany))
        let destinationItem = Int(arc4random_uniform(howMany))
        if sourceAnnotation != destinationItem {
            myDataModel.whichRouteStyle = "random"
            //print ("thisisCrowFliesDistanceInMiles:  \(myRouteData.thisisCrowFliesDistanceInMiles)")
            myDataModel.howManyRouteInfosCompleted = 0
            myDataModel.getRouteInfoVia2Annotations(source: myDataModel.shepAnnotationsArray[sourceAnnotation], destination: myDataModel.shepAnnotationsArray[destinationItem])
            //let myRoute = myDataModel.currentRoute
            //drawNewRoute(thisRoute: myRoute)
        } else { print ("source and destination are the same \n") }
    }

//    func didReceiveMethodCallFromDataModel() {
//        print("In ViewController, didReceiveMethodCallFromDataModel happenned")
//    }
//
//    func didReceiveDataUpdate(data: String) {
//        print ("In ViewController, didReceiveDataUpdate was: \(data)")
//    }
    
//    func entireSearchDirectionsLoopSuccessful(myAnnotationsArray: [ShepSingleAnnotation]) {
//        // let model = DataModel()
//        var fakeIndexNumber : Int = 0
//        //let myAnnotationsArray = model.shepAnnotationsArray
//        print ("\n entering ViewController entireSearchDirectionsLoopSuccessful, shepAnnotationsArray count is: \(myAnnotationsArray.count)\n")
//        //        let myTitle = myAnnotationsArray[0].title
//        //        print ("myTitle    -------------- \(String(describing: myTitle))\n")
//        for eachAnnotation in myAnnotationsArray {
//
//            print ("in ViewController entireSearchDirectionsLoopSuccessful loop")
//            print ("myFakeIndexlikeNumber is \(fakeIndexNumber)")
//            fakeIndexNumber = fakeIndexNumber + 1
//            let myTitle = eachAnnotation.title
//            print ("       --------------\n myTitle            \(String(describing: myTitle!))")
//            //let mySubTitle = myAnnotation.subtitle
//            //print ("mySubTitle          \(String(describing: mySubTitle!))")
//            let myGoldenRouteScore = eachAnnotation.goldenRouteScore
//            let myFormattedGoldenRouteScore = (shepCurrencyFromDouble(shepNumber: myGoldenRouteScore))
//            print ("-myGoldenRouteScore \(myFormattedGoldenRouteScore) ---  \(myFormattedGoldenRouteScore) \n        --------------")
//            print ("crowFliesDistance: \(String(format: "%.02f", eachAnnotation.crowFliesDistance)) miles")
//            let myDrivingDistance = eachAnnotation.routeDrivingDistance
//            print ("DrivingDistance is: \(String(format: "%.02f", myDrivingDistance)) miles")
//            let myDrivingTime = eachAnnotation.drivingTime
//            let lineBreak = "\n-------------------------------------------------------------------------"
//            print ("drivingTime is:    \(String(format: "%.02f", myDrivingTime)) minutes \(lineBreak)")
//
//        }  //  entireSearchDirectionsLoopSuccessful()  LOOP
//
//        //model.chooseGoldenRoute()
//        print ("In ViewController, entireSearchDirectionsLoopSuccessful DONE")
//    }
 
    @IBAction func btnMakeGoldenRoute(_ sender: UIButton) {
        if myDataModel.shepAnnotationsArray.count < 1 {
            print ("in btnMakeGoldenRoute NO items in shepAnnotationsArray \n")
            return
        }

        if myDataModel.shepAnnotationsArray.count < 2 {
            print ("less than 2 items in shepAnnotationsArray \n")
            return
        }
        
        GoldenRouteView.alpha = 1.0
        RouteDataView.alpha = 1.0
        let myChosenGoldenAnnotation = myDataModel.chooseGoldenRoute()
        RouteDataView.alpha = 1.0
        //let destinationAnnotation_location = CLLocation(latitude: myGoldenRoute.coordinate.latitude, longitude: myGoldenRoute.coordinate.longitude)
        let myTitle = myChosenGoldenAnnotation.title
        let myDrivingDistance = myChosenGoldenAnnotation.routeDrivingDistance
        let routeExpense : Double = myDrivingDistance * Double(myDataModel.centsPerMileExpense)/100
        let myGoldenRouteScore = myChosenGoldenAnnotation.goldenRouteScore
        //getRouteInfoVia2Annotations
        //let myFormattedGoldenRouteScore = (shepCurrencyFromDouble(shepNumber: myGoldenRouteScore))
        //print ("-myGoldenRouteScore \(myFormattedGoldenRouteScore) ---  \(myFormattedGoldenRouteScore) \n        --------------")
        lblPay.text = "PAY: \(String(describing: myTitle!))"
        lblExpense.text = "EXPENSE: \(shepCurrencyFromDouble(shepNumber: routeExpense))"
        lblEarning.text = "EARNING: \(shepCurrencyFromDouble(shepNumber: myGoldenRouteScore))"
        myDataModel.whichRouteStyle = "golden"
        //myDataModel.getRouteInfoVia2Annotations(source: sourceAnnotation, destination: myGoldenRoute)
        drawNewRoute(thisRoute: myChosenGoldenAnnotation.currentLinkedRoute)
    }
    
    @IBAction func twirlButtonTapped(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.1, delay: 0.05, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.btnTwirlMenu.transform = CGAffineTransform(rotationAngle: 0)
            
            self.btnTarget.alpha = 0.8
            self.btnTarget.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: -50, y: -22))
            self.btnHospital.alpha = 0.8
            self.btnHospital.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: -100, y: 30))
            self.btnPizza.alpha = 0.8
            self.btnPizza.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: 80, y: 20))
            self.btnGas.alpha = 0.8
            self.btnGas.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: 100, y: -35))
            self.btnPark.alpha = 0.8
            self.btnPark.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: 20, y: -80))
            self.btnMcD.alpha = 0.8
            self.btnMcD.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: -115, y: -70))
        }, completion: nil)
    }
    
    @IBAction func btnHospitalClick(_ sender: AnyObject) {
        myDataModel.populateMapViaAppleLocalSearch (searchString: "Hospital")
        resetTwirlButtons()
    }
    
    @IBAction func btnTargetClick(_ sender: AnyObject) {
        myDataModel.populateMapViaAppleLocalSearch (searchString: "Target")
        resetTwirlButtons()
    }
    
    @IBAction func btnGasClick(_ sender: AnyObject) {
        print ("in btnGasClick shepAnnotationsArray count is \(myDataModel.shepAnnotationsArray.count) \n")
        myDataModel.populateMapViaAppleLocalSearch (searchString: "gas station")
        resetTwirlButtons()
    }
    
    @IBAction func btnMcDClick(_ sender: AnyObject) {
        myDataModel.populateMapViaAppleLocalSearch (searchString: "McDonalds")
        resetTwirlButtons()
    }
    
    @IBAction func btnParkClick(_ sender: AnyObject) {
        print ("in btnPark shepAnnotationsArray count is \(myDataModel.shepAnnotationsArray.count) \n")
        myDataModel.populateMapViaAppleLocalSearch (searchString: "Park")
        resetTwirlButtons()
    }
    
    @IBAction func btnPizza(_ sender: AnyObject) {
        print ("in btnPizza_A shepAnnotationsArray count is \(myDataModel.shepAnnotationsArray.count)")
        myDataModel.populateMapViaAppleLocalSearch (searchString: "pizza")
        resetTwirlButtons()
    }

    //    func handleGoldenRoute(thisRoute: MKRoute) {
    //        print("handleGoldenRoute: \(thisRoute)")
    ////        myDataModel.currentLinkedRoute = thisRoute
    ////        print ("handleGoldenRoute.thisRoute:  \(String(describing: myDataModel.currentLinkedRoute))")
    ////        myMapView.removeOverlays(myMapView.overlays)
    ////        drawPolyline(theRoute: thisRoute)
    ////        let drivingDistance = meters2miles(meters: (thisRoute.distance)) // response distance in meters
    ////        let drivingTime = ((thisRoute.expectedTravelTime) / 60)  //expectedTravelTime is in secs
    ////        RouteDataView.alpha = 1
    ////        lblCrowFlies.text = "As crow flies: \(String(format: "%.02f", myDataModel.crowFliesDistance)) miles"
    ////        lblDrivingDistance.text = "Driving distance: \(String(format: "%.02f", drivingDistance)) miles"
    ////        lblDrivingTime.text = "Driving time: \(String(format: "%.02f", drivingTime)) minutes"
    //    }
    
    //    func makeLocalSearch (_ mySearchString:String){
    //        myDataModel.populateMapViaAppleLocalSearch(searchString : mySearchString)
    //        print ("in makeLocalSearch AnnotationsArray count is \(myDataModel.shepAnnotationsArray.count) \n")
    //        resetTwirlButtons()
    //    }
    
    func handleValidSearchResults(validSearchResults: [ShepSingleAnnotation]) {
        //print ("In ViewController, handleValidSearchResults was: \(validSearchResults)")
        print ("In ViewController, handleValidSearchResults count was: \(validSearchResults.count)")
        print ("In ViewController, myDataModel.shepAnnotationsArray count was: \(myDataModel.shepAnnotationsArray.count) \n")
        myMapView.addAnnotations(validSearchResults)
        myMapView.showAnnotations(myDataModel.shepAnnotationsArray, animated: true)
    }
    
    func drawNewRoute(thisRoute: MKRoute) {
        //print("drawNewRoute: \(thisRoute)")
        myDataModel.currentRoute = thisRoute
        print ("\n drawNewRoute.thisRoute:  \(String(describing: myDataModel.currentRoute))\n")
        myMapView.removeOverlays(myMapView.overlays)
        drawPolyline(theRoute: thisRoute)
        let drivingDistance = meters2miles(meters: (thisRoute.distance)) // response distance in meters
        let drivingTime = ((thisRoute.expectedTravelTime) / 60)  //expectedTravelTime is in secs
        RouteDataView.alpha = 1
        lblCrowFlies.text = "As crow flies: \(String(format: "%.02f", myDataModel.crowFliesDistance)) miles"
        lblDrivingDistance.text = "Driving distance: \(String(format: "%.02f", drivingDistance)) miles"
        lblDrivingTime.text = "Driving time: \(String(format: "%.02f", drivingTime)) minutes"
    }
    
    func drawPolyline (theRoute: MKRoute) {
        self.myMapView.add(theRoute.polyline, level: MKOverlayLevel.aboveRoads)
        // self.myMapView.add(theRoute.polyline)
        let myMKMapRect = theRoute.polyline.boundingMapRect
        self.myMapView.setVisibleMapRect(myMKMapRect, edgePadding: UIEdgeInsetsMake(15.0, 15.0, 15.0, 15.0), animated: true)
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

    
    //Part 1. CALLBACK AS COMPLETION HANDLER
    ///////////////////////////////////////////////////
    //This way is very easy to setup. First, we create a requestData method that takes completion (a block):
    
    //Completion here is a method, that takes a String as a data and has a Void return type.
    //Inside requestData, we run the code to request the data from any source:
    
    //All we need to do now is to call completion with the data we have just received:
//    class DataModel {
//        func performDataRequest(completion: ((_ shepdata: String) -> Void)) {
//            // the data was received and parsed to String
//            let myDataRequestData = "xyData from wherever"
//            let myotherDataReqData = "second " + myDataRequestData
//            completion(myotherDataReqData)
//        }
//    }
    //The next step is to create an instance of DataModel in ViewController class and call requestData method. In completion, we call a private method useData:
    //class ViewController: UIViewController {  //UIViewController {
    //let dataModel = DataModel()
    //dataModel.performDataRequest { [weak self] (data: String) in self?.useData(data: data)
    
    func resetTwirlButtons() {
        UIView.animate(withDuration: 0.2, delay: 0.2, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.btnTwirlMenu.transform = CGAffineTransform(rotationAngle: 0.25*3.1415927)
            
            self.btnTarget.alpha = 0
            self.btnTarget.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            self.btnHospital.alpha = 0
            self.btnHospital.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            self.btnPizza.alpha = 0
            self.btnPizza.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            self.btnGas.alpha = 0
            self.btnGas.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            self.btnPark.alpha = 0.0
            self.btnPark.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            self.btnMcD.alpha = 0.0
            self.btnMcD.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
        }, completion: nil)
    }
    
    // set up compass as UIBarButtonItem, separate from map itself
//    func setupCompassButton() {
//        let compass = MKCompassButton(mapView: myMapView)
//        compass.compassVisibility = .visible
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: compass)
//        myMapView.showsCompass = false
//    }

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
        view.addSubview(scale)
        
        NSLayoutConstraint.activate([button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -155),
                                     button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -05),
                                     scale.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -150),
                                     scale.centerYAnchor.constraint(equalTo: button.centerYAnchor)])
    }
    
    func registerAnnotationViewClasses() {
        //myMapView.register(BikeView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        //myMapView.register(ClusterView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        myMapView.register(SingleAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
//    func loadDataForMapRegionAndBikes() {
//        if let plist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Data", ofType: "plist")!) {
//            if (plist["region"] as? [NSNumber]) != nil {
//                //  let coordinate = CLLocationCoordinate2D(latitude: region[0].doubleValue, longitude: region[1].doubleValue)
//                // let span = MKCoordinateSpanMake(region[2].doubleValue, region[3].doubleValue)
//                let coordinate = CLLocationCoordinate2D(latitude: THOMPSON_GPS.latitude, longitude: THOMPSON_GPS.longitude)
//                let initialDistance = CLLocationDistance(miles2meters(miles: 55.2))
//                myMapView.region = MKCoordinateRegionMakeWithDistance(coordinate, initialDistance, initialDistance)
//                // myMapView.region = MKCoordinateRegionMake(coordinate, span)
//            }
//            if let makeAppleArrayofAnnts = plist["bikes"] as? [[String : NSNumber]] {
//                self.myMapView.addAnnotations(AppleSingleAnnotation.makeAppleArrayofAnnts(fromDictionaries: makeAppleArrayofAnnts))
//            }
//        }
//    }
    
    // Create a location manager to trigger user tracking
    let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        return manager
    }()
    
    //    You have to override CLLocationManager.didUpdateLocations (part of CLLocationManagerDelegate) to get notified when the location manager retrieves the current location:
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let currentLocation = locations.last as! CLLocation
        myUserLocation = currentLocation
        //let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        //        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        //        self.map.setRegion(region, animated: true)
    }
    
    //let regionRadius: CLLocationDistance = ()
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
    
    ////////////////////////////////////////
    // When a view controller is loaded from a storyboard, the system instantiates the view hierarchy and assigns the appropriate values to all the view controller’s outlets. By the time the view controller’s viewDidLoad() method is called, the system has assigned valid values to all of the controller’s outlets, and you can safely access their contents.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Comparing to the callback way, Delegation pattern is easier to reuse across the app: you can create a base class that conforms to the protocol delegate and avoid code redundancy. However, delegation is harder to implement: you need to create a protocol, set the protocol methods, create Delegate property, assign Delegate to ViewController, and make this ViewController conform to the protocol. Also, the Delegate has to implement every method of the protocol by default.
        myDataModel.delegate = self
        
        // A DELEGATE is an object that acts on behalf of, or in coordination with, another object. The delegating object—in this case, the text field—keeps a reference to the other object—the delegate—and at the appropriate time, the delegating object sends a message to the delegate. The message tells the delegate about an event that the delegating object is about to handle or has just handled.
        // "Setting ViewController as the delegate of the map view.  You can do this in Main.storyboard, but I prefer to do it in code, where it’s more visible."
        myMapView.delegate = self
        
        //        print ("in **viewDidLoad** shepAnnotationsArray count is \(myDataModel.shepAnnotationsArray.count) \n")
        //        print ("in ***viewDidLoad BEFORE SEARCH Current search distance: \(meters2miles(meters: myDataModel.currentSearchDistance))")
        myDataModel.populateMapViaAppleLocalSearch(searchString: "park")
        //        print ("in viewDidLoad AFTER SEARCH shepAnnotationsArray count is \(myDataModel.shepAnnotationsArray.count)")
        //        print ("in ***viewDidLoad AFTER SEARCH Current search distance: \(meters2miles(meters: myDataModel.currentSearchDistance))")
        
        setupUserTrackingButtonAndScaleView()
        registerAnnotationViewClasses()
        //loadDataForMapRegionAndBikes()
        
        centerMapOnLocation(location: myUserLocation)
        
        self.btnHospital.layer.cornerRadius = 10
        self.btnTarget.layer.cornerRadius = 10
        self.btnPizza.layer.cornerRadius = 10
        self.btnGas.layer.cornerRadius = 10
        self.btnTwirlMenu.layer.cornerRadius = 10
        self.btnPark.layer.cornerRadius = 10
        self.btnMcD.layer.cornerRadius = 10
        
        DisplayDistanceSlider.value = Float(initialDisplay)
        print ("initialDisplay is: \(initialDisplay)")
        SearchDistanceSlider.value = Float(initialSearch)
        print ("SearchDistanceSlider.value: \(SearchDistanceSlider.value)")
        DisplayDistanceText.text = String(initialDisplay)
        SearchDistanceText.text = String(initialSearch)
        GoldenRouteView.alpha = 0.0
        RouteDataView.alpha = 0.0
        
        //set up the twirl button
        UIView.animate(withDuration: 0.2, delay: 0.2, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.btnTwirlMenu.alpha = 1
            self.btnTwirlMenu.transform = CGAffineTransform(rotationAngle: 0.25*3.1415927)
        }, completion: nil)
    }
}


extension ViewController {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Updating the Map View based on User Movement
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
        myUserLocation = myMapView.userLocation.location!
    }
    
    // myMapView annotation calloutAccessoryControl was tapped, open Maps
    func myMapView(_ myMapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! ShepSingleAnnotation
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        // Note: Explore the MKMapItem documentation to see other launch option dictionary keys,
        // and the openMaps(with:launchOptions:) method that lets you pass an array of MKMapItem objects.
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }

    // route polyline related
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let myLineRenderer = MKPolylineRenderer(polyline: myDataModel.currentRoute.polyline)
        if myDataModel.whichRouteStyle == "random" {
            myLineRenderer.lineWidth = 4
            myLineRenderer.strokeColor = .blue
        } else { // "golden" or anything else right now
            myLineRenderer.lineWidth = 8
            myLineRenderer.strokeColor = .green
        }
        return myLineRenderer
    }

}


//////////////////////
//  In an app, the FIRST RESPONDER is an object that is first on the line for receiving many kinds of app events, including key events, motion events, and action messages, among others. In other words, many of the events generated by the user are initially routed to the first responder.
//////////////////////


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


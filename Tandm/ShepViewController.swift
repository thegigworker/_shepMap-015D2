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
    @IBOutlet weak var changeHeight: UIButton!
    @IBOutlet weak var btnClearMap: UIButton!
    
    @IBOutlet weak var DisplayDistanceSlider: UISlider!
    @IBOutlet weak var SearchDistanceSlider: UISlider!
    
    //@IBOutlet weak var SearchDistanceText: UILabel!
    //@IBOutlet weak var DisplayDistanceText: UILabel!
    @IBOutlet weak var DisplayDistanceText2: UILabel!
    @IBOutlet weak var SearchDistanceText2: UILabel!
    @IBOutlet weak var RouteDataView: UIView!
    @IBOutlet weak var lblCrowFlies: UILabel!
    @IBOutlet weak var lblDrivingDistance: UILabel!
    @IBOutlet weak var lblDrivingTime: UILabel!
    
    //var currentDisplayDistance = initialDisplayDistance
    //var currentSearchDistance = initialSearchDistance
    var whichPolylineStyle : String = ""
    let myDataModel = shepDataModel()
    
    func didReceiveMethodCallFromDataModel() {
        print("In ViewController, didReceiveMethodCallFromDataModel happened")
    }
    
    func didReceiveDataUpdate(data: String) {
        print ("In ViewController, didReceiveDataUpdate was: \(data) \n")
    }
    
    @IBAction func DisplayDistanceSliderMoved(_ sender: AnyObject) {
        // Get Float value from Slider when it is moved.
        let value = DisplayDistanceSlider.value
        // Assign text to string representation of float.
        DisplayDistanceText2.text = String(format: "%.02f", value)
        myDataModel.currentDisplayDistance = miles2meters(miles: Double(value))
    }
    
    @IBAction func SearchDistanceSliderMoved(_ sender: AnyObject) {
        let value = SearchDistanceSlider.value
        SearchDistanceText2.text = String(format: "%.02f", value)
        myDataModel.currentSearchDistance2 = miles2meters(miles: Double(value))
        //myDataModel.currentSearchDistance2 = miles2meters(miles: Double(value))
    }
    
    //   RE DETECTING END OF SLIDER CHANGE
    // You can add an action that takes two parameters, sender and an event, for UIControlEventValueChanged:
    //
    //    slider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
    //
    // Note in Interface Builder when adding an action you also have the option to add both sender and event parameters to the action.
    // -------
    
    @IBAction func clearMap(_ sender: UIButton) {
        myMapView.removeOverlays(myMapView.overlays)
        myMapView.removeAnnotations(myMapView.annotations)
        RouteDataView.alpha = 0.2
        myDataModel.shepAnnotationsArray.removeAll()
    }
    
    @IBAction func changeHeight(_ sender: Any) {
//        let tempTranslator = Double(CLLocationDistance(DisplayDistanceSlider.value))
//        print ("currentDisplayDistance is \(String(format: "%.02f", tempTranslator))")
//        let tempTranslator2 = meters2miles(meters: myDataModel.currentDisplayDistance)
//        print ("currentDisplayDistance is \(String(format: "%.02f", tempTranslator2))")

//        // create region for map
        let mapRegion1 = MKCoordinateRegionMakeWithDistance(myUserLocation.coordinate, myDataModel.currentDisplayDistance, myDataModel.currentDisplayDistance)
        
        myMapView.setRegion(mapRegion1, animated: true)
    }
    
    @IBAction func makeRandomRoute(_ sender: UIButton) {
        if myDataModel.shepAnnotationsArray.count < 2 {
            print ("less than 2 items in shepAnnotationsArray \n")
            return
        }
        let howMany = UInt32(myDataModel.shepAnnotationsArray.count)
        //for _ in shepAnnotationsArray {
        let sourceItem = Int(arc4random_uniform(howMany))
        let destinationItem = Int(arc4random_uniform(howMany))
        if sourceItem != destinationItem {
            //print ("thisisCrowFliesDistanceInMiles:  \(myRouteData.thisisCrowFliesDistanceInMiles)")
            guard let myRouteData = myDataModel.getRouteData2(source: myDataModel.shepAnnotationsArray[sourceItem], destination: myDataModel.shepAnnotationsArray[destinationItem])
                else {
                    print("inside makeRandomRoute, myRouteData was nil /n")
                    return
            }
            myDataModel.currentRoute = myRouteData
            print ("myRouteData.thisismyRoute:  \(String(describing: myDataModel.currentRoute))")
            myMapView.removeOverlays(myMapView.overlays)
            whichPolylineStyle = "blue"
            drawPolyline(theRoute: myRouteData)
            let drivingDistance = meters2miles(meters: myRouteData.distance) // response distance in meters
            let drivingTime = ((myRouteData.expectedTravelTime) / 60)  //expectedTravelTime is in secs
            RouteDataView.alpha = 1
            lblCrowFlies.text = "As crow flies: \(String(format: "%.02f", myDataModel.crowFliesDistance)) miles"
            lblDrivingDistance.text = "Driving distance: \(String(format: "%.02f", drivingDistance)) miles"
            lblDrivingTime.text = "Driving time: \(String(format: "%.02f", drivingTime)) minutes"
        } else { print ("source and destination are the same \n") }
    }
    
    
   // MKPlacemark is a subclass of CLPlacemark, therefore you cannot just cast it. You can instantiate an MKPlacemark from a CLPlacemark using the code below
   // if let addressDict = clPlacemark.addressDictionary, coordinate = clPlacemark.location.coordinate {
   //let mkPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
    
    //init(placemark: MKPlacemark)
   // Initializes and returns a map item object using the specified placemark object.
    
    //var placemark: MKPlacemark { get }

    @IBAction func makeGoldenRoute(_ sender: UIButton) {
        if myDataModel.shepAnnotationsArray.count < 1 {
            print ("in makeGoldenRoute NO items in shepAnnotationsArray \n")
            return
        }
        //let howMany = UInt32(shepAnnotationsArray.count)
        //for _ in shepAnnotationsArray {
        //func forCurrentLocation(self.myUserLocation)
       // let myMapItem: MKMapItem = forCurrentLocation(myUserLocation)
        //self.mapItemData = localSearchResponse?.mapItems.last
        
        ///////////  CONVERSION FROM COORDINATES INTO MKMAPITEM?
        let temp = myUserLocation.coordinate
        let MKPlacemark1 = MKPlacemark(coordinate: CLLocationCoordinate2DMake(temp.latitude, temp.longitude), addressDictionary: nil)
        let myMKMapItem : MKMapItem = MKMapItem(placemark: MKPlacemark1)
        ///////////  CONVERSION FROM COORDINATES INTO MKMAPITEM?
        
        let sourceItem = ShepSingleAnnotation(myMapItem: myMKMapItem, currentRoute: MKRoute(), shepDollarValue: 0.0)
        let howMany = UInt32(myDataModel.shepAnnotationsArray.count)
        let destinationItem = Int(arc4random_uniform(howMany))
            guard let myRouteData = myDataModel.getRouteData2(source: sourceItem, destination: myDataModel.shepAnnotationsArray[destinationItem])
                else {
                    print ("myRouteData is nil \n" )
                    return
            }
            myDataModel.currentRoute = myRouteData
            print ("myRouteData.thisismyRoute:  \(String(describing: myDataModel.currentRoute))")
            myMapView.removeOverlays(myMapView.overlays)
            whichPolylineStyle = "green"
            drawPolyline(theRoute: myRouteData)
            let drivingDistance = meters2miles(meters: myRouteData.distance) // response distance in meters
            let drivingTime = ((myRouteData.expectedTravelTime) / 60)  //expectedTravelTime is in secs
            RouteDataView.alpha = 1
            lblCrowFlies.text = "As crow flies: \(String(format: "%.02f", myDataModel.crowFliesDistance)) miles"
            lblDrivingDistance.text = "Driving distance: \(String(format: "%.02f", drivingDistance)) miles"
            lblDrivingTime.text = "Driving time: \(String(format: "%.02f", drivingTime)) minutes"
    }
    
//    //func getRouteData (source: ShepSingleAnnotation, destination: ShepSingleAnnotation) {
//    func getRouteData (source: ShepSingleAnnotation, destination: ShepSingleAnnotation) -> (MKRoute?) {
//        let point1 = MKPointAnnotation()
//        let point2 = MKPointAnnotation()
//        point1.coordinate = CLLocationCoordinate2DMake(source.coordinate.latitude, source.coordinate.longitude)
//        point2.coordinate = CLLocationCoordinate2DMake(destination.coordinate.latitude, destination.coordinate.longitude)
//        let point1_placemark = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point1.coordinate.latitude, point1.coordinate.longitude), addressDictionary: nil)
//        let point2_placemark = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point2.coordinate.latitude, point2.coordinate.longitude), addressDictionary: nil)
//
//        let directionsRequest = MKDirectionsRequest()
//        directionsRequest.source = MKMapItem(placemark: point1_placemark)
//        directionsRequest.destination = MKMapItem(placemark: point2_placemark)
//        directionsRequest.transportType = myDataModel.currentTransportType
//        //  Set the transportation type to .Automobile for this particular scenario. (.Walking and .Any are also valid MKDirectionsTransportTypes.)
//        //  Set requestsAlternateRoutes to true to fetch all the reasonable routes from the source to destination.
//        let directions = MKDirections(request: directionsRequest)
//        //var crowFliesDistanceInMiles: Double = 0.0
//
//        directions.calculate(completionHandler: {
//            response, error in
//            // response has an array of MKRoutes
//            if error != nil {
//                print ("Directions Retreival Error: \(String(describing: error))")
//            } else {
//                //self.myMapView.removeOverlays(self.myMapView.overlays)
//                self.myDataModel.myRoute = response!.routes[0] as MKRoute
//            }
//            //return (self.myRoute)  // Unexpected non-void return value in void function
//        })
//
//        return (myDataModel.myRoute)
//    }
    
    func drawPolyline (theRoute: MKRoute) {
        //self.myMapView.removeOverlays(self.myMapView.overlays)
       // self.myMapView.add(self.myRoute.polyline, level: MKOverlayLevel.aboveRoads)
        self.myMapView.add(theRoute.polyline)
        let myMKMapRect = theRoute.polyline.boundingMapRect
        self.myMapView.setVisibleMapRect(myMKMapRect, edgePadding: UIEdgeInsetsMake(15.0, 15.0, 15.0, 15.0), animated: true)
        //var rect = self.myRoute.polyline.boundingMapRect // ***polyline.boundingMapRect***
        //self.myMapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
    }
    
    
    //    func getRouteData (source: ShepSingleAnnotation, destination: ShepSingleAnnotation) -> (thisismyRoute: MKRoute?, thisisCrowFliesDistanceInMiles: Double) {
    //        let point1 = MKPointAnnotation()
    //        let point2 = MKPointAnnotation()
    //        point1.coordinate = CLLocationCoordinate2DMake(source.coordinate.latitude, source.coordinate.longitude)
    //        point2.coordinate = CLLocationCoordinate2DMake(destination.coordinate.latitude, destination.coordinate.longitude)
    //        let point1_placemark = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point1.coordinate.latitude, point1.coordinate.longitude), addressDictionary: nil)
    //        let point2_placemark = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point2.coordinate.latitude, point2.coordinate.longitude), addressDictionary: nil)
    //
    //        let directionsRequest = MKDirectionsRequest()
    //        directionsRequest.source = MKMapItem(placemark: point1_placemark)
    //        directionsRequest.destination = MKMapItem(placemark: point2_placemark)
    //        directionsRequest.transportType = currentTransportType
    //        let directions = MKDirections(request: directionsRequest)
    //        var crowFliesDistanceInMiles: Double = 0.0
    //
    //        directions.calculate(completionHandler: {
    //            response, error in
    //            // response has an array of MKRoutes
    //            if error != nil {
    //                print ("Directions Retreival Error: \(String(describing: error))")
    //            } else {
    //                //self.myMapView.removeOverlays(self.myMapView.overlays)
    //                self.myRoute = response!.routes[0] as MKRoute
    //                let sourceLocation = CLLocation(latitude: point1.coordinate.latitude, longitude: point1.coordinate.longitude)
    //                let destinationLocation = CLLocation(latitude: point2.coordinate.latitude, longitude: point2.coordinate.longitude)
    //                let crowFliesDistance = sourceLocation.distance(from: destinationLocation) // result is in meters
    //                crowFliesDistanceInMiles = meters2miles(meters: crowFliesDistance)
    //                //return (thisismyRoute: myRoute, thisisCrowFliesDistanceInMiles: crowFliesDistanceInMiles)
    //            }
    //            //return (thisismyRoute: myRoute, thisisCrowFliesDistanceInMiles: crowFliesDistanceInMiles)
    //        })
    //        return (thisismyRoute: self.myRoute, thisisCrowFliesDistanceInMiles: crowFliesDistanceInMiles)
    //    }
    //////////////////////////////////////////////////
    
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
  

    @IBAction func btnHospitalClick(_ sender: AnyObject) {
        handleLocalSearch ("Hospital")
    }
    
    @IBAction func btnTargetClick(_ sender: AnyObject) {
        handleLocalSearch ("Target")
    }
    
    @IBAction func btnGasClick(_ sender: AnyObject) {
        print ("in btnGasClick shepAnnotationsArray count is \(myDataModel.shepAnnotationsArray.count) \n")
         handleLocalSearch ("gas station")
    }
    
    @IBAction func btnMcDClick(_ sender: AnyObject) {
        handleLocalSearch ("McDonalds")
    }
    
    @IBAction func btnParkClick(_ sender: AnyObject) {
        print ("in btnPark shepAnnotationsArray count is \(myDataModel.shepAnnotationsArray.count) \n")
        handleLocalSearch ("Park")
    }
    
    @IBAction func btnPizza(_ sender: AnyObject) {
        print ("in btnPizza_A shepAnnotationsArray count is \(myDataModel.shepAnnotationsArray.count)")
        handleLocalSearch ("pizza")
    }
    
    func handleLocalSearch (_ searchString:String){
        //performLocalSearch(searchString)
        myDataModel.performLocalSearch2(searchString)
        myMapView.addAnnotations(myDataModel.validSearchResultsArray)
        myMapView.showAnnotations(myDataModel.shepAnnotationsArray, animated: true)
        print ("in handleLocalSearch AnnotationsArray count is \(myDataModel.shepAnnotationsArray.count) \n")
        resetTwirlButtons()
        centerMapOnLocation(location: myUserLocation)
    }
    //Part 1. Callback as Completion Handler
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
    
    func eatmyshorts(incomingData: String) {
        //let data2 = "shorts"
        myDataModel.performDataRequest { [weak self] (data2: String) in self?.useData(data: data2)}
    }
    
    func useData(data: String) {
        print("still calculating \n\(data)")
    }
    // }
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   // When a view controller is loaded from a storyboard, the system instantiates the view hierarchy and assigns the appropriate values to all the view controller’s outlets. By the time the view controller’s viewDidLoad() method is called, the system has assigned valid values to all of the controller’s outlets, and you can safely access their contents.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Comparing to the callback way, Delegation pattern is easier to reuse across the app: you can create a base class that conforms to the protocol delegate and avoid code redundancy. However, delegation is harder to implement: you need to create a protocol, set the protocol methods, create Delegate property, assign Delegate to ViewController, and make this ViewController conform to the protocol. Also, the Delegate has to implement every method of the protocol by default.
        myDataModel.delegate = self
        myDataModel.triggerMethodInDataModel()
        myDataModel.requestData()
        
        setupUserTrackingButtonAndScaleView()
        registerAnnotationViewClasses()
        //loadDataForMapRegionAndBikes()
        
        // A DELEGATE is an object that acts on behalf of, or in coordination with, another object. The delegating object—in this case, the text field—keeps a reference to the other object—the delegate—and at the appropriate time, the delegating object sends a message to the delegate. The message tells the delegate about an event that the delegating object is about to handle or has just handled.
        // "Setting ViewController as the delegate of the map view.  You can do this in Main.storyboard, but I prefer to do it in code, where it’s more visible."
        myMapView.delegate = self
        
       // SearchDistanceSlider.value = Float(myDataModel.currentSearchDistance2)
        
        print ("in **viewDidLoad** shepAnnotationsArray count is \(myDataModel.shepAnnotationsArray.count) \n")
        print ("in ***viewDidLoad BEFORE SEARCH Current search distance: \(meters2miles(meters: myDataModel.currentSearchDistance2))")
        //print ("in ***viewDidLoad Current search distance: \(meters2miles(meters: self.currentSearchDistance))")
        handleLocalSearch("gas station")
        //myDataModel.performLocalSearch2("gas station") //INITIAL ONE SOMETHING GOES WRONG WITH SEARCH REGION -- BUT I CAN'T FIND IT
        print ("in viewDidLoad AFTER SEARCH shepAnnotationsArray count is \(myDataModel.shepAnnotationsArray.count)")
        print ("in ***viewDidLoad AFTER SEARCH Current search distance: \(meters2miles(meters: myDataModel.currentSearchDistance2))")
        
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
        DisplayDistanceText2.text = String(initialDisplay)
        SearchDistanceText2.text = String(initialSearch)
        
        //the twirl?
        UIView.animate(withDuration: 0.2, delay: 0.2, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.btnTwirlMenu.alpha = 1
            self.btnTwirlMenu.transform = CGAffineTransform(rotationAngle: 0.25*3.1415927)
        }, completion: nil)

        }
    }


extension ViewController {
    
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

    // directions/polyline related
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let myLineRenderer = MKPolylineRenderer(polyline: myDataModel.currentRoute!.polyline)
        if whichPolylineStyle == "blue" {
            myLineRenderer.lineWidth = 4
            myLineRenderer.strokeColor = .blue
        } else {
            myLineRenderer.lineWidth = 8
            myLineRenderer.strokeColor = .green
        }
        
        return myLineRenderer
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

///////////////////////////////////////////
//  In an app, the FIRST RESPONDER is an object that is first on the line for receiving many kinds of app events, including key events, motion events, and action messages, among others. In other words, many of the events generated by the user are initially routed to the first responder.

//
// 搜索
func performLocalSearch(_ searchString:String) {
    //shepAnnotationsArray.removeAll()
    let request = MKLocalSearchRequest()
    request.naturalLanguageQuery = searchString
    var validSearchResultsArray: [ShepSingleAnnotation] = []
    // 搜索当前区域
    // print ("in performLocalSearch searchRegion search distance: \(meters2miles(meters: self.currentSearchDistance))")
    let searchRegion1 = MKCoordinateRegionMakeWithDistance(myUserLocation.coordinate, myDataModel.currentSearchDistance2, myDataModel.currentSearchDistance2)
    request.region = searchRegion1
    //request.region = myMapView.region
    // a MKLocalSearch object initiates a search operation and will deliver the results back into an array of MKMapItems. This will contain the name, latitude and longitude of the current POI.
    print ("before search.start shepAnnotationsArray count: \(myDataModel.shepAnnotationsArray.count)")
    // 启动搜索,并且把返回结果保存到数组中
    let search = MKLocalSearch(request: request)
    
    search.start(completionHandler: {(response, error) in
        //let myViewController = ViewController()
        //var validSearchResultsArray: [ShepSingleAnnotation] = []
        print ("inside completionHandler shepAnnotationsArray count: \(self.myDataModel.shepAnnotationsArray.count)")
        // Local searches are performed asynchronously
        //and a completion handler called when the search is complete.
        if error != nil {
            print("Error occured in search: \(error!.localizedDescription)")
        } else if response!.mapItems.count == 0 {
            print("No matches found")
        } else {
            print("\n \(response!.mapItems.count) matches found")
            //The code in the completion handler checks the response to make sure that matches were found
            //and then accesses the mapItems property of the response which contains an array of mapItem instances for the matching locations.
            shepSearchResultLoop: for item in response!.mapItems {
                let searchResultCoordinates = item.placemark.coordinate
                let searchResultLocation = CLLocation(latitude: searchResultCoordinates.latitude, longitude: searchResultCoordinates.longitude)
                let mapItemDistance = myUserLocation.distance(from: searchResultLocation) // result is in meters
                //let distanceInMiles = meters2miles(meters: mapItemDistance)
                print ("Current search distance: \(meters2miles(meters: self.myDataModel.currentSearchDistance2)) and this distance: \(meters2miles(meters: mapItemDistance))")

                if mapItemDistance > self.myDataModel.currentSearchDistance2 {  // if SearchResult is further away than currentSearchDistance
                    print ("took one down, too far away")
                    continue shepSearchResultLoop
                } else {
                    let shepDollarValue = Double(arc4random_uniform(40) + 1)
                    //let shepPassedString = shepCurrencyFromDouble(shepNumber: shepDollarValue)
                    let validResult = ShepSingleAnnotation(myMapItem: item, currentRoute: MKRoute(), shepDollarValue: shepDollarValue)
                    
                    print("validResult shepStringData: \(validResult.shepStringData)")
                     print("validResult routeDrivingDistance: \(validResult.routeDrivingDistance)")
                    print("validResult bestRouteScore: \(validResult.bestRouteScore)")
                    print("validResult drivingTime: \(validResult.drivingTime)")
                    //print("validResult crowFliesDistance: \(String(describing: validResult.crowFliesDistance!))")
                    print("validResult myStoredRoute: \(String(describing: validResult.currentRoute!)) \n")
                   
                    //print("validResult routeDrivingDistance: \(validResult.)")
                    
                    validSearchResultsArray.append(validResult)
                }
                print ("still inside shepSearchResultLoop?, shepAnnotationsArray count is \(self.myDataModel.shepAnnotationsArray.count)")
                print ("still inside shepSearchResultLoop? validSearchResultsArray count: \(validSearchResultsArray.count) \n")
            }
            self.myDataModel.shepAnnotationsArray.append(contentsOf: validSearchResultsArray)
            print ("shepSearchResultLoop is done now???, shepAnnotationsArray count is \(self.myDataModel.shepAnnotationsArray.count)")
            print ("shepSearchResultLoop is done now???, validSearchResultsArray count is \(validSearchResultsArray.count) \n")
            self.myMapView.addAnnotations(validSearchResultsArray)
            self.myMapView.showAnnotations(self.myDataModel.shepAnnotationsArray, animated: true)
        }
    })
    //print ("opening gambit, validSearchResultsArray count is \(validSearchResultsArray.count) \n")  // validSearchResultsArray doesn't work here
    print ("OPENING GAMBIT, shepAnnotationsArray count is \(myDataModel.shepAnnotationsArray.count) \n")
}

}

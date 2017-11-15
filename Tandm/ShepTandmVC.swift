//  ShepMapController.swift
//

import UIKit
import MapKit

let THOMPSON_GPS = (latitude: 41.9360805, longitude: -71.7978248)
// Hartford_GPS:  41.767603, -72.684036
// Yankee Stadium:  40.830304, -73.926089

let initialLocation = CLLocation(latitude: THOMPSON_GPS.latitude, longitude: THOMPSON_GPS.longitude)
let initialDisplayDistance = CLLocationDistance(miles2meters(miles: 18))
let initialSearchDistance = CLLocationDistance(miles2meters(miles: 10))
let initialMapSearch = "gas stations"

/// Remember that THREE SLASHES above a custom method puts that comment into the Xcode quickhelp
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

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnHospital: UIButton!
    @IBOutlet weak var btnTarget: UIButton!
    @IBOutlet weak var btnMall: UIButton!
    @IBOutlet weak var btnSupermarket: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var shepDoThingBtn: UIButton!

    @IBOutlet weak var DisplayDistanceSlider: UISlider!
    @IBOutlet weak var SearchDistanceSlider: UISlider!
    
    @IBOutlet weak var SearchDistanceText: UILabel!
    @IBOutlet weak var DisplayDistanceText: UILabel!
    @IBOutlet weak var DisplayDistanceText2: UILabel!
    @IBOutlet weak var SearchDistanceText2: UILabel!
    
    @IBAction func DisplayDistanceSliderMoved(_ sender: AnyObject) {
        // Get Float value from Slider when it is moved.
        let value = DisplayDistanceSlider.value
        // Assign text to string representation of float.
        DisplayDistanceText2.text = String(format: "%.02f", value)
    }
    
    @IBAction func SearchDistanceSliderMoved(_ sender: AnyObject) {
        let value = SearchDistanceSlider.value
        SearchDistanceText2.text = String(format: "%.02f", value)
    }
    
    var currentDisplayDistance = initialDisplayDistance
    var currentSearchDistance = initialSearchDistance
    
    
    // RE DETECTING END OF SLIDER CHANGE
    //
    // You can add an action that takes two parameters, sender and an event, for UIControlEventValueChanged:
    //
    //    slider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
    //
    // Note in Interface Builder when adding an action you also have the option to add both sender and event parameters to the action.
   // -------
    
    @IBAction func shepDoThingBtn(_ sender: Any) {
        // print ("\n bingo")
        var tempTranslator = Double(CLLocationDistance(DisplayDistanceSlider.value))
        currentDisplayDistance = CLLocationDistance(miles2meters(miles: tempTranslator))
        //        print ("currentDisplayDistance is \(String(format: "%.02f", tempTranslator))")
        //
        tempTranslator = Double(CLLocationDistance(SearchDistanceSlider.value))
        currentSearchDistance = CLLocationDistance(miles2meters(miles: tempTranslator))
        //        print ("currentSearchDistance is \(String(format: "%.02f", tempTranslator))")
        // create region for map
        let mapRegion1 = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, currentDisplayDistance, currentDisplayDistance)
        mapView.setRegion(mapRegion1, animated: true)
    }
    
    var mySubtitleString: String = "this is a test"
    
    
    @IBAction func btnHospitalClick(_ sender: AnyObject) {
        print ("in Hospclick")
        mapView.removeAnnotations(mapView.annotations)
        searchMap("Hospital")
        resetTwirlButtons()
    }
    
    @IBAction func btnTargetClick(_ sender: AnyObject) {
        print ("in targetclick")
        mapView.removeAnnotations(mapView.annotations)
        searchMap("Target")
        resetTwirlButtons()
    }
    
    @IBAction func btnGasClick(_ sender: AnyObject) {
        print ("in gasclick")
        mapView.removeAnnotations(mapView.annotations)
        searchMap("gas station")
        resetTwirlButtons()
    }
    
    @IBAction func btnSupermarket(_ sender: AnyObject) {
        print ("in suprmarkclick")
        mapView.removeAnnotations(mapView.annotations)
        //searchMap("Market Basket")
        searchMap("Stop & Shop")
        resetTwirlButtons()
    }
    
    @IBAction func btnMenuClick(_ sender: AnyObject) {
        
        UIView.animate(withDuration: 0.1, delay: 0.05, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.btnMenu.transform = CGAffineTransform(rotationAngle: 0)

            self.btnTarget.alpha = 0.8
            self.btnTarget.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: -50, y: -25))

            self.btnHospital.alpha = 0.8
            self.btnHospital.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: -100, y: 30))

            self.btnSupermarket.alpha = 0.8
            self.btnSupermarket.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: 80, y: 10))

            self.btnMall.alpha = 0.8
            self.btnMall.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: 100, y: -50))
        }, completion: nil)
    }
   
    // ----
    
    func resetTwirlButtons(){
        UIView.animate(withDuration: 0.2, delay: 0.2, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.btnMenu.transform = CGAffineTransform(rotationAngle: 0.25*3.1415927)
            
            self.btnTarget.alpha = 0
            self.btnTarget.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            
            self.btnHospital.alpha = 0
            self.btnHospital.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            
            self.btnSupermarket.alpha = 0
            self.btnSupermarket.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            
            self.btnMall.alpha = 0
            self.btnMall.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
        }, completion: nil)
        
    }
    
    //    func searchMap(_ searchString:String) {
    //        print ("I'm pretending to search for \(searchString)")
    //    }
    // LocalSearchRequest
    //
    // 搜索
    func searchMap(_ searchString:String) {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchString
        
        // 搜索当前区域
        // search radius
        //        let span = MKCoordinateSpanMake(0.09, 0.09)
        //        request.region = MKCoordinateRegion(center: initialLocation.coordinate, span: span)
        
        let searchRegion1 = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, initialSearchDistance, initialSearchDistance)
        request.region = searchRegion1
        //request.region = mapRegion1
        //request.region = mapView.region
//
//        //启动搜索,并且把返回结果保存到数组中
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
                    //                    print ("THIS IS DICTIONARY ITEM Street: \(myOtherVar ["Street"] ?? "nada")")
                    //                    print ("THIS IS DICTIONARY ITEM City: \(myOtherVar ["City"] ?? "nada")")
                    //                    print ("THIS IS DICTIONARY ITEM State: \(myOtherVar ["State"] ?? "nada")")
                    //                    print ("THIS IS DICTIONARY ITEM ZIP: \(myOtherVar ["ZIP"] ?? "nada")")
                    //                    print ("THIS IS DICTIONARY ITEM SubAdministrativeArea: \(myOtherVar ["SubAdministrativeArea"] ?? "nada")")
                    //                    print ("THIS IS DICTIONARY ITEM Thoroughfare: \(myOtherVar ["Thoroughfare"] ?? "nada")")
                    //                    print ("THIS IS DICTIONARY ITEM Country: \(myOtherVar ["Country"] ?? "nada")")
                    //                    print ("THIS IS DICTIONARY ITEM CountryCode: \(myOtherVar ["CountryCode"] ?? "nada")")
                    print ("THIS IS DICTIONARY ITEM FormattedAddressLines: \(myOtherVar ["FormattedAddressLines"] ?? "nada")")
                    print ("\n")

                    //                    var tempVar = (myOtherVar ["Street"] ?? "... ") as! String
                    //                    tempVar = tempVar + ", \(((myOtherVar ["City"] ?? "... ") as! String)), \((myOtherVar ["State"] ?? "got nothing") as! String)"
                    //                    self.mySubtitleString = tempVar
                }


                //
                //                if let myPlacemark = item.placemark.name{
                //                    print ("my placemark name: \(myPlacemark)")
                //                }
                //                if let myPlacemark = item.placemark.subtitle{
                //                    print ("my placemark subtitle: \(myPlacemark)")
                //                }
                //                if let myPlacemark = item.placemark.locality{
                //                    print ("my placemark locality: \(myPlacemark) \n\n")
                //

                //  WANT TO CHANGE TO APPLE'S addAnnotation stuff ??
                self.addAnnotation(item.name!, subtitle: self.mySubtitleString, latitude: (item.placemark.location?.coordinate.latitude)!, longitude: (item.placemark.location?.coordinate.longitude)!)
           }
        }
    }

    
    // Create a location manager to trigger user tracking
    let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        return manager
    }()
    
    func setupCompassButton() {
        let compass = MKCompassButton(mapView: mapView)
        compass.compassVisibility = .visible
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: compass)
        mapView.showsCompass = false
    }

    func setupUserTrackingButtonAndScaleView() {
        mapView.showsUserLocation = true
        
        let button = MKUserTrackingButton(mapView: mapView)
        button.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)

        let scale = MKScaleView(mapView: mapView)
        scale.legendAlignment = .trailing
        scale.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scale)
        
        NSLayoutConstraint.activate([button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
                                     button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                                     scale.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -10),
                                     scale.centerYAnchor.constraint(equalTo: button.centerYAnchor)])
    }
    
    func registerAnnotationViewClasses() {
        mapView.register(BikeView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(ClusterView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
    }
    
    /* Returns the distance (in meters) from the receiver’s location to the specified location.
     - (CLLocationDistance)distanceFromLocation:(const CLLocation *)location
     
     This will calculate the distance between two location by using the CLLocationDistance. By default it gives the values in meters. To convert to kilometers, divide the CLLocationDistance/1000.0. To get miles multiply the CLLocationDistance*0.62137.
     1 mile = 1.60934 km
 */
    

    func loadDataForMapRegionAndBikes() {
        
        if let plist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Data", ofType: "plist")!) {
            if (plist["region"] as? [NSNumber]) != nil {
//                let coordinate = CLLocationCoordinate2D(latitude: region[0].doubleValue, longitude: region[1].doubleValue)
                // let span = MKCoordinateSpanMake(region[2].doubleValue, region[3].doubleValue)
                let coordinate = CLLocationCoordinate2D(latitude: THOMPSON_GPS.latitude, longitude: THOMPSON_GPS.longitude)
                let initialDistance = CLLocationDistance(miles2meters(miles: 55.2))
                mapView.region = MKCoordinateRegionMakeWithDistance(coordinate, initialDistance, initialDistance)
                
                // mapView.region = MKCoordinateRegionMake(coordinate, span)
                
            }
            if let bikes = plist["bikes"] as? [[String : NSNumber]] {
                self.mapView.addAnnotations(Bike.bikes(fromDictionaries: bikes))
            }
        }
    }
    
    func addAnnotation(_ title:String, subtitle:String, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = ShepSingleAnnotation(coordinate: location, title: title, subtitle: subtitle)
        // annotation.pinTintColor
        
        mapView.addAnnotation(annotation)
        
        //        if let currentPlacemarkCoordinate = currentPlacemark?.location?.coordinate {
        //            if currentPlacemarkCoordinate.latitude == annotation.coordinate.latitude &&
        //                currentPlacemarkCoordinate.longitude == annotation.coordinate.longitude {
        //
        //               let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
        //                leftIconView.image = UIImage(named: "pure_thai_cookhouse")!
        //                annotation?.leftCalloutAccessoryView = leftIconView
        ////
        //                // Pin color customization
        //                if #available(iOS 9.0, *) {
        //                    annotation?.pinTintColor = UIColor.orange
        //               }
        //            } else {
        //                // Pin color customization
        //                if #available(iOS 9.0, *) {
        //                    annotationView?.pinTintColor = UIColor.red
        //                }
        //            }
        //        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCompassButton()
        setupUserTrackingButtonAndScaleView()
        registerAnnotationViewClasses()
        loadDataForMapRegionAndBikes()
        
        // ----
        self.btnMenu.alpha = 0
        self.btnTarget.alpha = 0
        self.btnHospital.alpha = 0
        self.btnSupermarket.alpha = 0
        self.btnMall.alpha = 0
        
        self.btnHospital.layer.cornerRadius = 10
        self.btnTarget.layer.cornerRadius = 10
        self.btnSupermarket.layer.cornerRadius = 10
        self.btnMall.layer.cornerRadius = 10
        self.btnMenu.layer.cornerRadius = 10
        
        // self.shepBtn2.layer.cornerRadius = 10
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.btnMenu.alpha = 1
            self.btnMenu.transform = CGAffineTransform(rotationAngle: 0.25*3.1415927)
        }, completion: nil)
        
        // create initial region for map
        let mapRegion1 = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, initialDisplayDistance, initialDisplayDistance)
        mapView.setRegion(mapRegion1, animated: true)
        
       // searchMap(initialMapSearch)
    
        }
    }



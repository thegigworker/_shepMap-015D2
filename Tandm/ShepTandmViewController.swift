//  ShepMapController.swift
//

import UIKit
import MapKit

let THOMPSON_GPS = (latitude: 41.9360805, longitude: -71.7978248)
// Hartford_GPS:  41.767603, -72.684036
// Yankee Stadium:  40.830304, -73.926089

let initialLocation = CLLocation(latitude: THOMPSON_GPS.latitude, longitude: THOMPSON_GPS.longitude)
let initialDisplayDistance = CLLocationDistance(miles2meters(miles: 18))
let initialSearchDistance = CLLocationDistance(miles2meters(miles: 20))
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
    
    var currentDisplayDistance = initialDisplayDistance
    var currentSearchDistance = initialSearchDistance
    var myArray_MKMapItems = [MKMapItem]()
    var shepAnnotationsArray = [SingleAnnotationData]()
    
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
    
    //   RE DETECTING END OF SLIDER CHANGE
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
    
    
    // 搜索
    func performLocalSearch(_ searchString:String) {
        //myArray_MKMapItems.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchString
        // 搜索当前区域
        let searchRegion1 = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, initialSearchDistance, initialSearchDistance)
        request.region = searchRegion1
        //request.region = mapView.region

        // 启动搜索,并且把返回结果保存到数组中
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            // Local searches are performed asynchronously
            //and a completion handler called when the search is complete.
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                //The code in the completion handler checks the response to make sure that matches were found
                //and then accesses the mapItems property of the response which contains an array of mapItem instances for the matching locations.
                for item in response!.mapItems {
                    print("Name = \(String(describing: item.name!))")
                    //print("Description = \(String(describing: item.description)) \n")
                    //print("Placemark = \(String(describing: item.placemark)) \n")
                    
                    self.myArray_MKMapItems.append(item as MKMapItem)
                    print("Matching items = \(self.myArray_MKMapItems.count) \n")
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    // print("Annotation.coordinate = \(String(describing: item.placemark.coordinate)) \n")
                    annotation.title = item.name

                    self.mapView.addAnnotation(annotation)
            //        self.addAnnotation(item.name!, subtitle: self.mySubtitleString, latitude: (item.placemark.location?.coordinate.latitude)!, longitude: (item.placemark.location?.coordinate.longitude)!)
                    
                    let shepsPassedVariable = Double(arc4random_uniform(25) + 1)
                    let shepPassedString = shepCurrencyFromDouble(shepNumber: shepsPassedVariable)
                    let validResult = SingleAnnotationData(searchResult: item, shepPassedVariable: shepsPassedVariable, shepPassedString: shepPassedString)
                    self.shepAnnotationsArray.append(validResult)
                    print ("shepAnnotationsArray count is \(self.shepAnnotationsArray.count) \n")
                    
                }
            }
        })
    }

    
    @IBAction func btnHospitalClick(_ sender: AnyObject) {
        print ("in Hospclick")
        mapView.removeAnnotations(mapView.annotations)
        performLocalSearch("Hospital")
        resetTwirlButtons()
    }
    
    @IBAction func btnTargetClick(_ sender: AnyObject) {
        print ("in targetclick")
        mapView.removeAnnotations(mapView.annotations)
        performLocalSearch("Target")
        resetTwirlButtons()
    }
    
    @IBAction func btnGasClick(_ sender: AnyObject) {
        print ("in gasclick")
        mapView.removeAnnotations(mapView.annotations)
        performLocalSearch("gas station")
        resetTwirlButtons()
    }
    
    @IBAction func btnSupermarket(_ sender: AnyObject) {
        print ("in suprmarkclick")
        mapView.removeAnnotations(mapView.annotations)
        //performLocalSearch("Market Basket")
        performLocalSearch("Stop & Shop")
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
        //mapView.register(BikeView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        //mapView.register(ClusterView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        mapView.register(SingleAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    /* Returns the distance (in meters) from the receiver’s location to the specified location.
     - (CLLocationDistance)distanceFromLocation:(const CLLocation *)location
     
     This will calculate the distance between two location by using the CLLocationDistance. By default it gives the values in meters. To convert to kilometers, divide the CLLocationDistance/1000.0. To get miles multiply the CLLocationDistance*0.62137.
     1 mile = 1.60934 km
     */
    
    func loadDataForMapRegionAndBikes() {
        if let plist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Data", ofType: "plist")!) {
            if (plist["region"] as? [NSNumber]) != nil {
                //  let coordinate = CLLocationCoordinate2D(latitude: region[0].doubleValue, longitude: region[1].doubleValue)
                // let span = MKCoordinateSpanMake(region[2].doubleValue, region[3].doubleValue)
                let coordinate = CLLocationCoordinate2D(latitude: THOMPSON_GPS.latitude, longitude: THOMPSON_GPS.longitude)
                let initialDistance = CLLocationDistance(miles2meters(miles: 55.2))
                mapView.region = MKCoordinateRegionMakeWithDistance(coordinate, initialDistance, initialDistance)
                
                // mapView.region = MKCoordinateRegionMake(coordinate, span)
                
            }
            if let makeAppleArrayofAnnts = plist["bikes"] as? [[String : NSNumber]] {
                self.mapView.addAnnotations(AppleSingleAnnotation.makeAppleArrayofAnnts(fromDictionaries: makeAppleArrayofAnnts))
            }
        }
    }
    
    
    /// not using this function at the moment
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, currentDisplayDistance, currentDisplayDistance)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
//    func addAnnotationX(_ title:String, subtitle:String, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
//
//        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        let annotation = ShepSingleAnnotation(coordinate: location, title: title, subtitle: subtitle)
//        // annotation.pinTintColor
//
//        mapView.addAnnotation(annotation)
//
//        //        if let currentPlacemarkCoordinate = currentPlacemark?.location?.coordinate {
//        //            if currentPlacemarkCoordinate.latitude == annotation.coordinate.latitude &&
//        //                currentPlacemarkCoordinate.longitude == annotation.coordinate.longitude {
//        //
//        //               let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
//        //                leftIconView.image = UIImage(named: "pure_thai_cookhouse")!
//        //                annotation?.leftCalloutAccessoryView = leftIconView
//        ////
//        //                // Pin color customization
//        //                if #available(iOS 9.0, *) {
//        //                    annotation?.pinTintColor = UIColor.orange
//        //               }
//        //            } else {
//        //                // Pin color customization
//        //                if #available(iOS 9.0, *) {
//        //                    annotationView?.pinTintColor = UIColor.red
//        //                }
//        //            }
//        //        }
//        
//    }
    
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
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.btnMenu.alpha = 1
            self.btnMenu.transform = CGAffineTransform(rotationAngle: 0.25*3.1415927)
        }, completion: nil)
        
        // create initial region for map
        let mapRegion1 = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, initialDisplayDistance, initialDisplayDistance)
        mapView.setRegion(mapRegion1, animated: true)
        
       // performLocalSearch(initialMapSearch)
        
        //All that’s left is setting ViewController as the delegate of the map view.
        // You can do this in Main.storyboard, but I prefer to do it in code, where it’s more visible.
        mapView.delegate = self
    
        }
    }

/*  Configuring the Annotation View
 One way to configure the annotation view is to implement the map view’s mapView(_:viewFor:) delegate method. Your job in this delegate method is to return an instance of MKAnnotationView, to present as a visual indicator of the annotation.
 In this case, ViewController will be the delegate for the map view. To avoid clutter and improve readability, you’ll create an extension of the ViewController class.
 */
extension ViewController {
    //extension ViewController: MKMapViewDelegate {
    
    // mapView annotation calloutAccessoryControl was tapped, open Maps
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! SingleAnnotationData
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        // Note: Explore the MKMapItem documentation to see other launch option dictionary keys,
        // and the openMaps(with:launchOptions:) method that lets you pass an array of MKMapItem objects.
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
}

// Shep:  we're currently using an alternative way to set up annotations.  We're using the separate class SingleAnnotationView
// And we're registering using the map view’s default reuse identifier with mapView.register --- registerAnnotationViewClasses
// Below is a commented out alternative way to set up annotations -- has good text comments
// ------------
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        // 2
//       // Your app might use other annotations, like user location, so check that this annotation is an SingleAnnotationData object.
//        // If it isn’t, return nil to let the map view use its default annotation view.
//        guard let annotation = annotation as? SingleAnnotationData else { return nil }
//        // 3
//       // To make markers appear, you create each view as an MKMarkerAnnotationView.
//        // Later in this tutorial, you’ll create MKAnnotationView objects, to display images instead of markers.
//        let identifier = "marker"
//        var view: MKMarkerAnnotationView
//        /* 4
//        Note: When you dequeue a reusable annotation, you give it an identifier. If you have multiple styles of annotations, be sure to have a unique identifier for each one, otherwise you might mistakenly dequeue an identifier of a different type, and have unexpected behavior in your app.
//         */
//        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//            as? MKMarkerAnnotationView {
//            dequeuedView.annotation = annotation
//            view = dequeuedView
//        } else {
//            // 5
//            // Here you create a new MKMarkerAnnotationView object, if an annotation view could not be dequeued.
//            // It uses the title and subtitle properties of your SingleAnnotationData class to determine what to show in the callout.
//            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            view.canShowCallout = true
//            view.calloutOffset = CGPoint(x: -5, y: 5)
//            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        }
//        return view
//    }


// -----------------------------------------------
/* Next, you have to tell MapKit what to do when the user taps the callout button.
 When the user taps a map annotation marker, the callout shows an info button. If the user taps this info button, the mapView(_:annotationView:calloutAccessoryControlTapped:) method is called.
 In this method, you grab the SingleAnnotationData object that this tap refers to, and then launch the Maps app by creating an associated MKMapItem, and calling openInMaps(launchOptions:) on the map item.
 Notice you’re passing a dictionary to this method. This allows you to specify a few different options; here the DirectionModeKey is set to Driving. This causes the Maps app to show driving directions from the user’s current location to this pin. Neat!
 */



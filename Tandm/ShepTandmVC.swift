/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The application's view controller, responsible for managing a map view with a set of Bike annotations.
*/
import MapKit

let THOMPSON_GPS = (latitude: 41.9360805, longitude: -71.7978248)
// Hartford_GPS:  41.767603, -72.684036
// Yankee Stadium:  40.830304, -73.926089


class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!

    
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
    
    func miles2meters (miles: Double) -> Double {
        let meters = miles * 1609.34
        return meters
    }
    
    func meters2miles (meters: Double) -> Double {
        let miles = meters * 0.00062137
        return miles
    }

    func loadDataForMapRegionAndBikes() {
        
       // let initialLocation = CLLocation(latitude: THOMPSON_GPS.latitude, longitude: THOMPSON_GPS.longitude)
        
        if let plist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Data", ofType: "plist")!) {
            if let region = plist["region"] as? [NSNumber] {
//                let coordinate = CLLocationCoordinate2D(latitude: region[0].doubleValue, longitude: region[1].doubleValue)
                // let span = MKCoordinateSpanMake(region[2].doubleValue, region[3].doubleValue)
                let coordinate = CLLocationCoordinate2D(latitude: THOMPSON_GPS.latitude, longitude: THOMPSON_GPS.longitude)
                let initialDistance = CLLocationDistance(miles2meters(miles: 55.2))
                mapView.region = MKCoordinateRegionMakeWithDistance(coordinate, initialDistance, initialDistance)
                
                // mapView.region = MKCoordinateRegionMake(coordinate, span)
                
                // ??
                // mapView.setRegion(mapView.region, animated: true)
                
            
                // create region for map
//                let initialDistance = CLLocationDistance(20000)
//                let region1 = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, initialDistance, initialDistance)
//                mapView.setRegion(region1, animated: true)
                
            }
            if let bikes = plist["bikes"] as? [[String : NSNumber]] {
                mapView.addAnnotations(Bike.bikes(fromDictionaries: bikes))
            }
        }
    }
    
    
    /* ShepMap2 initial mapview setup
     
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
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCompassButton()
        setupUserTrackingButtonAndScaleView()
        registerAnnotationViewClasses()
        loadDataForMapRegionAndBikes()
    }
    
}


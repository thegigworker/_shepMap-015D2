/*
 
 
//  ShepMapController.swift
//  SearchMap Ottawa
//
// try this

import UIKit
import MapKit

let THOMPSON_GPS = (latitude: 41.9360805, longitude: -71.7978248)
// Hartford_GPS:  41.767603, -72.684036
// Yankee Stadium:  40.830304, -73.926089

class ShepMap1ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnHospital: UIButton!
    @IBOutlet weak var btnHotel: UIButton!
    @IBOutlet weak var btnMall: UIButton!
    @IBOutlet weak var btnSupermarket: UIButton!
    @IBOutlet weak var btnMenu: UIButton!

    
    @IBAction func btnHospitalClick(_ sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
        searchMap("Hospital")
        //searchMap("Market Basket")
        reset()
    }
    
    @IBAction func btnHotelClick(_ sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
        searchMap("Target")
        reset()
    }
    
    @IBAction func btmMallClick(_ sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
        searchMap("Walmart")
        reset()
    }
    
    @IBAction func btnSupermarket(_ sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
        searchMap("Stop & Shop")
        reset()
    }
    
//    let locationManager = CLLocationManager()
//    let initialLocation = CLLocation(latitude: THOMPSON_GPS.latitude, longitude: THOMPSON_GPS.longitude)
//    // search range
//    let initialDisplayRadius = CLLocationDistance(20000)
    
    @IBAction func btnMenuClick(_ sender: AnyObject) {
        
        UIView.animate(withDuration: 0.1, delay: 0.05, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.btnMenu.transform = CGAffineTransform(rotationAngle: 0)
            
            self.btnHotel.alpha = 0.8
            self.btnHotel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: -50, y: -25))
            
            self.btnHospital.alpha = 0.8
            self.btnHospital.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: -100, y: 30))
            
            self.btnSupermarket.alpha = 0.8
            self.btnSupermarket.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: 80, y: 10))
            
            self.btnMall.alpha = 0.8
            self.btnMall.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: 100, y: -50))
        }, completion: nil)
        
    }
    
    let locationManager = CLLocationManager()
    let initialLocation = CLLocation(latitude: THOMPSON_GPS.latitude, longitude: THOMPSON_GPS.longitude)
    // search range?
    let initialDisplayRadius = CLLocationDistance(20000)
    var mySubtitleString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnMenu.alpha = 0
        self.btnHotel.alpha = 0
        self.btnHospital.alpha = 0
        self.btnSupermarket.alpha = 0
        self.btnMall.alpha = 0
        
        self.btnHospital.layer.cornerRadius = 10
        self.btnHotel.layer.cornerRadius = 10
        self.btnSupermarket.layer.cornerRadius = 10
        self.btnMall.layer.cornerRadius = 10
        self.btnMenu.layer.cornerRadius = 10
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.btnMenu.alpha = 1
            self.btnMenu.transform = CGAffineTransform(rotationAngle: 0.25*3.1415927)
        }, completion: nil)
        
        // create region for map
        let region1 = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, initialDisplayRadius, initialDisplayRadius)
        mapView.setRegion(region1, animated: true)

        searchMap("park")
        
        // create region
        //        let region2 = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, initialDisplayRadius, initialDisplayRadius)
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
                    
                    var tempVar = (myOtherVar ["Street"] ?? "... ") as! String
                    tempVar = tempVar + ", \(((myOtherVar ["City"] ?? "... ") as! String)), \((myOtherVar ["State"] ?? "got nothing") as! String)"
                    self.mySubtitleString = tempVar
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
                //                }
                self.addAnnotation(item.name!, subtitle: self.mySubtitleString, latitude: (item.placemark.location?.coordinate.latitude)!, longitude: (item.placemark.location?.coordinate.longitude)!)
            }
            
        }
    }

    func reset(){
        
        UIView.animate(withDuration: 0.2, delay: 0.2, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.btnMenu.transform = CGAffineTransform(rotationAngle: 0.25*3.1415927)
            
            self.btnHotel.alpha = 0
            self.btnHotel.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            
            self.btnHospital.alpha = 0
            self.btnHospital.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            
            self.btnSupermarket.alpha = 0
            self.btnSupermarket.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            
            self.btnMall.alpha = 0
            self.btnMall.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
        }, completion: nil)
        
    }
    
    
    func addAnnotation(_ title:String, subtitle:String, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = ShepMap1SingleAnnotation(coordinate: location, title: title, subtitle: subtitle)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
 */


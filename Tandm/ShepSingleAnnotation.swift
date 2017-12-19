//  ShepSingleAnnotation.swift
//

import Foundation
import MapKit

import Contacts
// This adds the Contacts framework, which contains dictionary key constants such as CNPostalAddressStreetKey,
// for when you need to set the address, city or state fields of a location.


//To create your own annotations, you create a class that conforms to the MKAnnotation protocol, add the annotation to the map,
//and inform the map how the annotation should be displayed.
class ShepSingleAnnotation: NSObject, MKAnnotation {
    let origTitle: String?
    //let locationName: String
    //let discipline: String
    let coordinate: CLLocationCoordinate2D
    let shepDollarValue: Double
    let shepStringData: String
    var myMapItem: MKMapItem
    var currentRoute: MKRoute?
    //let myDataModelInstance = shepDataModel(myMapItem: myMapItem, currentRoute: currentRoute)
    
    init(myMapItem: MKMapItem, currentRoute: MKRoute, shepDollarValue: Double) {
        self.origTitle = myMapItem.name ?? "No Title"
        //self.locationName = myMapItem.name! //searchResult.description
        self.shepDollarValue = shepDollarValue
        self.myMapItem = myMapItem
        //self.currentRoute = currentRoute
        self.currentRoute = currentRoute
        self.shepStringData = shepCurrencyFromDouble(shepNumber: self.shepDollarValue)
//        self.shepsVariable = Double(arc4random_uniform(25) + 1)
//        self.shepStringData = shepCurrencyFromDouble(shepNumber: self.shepsVariable)
        let latitude = myMapItem.placemark.coordinate.latitude
        let longitude = myMapItem.placemark.coordinate.longitude
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        super.init()
    }
    
    
//    init?(json: [Any]) {
//        // 1
//        self.origTitle = json[16] as? String ?? "No Title"
//        self.locationName = json[12] as! String
//        // self.discipline = json[15] as! String
//        //self.shepsVariable = 0.0
//        //self.shepStringData = "Ain't nothing but a G thing"
//        self.shepsVariable = Double(arc4random_uniform(25) + 1)
//        self.shepStringData = shepCurrencyFromDouble(shepNumber: self.shepsVariable)
//
//        if let latitude = Double(json[18] as! String),
//            let longitude = Double(json[19] as! String) {
//            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        } else {
//            self.coordinate = CLLocationCoordinate2D()
//        }
//    }
    
    //   The MKAnnotation protocol requires the coordinate property. If you want your annotation view to display a title and subtitle when the user taps a pin, your class also needs properties named title and subtitle.
    var title: String? {
        let temp: String?
        temp = self.origTitle
        return shepStringData + " --- " + temp!
    }
    
    var subtitle: String? {
        // takes the placemark.title string, which is really the address line, and cuts off the last 15 chars: ", United States"
        return String(myMapItem.placemark.title!.dropLast(_:15))
    }
    
//    var crowFliesDistance: String? {
//        let thisLocation = CLLocation(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
//        let distance = myUserLocation.distance(from: thisLocation) // result is in meters
//        let distanceInMiles = meters2miles(meters: distance)
//        return String(format: "%.02f", distanceInMiles)
//    }
    
    var routeDrivingDistance: Double {
        if let myRoute = self.currentRoute {
            let drivingDistance = meters2miles(meters: myRoute.distance)
            return drivingDistance // drivingDistance in miles
        } else {
            //let drivingDistance = 0.0
            return 0.0
        }
    }
    
    var bestRouteScore: Double {
        if let myRoute = self.currentRoute {
            let drivingDistance = meters2miles(meters: myRoute.distance)
            let tempDataModel = shepDataModel()
            let tempCentsPerMileDecimal = Double(100/tempDataModel.centsPerMileExpense)
            var bestRouteScore = drivingDistance * tempCentsPerMileDecimal 
            bestRouteScore = shepDollarValue - bestRouteScore
            return bestRouteScore // drivingDistance in miles
        } else {
            //let drivingDistance = 0.0
            return 0.0
        }
    }
    
    var drivingTime: Double {
        if let myRoute = self.currentRoute {
            let drivingTime = myRoute.expectedTravelTime / 60
            return drivingTime // drivingDistance in miles
        } else {
            //let drivingDistance = 0.0
            return 0.0
        }
    }
    
    
                //    self.lblDrivingDistance.text = "Driving distance: \(String(format: "%.02f", drivingDistance)) miles"
                //return drivingDistance
//                } else {
//                    let NildrivingDistance = 0
//                    return NildrivingDistance
//                }

                
      /*          The if let statement takes an optional variable. If it is nil, the else block or nothing is executed. If it has a value, the value is assigned to a different variable as a non-optional type.
                
                So, the following code would output the value of score1 or "No" if there is none:
                
                if let score1Unwrapped = score1
                { print(score1Unwrapped)
                } else {print("No")}
                 
                A shorter version of the same would be:
                print(score1 ?? "No")
                 
                In your case, where you don't actually use the value stored in the optional variable, you can also check if the value is nil:
                
                if score1 != nil {
                    ...
                }
       */
                
    
//    let searchResultCoordinates = item.placemark.coordinate
//    let searchResultLocation = CLLocation(latitude: searchResultCoordinates.latitude, longitude: searchResultCoordinates.longitude)
//    let mapItemDistance = myUserLocation.distance(from: searchResultLocation) // result is in meters
//    //let distanceInMiles = meters2miles(meters: mapItemDistance)
    
//    let crowFliesDistance = sourceLocation.distance(from: destinationLocation) // result is in meters
//    let distanceInMiles = meters2miles(meters: crowFliesDistance)
//    self.lblCrowFlies.text = "As crow flies: \(String(format: "%.02f", distanceInMiles)) miles"
    
    
    // Annotation right callout accessory opens this mapItem in Maps app
    // Here you create an MKMapItem from an MKPlacemark. The Maps app is able to read this MKMapItem, and display the right thing.
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        //mapItem.name = title
        mapItem.name = title
        return mapItem
    }
    
    func switchTintColor() -> UIColor {
        switch shepDollarValue {
        case 0..<1:
            return .black
        case 1...10:
            return .darkGray
        case 11...20:
            return .orange
        case 21...30:
            return .green
        case 31...40:
            return .white
        default:
            return .white
        }
    }
    
    func switchGlyph() -> String? { // marker glyph
        switch shepDollarValue {
        case 0...10:
            return "tricycle"
        case 11...20:
            return "unicycle"
        case 21...30:
            return "monopoly man"
        case 31...40:
            return "Flag"
        default:
            return "HMI"
        }
    }
    
    func switchImage() -> String? { // leftCalloutAccessory image
        switch shepDollarValue {
        case 0...10:
            return "zzz..."
        case 11...20:
            return "coins"
        case 21...30:
            return "dollars"
        case 31...40:
            return "monopoly man"
        default:
            return "superman"
        }
    }
    
}


//class ShepSingleAnnotation: NSObject, MKAnnotation {
//
//    var coordinate: CLLocationCoordinate2D
//    var phone: String!
//    var name: String!
//    var address: String!
//    var image: UIImage!
//
//    init(coordinate: CLLocationCoordinate2D) {
//        self.coordinate = coordinate
//    }
//}


// extension ViewController: MKMapViewDelegate {
    
    // 1
    //    func myMapView(_ myMapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //        if let annotation = annotation as? ShepShepSingleAnnotation {
    //            let identifier = "artPin"
    //            var view: MKPinAnnotationView
    //            if let dequeuedView = myMapView.dequeueReusableAnnotationView(withIdentifier: identifier)
    //                as? MKPinAnnotationView { // 2
    //                dequeuedView.annotation = annotation
    //                view = dequeuedView
    //            } else {
    //                // 3
    //                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
    //                view.canShowCallout = true
    //                view.calloutOffset = CGPoint(x: -5, y: 5)
    //                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
    //
    //                //view.annotationImage = UIImage(named: <#T##String#>)
    //                //view.leftCalloutAccessoryView = UILabel(.text("Hello"))as UIView
    //            }
    //
    //            // annotation.
    //            view.pinTintColor = annotation.pinTintColor()
    //            return view
    //        }
    //        return nil
    //}
    
    
    //// this is where we draw an image on the leftCalloutAccessoryView
    //func myMapView(_ myMapView: MKMapView, didSelect view: MKAnnotationView) {
    //    if let thumbnailImageButton = view.leftCalloutAccessoryView as? UIButton,
    //        let url = (view.annotation as? GPX.shepShepSingleAnnotation)?.thumbnailURL,
    //        let imageData = try? Data(contentsOf: url as URL), // blocks main queue
    //        let image = UIImage(data: imageData) {
    //        thumbnailImageButton.setImage(image, for: UIControlState())
    //    }
    //}
    
    
    //CODE FROM SHEP_MAPKIT x?
    //
    //func myMapView(_ myMapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //    let identifier = "MyPin"
    //
    //    if annotation is MKUserLocation {
    //        return nil
    //    }
    //
    //    // Reuse the annotation if possible
    //    var annotationView:MKPinAnnotationView? = myMapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
    //
    //    if annotationView == nil {
    //        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
    //        annotationView?.canShowCallout = true
    //    }
    //
    ////    if let currentPlacemarkCoordinate = currentPlacemark?.location?.coordinate {
    ////        if currentPlacemarkCoordinate.latitude == annotation.coordinate.latitude &&
    ////            currentPlacemarkCoordinate.longitude == annotation.coordinate.longitude {
    ////
    ////            let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
    ////            leftIconView.image = UIImage(named: restaurant.image)!
    ////            annotationView?.leftCalloutAccessoryView = leftIconView
    ////
    ////            // Pin color customization
    ////            if #available(iOS 9.0, *) {
    ////                annotationView?.pinTintColor = UIColor.orange
    ////            }
    ////        } else {
    ////            // Pin color customization
    ////            if #available(iOS 9.0, *) {
    ////                annotationView?.pinTintColor = UIColor.red
    ////            }
    ////        }
    //    }
    //
    //    // annotationView?.rightCalloutAccessoryView = UIButton(type: UIButtonType.detailDisclosure)
    //
    //   return annotationView
    //}
    
    
    // CODE FROM TRAX
    //
    //func myMapView(_ myMapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //    var view: MKAnnotationView! = myMapView.dequeueReusableAnnotationView(withIdentifier: Constants.AnnotationViewReuseIdentifier)
    //    //
    //    let reuseId = "temp" // Constants.AnnotationViewReuseIdentifier
    //
    //    var pinView = myMapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
    //    if pinView == nil {
    //        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
    //        pinView!.canShowCallout = true
    //        pinView!.animatesDrop = true
    //        pinView!.pinTintColor = .purple
    //        // pinView!.pinTintColor = GPX.shepShepSingleAnnotation.pinTintColor(GPX.shepShepSingleAnnotation)()
    //    } else {
    //        pinView!.pinTintColor = .green
    //        pinView!.annotation = annotation
    //    }
    //
    //    //        if annotation is GPX.shepShepSingleAnnotation {
    //    //            let shepsPinView: MKPinAnnotationView  = MKPinAnnotationView.redPinColor()
    //    //            shepsPinView.pinTintColor = .purple // annotation.pinTintColor()
    //    //            // shepsPinView.pinTintColor = annotation.pinTintColor() as! UIColor
    //    //         }
    //    //
    //    if view == nil {
    //        view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: Constants.AnnotationViewReuseIdentifier)
    //        view.canShowCallout = true
    //    } else {
    //        view.annotation = annotation
    //    }
    //
    //    view.isDraggable = annotation is EditableWaypoint
    //
    //    view.leftCalloutAccessoryView = nil
    //    view.rightCalloutAccessoryView = nil
    //    if let waypoint = annotation as? GPX.shepShepSingleAnnotation {
    //        if waypoint.thumbnailURL != nil {
    //            view.leftCalloutAccessoryView = UIButton(frame: Constants.LeftCalloutFrame)
    //        }
    //        if waypoint is EditableWaypoint {
    //            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    //        }
    //    }
    //
    //    return view
    //}
    //
    //
    //
    //// this is where we draw an image on the leftCalloutAccessoryView
    //func myMapView(_ myMapView: MKMapView, didSelect view: MKAnnotationView) {
    //    if let thumbnailImageButton = view.leftCalloutAccessoryView as? UIButton,
    //        let url = (view.annotation as? GPX.shepShepSingleAnnotation)?.thumbnailURL,
    //        let imageData = try? Data(contentsOf: url as URL), // blocks main queue
    //        let image = UIImage(data: imageData) {
    //        thumbnailImageButton.setImage(image, for: UIControlState())
    //    }
    //}
    //
    //// calloutAccessoryControlTapped
    //func myMapView(_ myMapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    //    if control == view.leftCalloutAccessoryView {
    //        performSegue(withIdentifier: Constants.ShowImageSegue, sender: view)
    //    } else if control == view.rightCalloutAccessoryView  {
    //        myMapView.deselectAnnotation(view.annotation, animated: true)
    //        performSegue(withIdentifier: Constants.EditUserWaypoint, sender: view)
    //    }
    //}
    //
    //// MARK: Navigation
    //
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    let destination = segue.destination.contentViewController
    //    let annotationView = sender as? MKAnnotationView
    //    let waypoint = annotationView?.annotation as? GPX.shepShepSingleAnnotation
    //
    //    if segue.identifier == Constants.ShowImageSegue {
    //        if let ivc = destination as? ImageViewController {
    //            ivc.imageURL = waypoint?.imageURL
    //            ivc.title = waypoint?.name
    //        }
    //    } else if segue.identifier == Constants.EditUserWaypoint {
    //        if let editableWaypoint = waypoint as? EditableWaypoint,
    //            let ewvc = destination as? EditWaypointViewController {
    //            if let ppc = ewvc.popoverPresentationController {
    //                ppc.sourceRect = annotationView!.frame
    //                ppc.delegate = self
    //            }
    //            ewvc.waypointToEdit = editableWaypoint
    //        }
    //    }
    //}
    //
   //// END OF CODE FROM TRAX


////UIColor functions -- DEPRECATED FORMAT
////    public class func darkGrayColor() -> UIColor // 0.333 white
////    public class func lightGrayColor() -> UIColor // 0.667 white
////    public class func whiteColor() -> UIColor // 1.0 white
////    public class func grayColor() -> UIColor // 0.5 white
////    public class func redColor() -> UIColor // 1.0, 0.0, 0.0 RGB
////    public class func greenColor() -> UIColor // 0.0, 1.0, 0.0 RGB
////    public class func blueColor() -> UIColor // 0.0, 0.0, 1.0 RGB
////    public class func cyanColor() -> UIColor // 0.0, 1.0, 1.0 RGB
////    .yellow // 1.0, 1.0, 0.0 RGB
//
////     CURRENT FORMAT
////     UIColor.magenta // 1.0, 0.0, 1.0 RGB
////    .orange // 1.0, 0.5, 0.0 RGB
////    .purple // 0.5, 0.0, 0.5 RGB
////    .brown // 0.6, 0.4, 0.2 RGB
////    .white  0.0 white, 0.0 alpha
////    .yellow // 1.0, 1.0, 0.0 RGB
////    .black // 0.0 white
//
//
////

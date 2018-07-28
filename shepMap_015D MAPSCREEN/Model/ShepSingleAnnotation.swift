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
    init(myMapItem: MKMapItem, currentLinkedRoute: MKRoute, shepDollarValue: Double) {
        self.origTitle = myMapItem.name ?? "No Title"
        //self.locationName = myMapItem.name! //searchResult.description
        self.shepDollarValue = shepDollarValue
        self.myMapItem = myMapItem
        self.currentLinkedRoute = currentLinkedRoute
        //self.currentLinkedRoute = currentLinkedRoute
        self.shepStringData = shepCurrencyFromDouble(shepNumber: self.shepDollarValue)
        //        self.shepsVariable = Double(arc4random_uniform(25) + 1)
        //        self.shepStringData = shepCurrencyFromDouble(shepNumber: self.shepsVariable)
        let latitude = myMapItem.placemark.coordinate.latitude
        let longitude = myMapItem.placemark.coordinate.longitude
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        super.init()
    }
    
    //MARK:----My Properties----
    let myDataModel = shepDataModel()
    let origTitle: String?
    let coordinate: CLLocationCoordinate2D
    let shepDollarValue: Double
    let shepStringData: String
    var myMapItem: MKMapItem
    var currentLinkedRoute: MKRoute
    var crowFliesDistance: Double = 0.0
    
    //   The MKAnnotation protocol requires the coordinate property. If you want your annotation view to display a title and subtitle when the user taps a pin, your class also needs properties named title and subtitle.
    var title: String? {
        let temp: String?
        temp = self.origTitle
        return shepStringData + " -- " + temp!
    }
    
    var subtitle: String? {
        // takes the placemark.title string, which is really the address line, and cuts off the last 15 chars: ", United States"
        return String(myMapItem.placemark.title!.dropLast(_:15))
        //return "hello"
    }
    
    var routeDrivingDistance: Double {
        let drivingDistance = meters2miles(meters: currentLinkedRoute.distance)
        return drivingDistance // drivingDistance in miles
    }
    
    var goldRouteScore: Double {
        let drivingDistance = meters2miles(meters: currentLinkedRoute.distance)
        let routeExpense = drivingDistance * Double(myDataModel.centsPerMileExpense)/100
        let mytheChosenRouteScore = shepDollarValue - routeExpense
        return mytheChosenRouteScore
    }
    
    var drivingTime: Double {
        let drivingTime = currentLinkedRoute.expectedTravelTime / 60
        return drivingTime // drivingDistance in miles
    }
    
    
    // Annotation right callout accessory opens this mapItem in Maps app
    // Here you create an MKMapItem from an MKPlacemark. The Maps app is able to read this MKMapItem, and display the right thing.
    //MARK:----My functions----
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        //var placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        //placemark.title = "xyz"
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
    func switchTintColor() -> UIColor {
        switch shepDollarValue {
        case 0...10:
            return .lightGray
        case 11...20:
            return .brown
        case 21...30:
            return .orange
        case 31...40:
            return .blue
        case 41...49:
            return .green
        case 50...60:
            return .magenta
        default:
            return .white
        }
    }
    
    func switchGlyph() -> String? { // marker glyph
        switch shepDollarValue {
        case 0...39:
            return "nothing"
        case 40...60:
            return "Flag"
        default:
            return "HMI"
        }
    }
    
    func switchImage() -> String? { // leftCalloutAccessory image
        switch shepDollarValue {
        case 0...15:
            return "zzz..."
        case 16...30:
            return "coins"
        case 31...49:
            return "dollars"
        case 50...60:
            return "monopoly man"
        default:
            return "superman"
        }
    }
    
}

//// this is where we draw an image on the leftCalloutAccessoryView
//func myMapView(_ myMapView: MKMapView, didSelect view: MKAnnotationView) {
//    if let thumbnailImageButton = view.leftCalloutAccessoryView as? UIButton,
//        let url = (view.annotation as? GPX.shepShepSingleAnnotation)?.thumbnailURL,
//        let imageData = try? Data(contentsOf: url as URL), // blocks main queue
//        let image = UIImage(data: imageData) {
//        thumbnailImageButton.setImage(image, for: UIControlState())
//    }
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
//// EditableWaypoints are draggable so their coordinate needs to be settable
//
//class EditableWaypoint : shepDataSource.shepSingleAnnotation
//{
//    override var coordinate: CLLocationCoordinate2D {
//        get {
//            return super.coordinate
//        }
//        set {
//            latitude = newValue.latitude
//            longitude = newValue.longitude
//        }
//    }
//}
//
//// END OF CODE FROM TRAX


////UIColor functions -- DEPRECATED FORMAT
//    public class func darkGrayColor() -> UIColor // 0.333 white
//    public class func lightGrayColor() -> UIColor // 0.667 white
//    public class func whiteColor() -> UIColor // 1.0 white
//    public class func grayColor() -> UIColor // 0.5 white
//    public class func redColor() -> UIColor // 1.0, 0.0, 0.0 RGB
//    public class func greenColor() -> UIColor // 0.0, 1.0, 0.0 RGB
//    public class func blueColor() -> UIColor // 0.0, 0.0, 1.0 RGB
//    public class func cyanColor() -> UIColor // 0.0, 1.0, 1.0 RGB
//    .yellow // 1.0, 1.0, 0.0 RGB

//     CURRENT FORMAT
//     UIColor.magenta // 1.0, 0.0, 1.0 RGB
//    .orange // 1.0, 0.5, 0.0 RGB
//    .purple // 0.5, 0.0, 0.5 RGB
//    .brown // 0.6, 0.4, 0.2 RGB
//    .white  0.0 white, 0.0 alpha
//    .yellow // 1.0, 1.0, 0.0 RGB
//    .black // 0.0 white

//darkGray: UIColor { get } // 0.333 white
//lightGray: UIColor { get } // 0.667 white
//gray: UIColor { get } // 0.5 white
//cyan: UIColor { get } // 0.0, 1.0, 1.0 RGB
//magenta: UIColor { get } // 1.0, 0.0, 1.0 RGB
//clear: UIColor { get } // 0.0 white, 0.0 alpha

//
//
////


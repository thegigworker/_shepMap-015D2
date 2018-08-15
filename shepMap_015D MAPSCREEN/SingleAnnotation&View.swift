//
//  SingleAnnotationView.swift
//  Created by Shepard Tamler on 11/20/17.
//

import Foundation
import MapKit
import UIKit
import Contacts
// This adds the Contacts framework, which contains dictionary key constants such as CNPostalAddressStreetKey,
// for when you need to set the address, city or state fields of a location.

var myGigSource : GigSource?

enum GigSource: String {
    case GigWalk
    case EasyShift
    case FieldAgent
    case Mobee
    case TaskRabbit
    case Safari
}

//To create your own annotations, you create a class that conforms to the MKAnnotation protocol, add the annotation to the map,
//and inform the map how the annotation should be displayed.
class ShepSingleAnnotation: NSObject, MKAnnotation {
    init(myMapItem: MKMapItem, currentLinkedRoute: MKRoute, shepDollarValue: Double, myGigSource: GigSource) {
        self.mapItem_Name = myMapItem.name ?? "No Title"
        //self.locationName = myMapItem.name! //searchResult.description
        self.shepDollarValue = shepDollarValue
        self.myMapItem = myMapItem
        self.currentLinkedRoute = currentLinkedRoute
        //self.currentLinkedRoute = currentLinkedRoute
        self.shepStringTitle = shepCurrencyFromDouble(shepNumber: self.shepDollarValue)
        //        self.shepsVariable = Double(arc4random_uniform(25) + 1)
        //        self.shepStringData = shepCurrencyFromDouble(shepNumber: self.shepsVariable)
        let latitude = myMapItem.placemark.coordinate.latitude
        let longitude = myMapItem.placemark.coordinate.longitude
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.myGigSource = myGigSource
        super.init()
    }
    
    //MARK: - My Properties
    let myDataModel = shepDataModel()
    let mapItem_Name: String?
    let shepDollarValue: Double
    let shepStringTitle: String
    var myMapItem: MKMapItem
    var currentLinkedRoute: MKRoute
    var crowFliesDistance: Double = 0.0
    var myGigSource : GigSource
    
    //   The MKAnnotation protocol requires the coordinate property. If you want your annotation view to display a title and subtitle when the user taps a pin,
    //   your class also needs properties named title and subtitle.
    let coordinate: CLLocationCoordinate2D
    
    var title: String? {
        let temp: String?
        temp = self.mapItem_Name
        return shepStringTitle + " -- " + temp!
    }
    
    var subtitle: String? {
        // takes the placemark.title string, which is really THE ADDRESS LINE, and cuts off the last 15 chars: ", United States"
        return String(myMapItem.placemark.title!.dropLast(_:15))
    }
    
     var StreetAddressLine: String? {
        return myMapItem.placemark.postalAddress?.street
    }
    
    var City: String? {
        return myMapItem.placemark.postalAddress?.city
    }
    
    var ZipCode: String? {
        return myMapItem.placemark.postalAddress?.postalCode
    }
    
    var formattedFullAddress : String {
        let streetAddressLine = self.StreetAddressLine!
        let state = myMapItem.placemark.postalAddress?.state
        let CityStateZipLine = self.City! + ", " + state! + ", " + self.ZipCode!
        return streetAddressLine + "\n" + CityStateZipLine
    }
    
    var routeDrivingDistance: Double {
        let drivingDistance = meters2miles(meters: currentLinkedRoute.distance)
        return drivingDistance // drivingDistance in miles
    }
    
    var routeProfit: Double {
        let drivingDistance = meters2miles(meters: currentLinkedRoute.distance)
        let routeExpense = drivingDistance * Double(myDataModel.centsPerMileExpense)/100
        let myGoldRouteScore = shepDollarValue - routeExpense
        return myGoldRouteScore
    }
    
    var drivingTime: Double {
        let drivingTime = currentLinkedRoute.expectedTravelTime / 60
        return drivingTime // drivingDistance in miles
    }
    
    //MARK: - My methods
    
    // Annotation right callout accessory opens this mapItem in Maps app
    // Here you create an MKMapItem from an MKPlacemark. The Maps app is able to read this MKMapItem, and display the correct thing.
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        //var placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
    func switchGigIcon() -> String { // leftCalloutAccessory image
        switch myGigSource {
        case .EasyShift :
            return "EasyShift icon"
        case .GigWalk :
            return "GigWalk icon"
        case .FieldAgent :
            return "Field Agent icon"
        case .Mobee :
            return "Mobee icon"
        case .TaskRabbit :
            return "Task Rabbit icon"
        case .Safari :
            return "Safari icon"
        }
    }
    
    func switchPinColor() -> UIColor {
        switch myGigSource {
        case .EasyShift :
            return .green
        case .GigWalk :
            return .lightGray
        case .FieldAgent :
            return .orange
        case .Mobee :
            return .brown
        case .TaskRabbit :
            return .magenta
        case .Safari :
            return .blue
        }
    }
    
    func switchGlyph() -> String? { // marker glyph
        switch shepDollarValue {
        case 0...49:
            return "nothing"
        case 80...100:
            return "Flag"
        default:
            return "HMI"
        }
    }
    
    func switchImage() -> String? { // right CalloutAccessory image
        switch shepDollarValue {
        case 0...9:
            return "zzz..."
        case 10...50:
            return "coins"
        case 51...79:
            return "dollars"
        case 80...100:
            return "monopoly man"
        default:
            return "superman"
        }
    }
}


//I THINK YOU WANT TO SET AN IMAGE FOR BUTTON SO TRY THIS WAY:
//
//let playButton  = UIButton(type: .Custom)
//if let image = UIImage(named: "play.png") {
//    playButton.setImage(image, forState: .Normal)
//}
//In Short:
//playButton.setImage(UIImage(named: "play.png"), forState: UIControlState.Normal)
//
//For Swift 3:
//let playButton  = UIButton(type: .custom)
//playButton.setImage(UIImage(named: "play.png"), for: .normal)


// MARK: -
class SingleAnnotationView: MKMarkerAnnotationView {
    
    let myDataModel = shepDataModel()
    override var annotation: MKAnnotation? {
        willSet {
            // These lines do the same thing as your myMapView(_:viewFor:), configuring the callout.
            guard let myAnnotationData = newValue as? ShepSingleAnnotation else { return }
            canShowCallout = true
            //pinView!.animatesDrop = true
            calloutOffset = CGPoint(x: -4, y: 4)
            
        //            let rightButtonView = UIButton()
        //            let rightButtonImage = UIImage(named: myAnnotationData.switchImage()!)
        //            rightButtonView.setImage(rightButtonImage, for: .normal)
        //            //setImage(_ image: UIImage?, for state: UIControlState) // default is nil. should be same size if different for different states
        //            rightCalloutAccessoryView = rightButtonView
            
            //CODE BELOW DOESN'T ALLOW FOR ACCESSORYVIEW TO BE A BUTTON.  NEED TO HAVE CODE WITH IMAGE AND BUTTON
            let rightImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 51, height: 51))
            rightImageView.image = UIImage(named: myAnnotationData.switchImage()!)
            rightImageView.contentMode = .scaleAspectFit
            rightCalloutAccessoryView = rightImageView
            
            // CODE BELOW TURNS THE BUTTON ON BUT KILLS THE IMAGEVIEW
            rightCalloutAccessoryView = UIButton(type: .infoLight)
            
        //            let myButton = UIButton()
        //            myButton.imageView?.image = UIImage(named: myAnnotationData.switchImage()!)
        //            //myButton.setBackgroundImage(UIImage(named: myAnnotationData.switchImage()!), for: UIControlState.normal)
        //            rightCalloutAccessoryView = myButton
            
            //You can try to set the UIImageView size to the created MKPinAnnotationView
            // and then call aspect fit on it like this:
            // let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
            //
            let leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 51, height: 51))
            leftImageView.image = UIImage(named: myAnnotationData.switchGigIcon())
            leftImageView.contentMode = .scaleAspectFit
            leftCalloutAccessoryView = leftImageView
            
            // Below is a function which has some stuff re setting leftCalloutAccessoryView as UIButton
            //            func myMapView(_ myMapView: MKMapView, didSelect view: MKAnnotationView) {
            //                if let thumbnailImageButton = view.leftCalloutAccessoryView as? UIButton,
            //                    //let url = (view.annotation as? GPX.Waypoint)?.thumbnailURL,
            //                    //let imageData = try? Data(contentsOf: url), // blocks main queue
            //                    let image = UIImage(data: imageData) {
            //                    thumbnailImageButton.setImage(image, for: UIControlState())
            //                }
            //            }
            
            //markerTintColor = myAnnotationData.switchTintColor()
            markerTintColor = myAnnotationData.switchPinColor()
            //markerTintColor = myDataModel.currentPinColor
            if let imageName = myAnnotationData.switchGlyph() {
                glyphImage = UIImage(named: imageName)
            } else {
                glyphImage = nil
            }
        }
    }
}


/*
 If you were interested in CHANGING THE HEIGHT OF THE ANNOTATION CALLOUT here is the simple way. And I am just making the height to 200 units.
 
 func myMapView(myMapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
 if annotation is MKUserLocation {
 return nil
 }
 let reuseID = "pin"
 var pinView = myMapView.dequeueReusableAnnotationViewWithIdentifier(reuseID) as? MKPinAnnotationView
 if pinView == nil {
 pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
 pinView!.canShowCallout = true
 pinView!.animatesDrop = true
 pinView!.pinTintColor = UIColor.blackColor()
 }
 pinView!.detailCalloutAccessoryView = self.configureDetailView(pinView!)
 return pinView
 }
 
 func configureDetailView(annotationView: MKAnnotationView) -> UIView {
 let snapshotView = UIView()
 let views = ["snapshotView": snapshotView]
 snapshotView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[snapshotView(200)]", options: [], metrics: nil, views: views))
 //do your work
 return snapshotView
 }
 */


/*       FROM APPLE: DEFINING A CUSTOM ANNOTATION VIEW
 If a static image is insufficient for representing your annotation, you can subclass MKAnnotationView and draw content dynamically in one of the following two ways:
 Continue to use the image property of MKAnnotationView, but change the image at regular intervals.
 Override the annotation view’s drawRect: method and draw your content dynamically every time.
 As with any custom drawing you do in a view, always consider performance before choosing an approach. Although custom drawing gives you the most flexibility, using images can be faster, especially if most of your content is fixed.
 */

/*  CUSTOM FONT FOR MKAnnotationView CALLOUT
 You have to call setNeedsLayout() on didAddSubview() because otherwise when you deselect and reselect the annotation layoutSubviews() is not called and the callout has its old font.
 
 // elsewhere, in a category on UIView.
 // thanks to this answer: http://stackoverflow.com/a/25877372/607876
 
 typealias ViewBlock = (view : UIView) -> Bool
 
 extension UIView {
 func loopViewHierarchy(block : ViewBlock?) {
 
 if block?(view: self) ?? true {
 for subview in subviews {
 subview.loopViewHierarchy(block)
 }
 }
 }
 }
 
 // then, in your MKAnnotationView subclass
 
 class CustomFontAnnotationView : MKAnnotationView {
 
 override func didAddSubview(subview: UIView) {
 if selected {
 setNeedsLayout()
 }
 }
 
 override func layoutSubviews() {
 
 // MKAnnotationViews only have subviews if they've been selected.
 // short-circuit if there's nothing to loop over
 
 if !selected {
 return
 }
 
 loopViewHierarchy({(view : UIView) -> Bool in
 if let label = view as? UILabel {
 label.font = labelFont
 return false
 }
 return true
 })
 }
 }
 
 */


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


////UIColors
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


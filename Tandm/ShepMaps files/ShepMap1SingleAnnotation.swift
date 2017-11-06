
import UIKit
import MapKit

class ShepMap1SingleAnnotation: NSObject,MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0,0)
    var title:String?
    var subtitle: String?
    
    init(coordinate:CLLocationCoordinate2D,title:String,subtitle:String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}


// function floating around on it's own?
func shepCurrencyFromDouble(shepNumber : Double) -> String  {
    let buckaroos = shepNumber as NSNumber
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    // formatter.locale = NSLocale.currentLocale() // This is the default
    return formatter.string(from: buckaroos)!
}


// extension ViewController: MKMapViewDelegate {
    
    // 1
    //    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //        if let annotation = annotation as? ShepMap1SingleAnnotationData {
    //            let identifier = "artPin"
    //            var view: MKPinAnnotationView
    //            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
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
    //func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    //    if let thumbnailImageButton = view.leftCalloutAccessoryView as? UIButton,
    //        let url = (view.annotation as? GPX.ShepMap1SingleAnnotationData)?.thumbnailURL,
    //        let imageData = try? Data(contentsOf: url as URL), // blocks main queue
    //        let image = UIImage(data: imageData) {
    //        thumbnailImageButton.setImage(image, for: UIControlState())
    //    }
    //}
    
    
    //CODE FROM SHEP_MAPKIT x?
    //
    //func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //    let identifier = "MyPin"
    //
    //    if annotation is MKUserLocation {
    //        return nil
    //    }
    //
    //    // Reuse the annotation if possible
    //    var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
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
    //func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //    var view: MKAnnotationView! = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.AnnotationViewReuseIdentifier)
    //    //
    //    let reuseId = "temp" // Constants.AnnotationViewReuseIdentifier
    //
    //    var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
    //    if pinView == nil {
    //        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
    //        pinView!.canShowCallout = true
    //        pinView!.animatesDrop = true
    //        pinView!.pinTintColor = .purple
    //        // pinView!.pinTintColor = GPX.ShepMap1SingleAnnotationData.pinTintColor(GPX.ShepMap1SingleAnnotationData)()
    //    } else {
    //        pinView!.pinTintColor = .green
    //        pinView!.annotation = annotation
    //    }
    //
    //    //        if annotation is GPX.ShepMap1SingleAnnotationData {
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
    //    if let waypoint = annotation as? GPX.ShepMap1SingleAnnotationData {
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
    //func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    //    if let thumbnailImageButton = view.leftCalloutAccessoryView as? UIButton,
    //        let url = (view.annotation as? GPX.ShepMap1SingleAnnotationData)?.thumbnailURL,
    //        let imageData = try? Data(contentsOf: url as URL), // blocks main queue
    //        let image = UIImage(data: imageData) {
    //        thumbnailImageButton.setImage(image, for: UIControlState())
    //    }
    //}
    //
    //// calloutAccessoryControlTapped
    //func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    //    if control == view.leftCalloutAccessoryView {
    //        performSegue(withIdentifier: Constants.ShowImageSegue, sender: view)
    //    } else if control == view.rightCalloutAccessoryView  {
    //        mapView.deselectAnnotation(view.annotation, animated: true)
    //        performSegue(withIdentifier: Constants.EditUserWaypoint, sender: view)
    //    }
    //}
    //
    //// MARK: Navigation
    //
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    let destination = segue.destination.contentViewController
    //    let annotationView = sender as? MKAnnotationView
    //    let waypoint = annotationView?.annotation as? GPX.ShepMap1SingleAnnotationData
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
    // END OF CODE FROM TRAX
    
    
    //        if let currentPlacemarkCoordinate = currentPlacemark?.location?.coordinate {
    //            if currentPlacemarkCoordinate.latitude == annotation.coordinate.latitude &&
    //                currentPlacemarkCoordinate.longitude == annotation.coordinate.longitude {
    //
    //                let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
    //                leftIconView.image = UIImage(named: restaurant.image)!
    //                annotationView?.leftCalloutAccessoryView = leftIconView
    //
    //                // Pin color customization
    //                if #available(iOS 9.0, *) {
    //                    annotationView?.pinTintColor = UIColor.orange
    //                }
    //            } else {
    //                // Pin color customization
    //                if #available(iOS 9.0, *) {
    //                    annotationView?.pinTintColor = UIColor.red
    //                }
    //            }
    //        }
    
// }


//  chooses pinTinColor depending on shepsVariable
//
//func pinTintColor() -> UIColor  {
//    if self.shepsVariable <= 4 {
//        // return MKPinAnnotationView.redPinColor()
//        return UIColor.black // .withAlphaComponent(0.2)
//    } else if (self.shepsVariable > 3.0 && self.shepsVariable <= 15) {
//
//        return UIColor.magenta // .withAlphaComponent(0.2)
//        //return MKPinAnnotationView.purplePinColor()
//    } else {
//        //return MKPinAnnotationView.greenPinColor()
//        return UIColor.green // .withAlphaComponent(0.2)
//    }
//}
//

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

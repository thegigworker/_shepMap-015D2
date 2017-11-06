
/*
//
// In this case, our ViewController will be the delegate for the map view. To avoid clutter and
// improve readability, this is an extension of ViewController in a separate file.

// This is from ShepMap3 == Honolulu
// Shep version puts in custom money and text data and sorts colors by money.

import MapKit

extension ViewController: MKMapViewDelegate {
  
    // from ShepMap3
    // inside:  extension ViewController: MKMapViewDelegate {
    // which is extension for:  class ViewController: UIViewController {
    //
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      if let annotation = annotation as? ShepSingleAnnotationData {
        let identifier = "artPin"
        var view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
          as? MKPinAnnotationView { // 2
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
          // 3
          view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
          view.canShowCallout = true
          view.calloutOffset = CGPoint(x: -5, y: 5)
          view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            
          //view.annotationImage = UIImage(named: <#T##String#>)
          //view.leftCalloutAccessoryView = UILabel(.text("Hello"))as UIView
        }
        
        // annotation.
        view.pinTintColor = annotation.pinTintColor()
        return view
      }
      return nil
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    let location = view.annotation as! ShepSingleAnnotationData
    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
    location.mapItem().openInMaps(launchOptions: launchOptions)
  }
  
}
 
*/


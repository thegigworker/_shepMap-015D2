//
//  SingleAnnotationView.swift
//
//  Created by Shepard Tamler on 11/20/17.
//


import Foundation
import MapKit

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

class SingleAnnotationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            // These lines do the same thing as your myMapView(_:viewFor:), configuring the callout.
            guard let myAnnotationData = newValue as? ShepSingleAnnotation else { return }
            canShowCallout = true
            //pinView!.animatesDrop = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            //rightCalloutAccessoryView = UIButton(type: .infoDark) //???
      
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 54, height: 54))
            //You can try to set the UIImageView size to the created MKPinAnnotationView
            // and then call aspect fit on it like this:
           // let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
            imageView.image = UIImage(named: myAnnotationData.switchImage()!)
            imageView.contentMode = .scaleAspectFit
            leftCalloutAccessoryView = imageView
            
            // Below is a function which has some stuff re setting leftCalloutAccessoryView as UIButton
//            func myMapView(_ myMapView: MKMapView, didSelect view: MKAnnotationView) {
//                if let thumbnailImageButton = view.leftCalloutAccessoryView as? UIButton,
//                    //let url = (view.annotation as? GPX.Waypoint)?.thumbnailURL,
//                    //let imageData = try? Data(contentsOf: url), // blocks main queue
//                    let image = UIImage(data: imageData) {
//                    thumbnailImageButton.setImage(image, for: UIControlState())
//                }
//            }
            
            // Then you set the marker’s tint color, and also replace its pin icon (glyph) with the first letter of the annotation’s discipline.
           // markerTintColor = artwork.switchMarkerTintColor
            markerTintColor = myAnnotationData.switchTintColor()
            //
            // glyphText = String(artwork.discipline.first!)
            //
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



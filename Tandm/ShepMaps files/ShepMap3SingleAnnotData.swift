
//// This code is from ShepMap3 == Honolulu
//
//
//import UIKit
//import MapKit
//import Contacts  // for CNPostalAddressStreetKey
//
//class ShepSingleAnnotationData: NSObject, MKAnnotation {
//    let title: String?
//    let locationName: String
//    let discipline: String
//    let coordinate: CLLocationCoordinate2D
//    let shepsVariable: Double
//    let shepStringData: String
//
//    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D, shepsPassedVariable: Double, shepPassedString: String) {
//        self.title = title
//        self.locationName = locationName
//        self.discipline = discipline
//        self.coordinate = coordinate
//        self.shepsVariable = shepsPassedVariable
//        self.shepStringData = shepPassedString
//        super.init()
//    }
//
//    class func shep_fromJSON(_ json: [JSONValue]) -> ShepSingleAnnotationData? {
//        // 1
//        var title: String
//        //    if let titleOrNil = json[16].string {
//        //      title = titleOrNil
//        //    } else {
//        //      title = ""
//        //    }
//        //    let locationName = json[12].string // "this is a bunch of text")
//        //    let shepLocationName = "Shep was here: " + locationName!
//        ////    let shepTitle = title + "    this is a whole lot more text"
//        //
//        //    let discipline = json[15].string
//
//        //if let titleOrNil = "shepTitle" {
//        title = "shepTitle"
//        //
//        let locationName = "this is a bunch of text"
//        let shepLocationName = "Shep was here: " + locationName
//        //    let shepTitle = title + "    this is a whole lot more text"
//
//        let discipline = json[15].string
//
//        let shepsData = Double(arc4random_uniform(20) + 1)
//        let shepStringData: String
//        shepStringData = shepCurrencyFromDouble(shepNumber: shepsData)
//        let shepTitle = shepStringData + " -- " + title
//
//        // 2
//        let latitude = (json[18].string! as NSString).doubleValue
//        let longitude = (json[19].string! as NSString).doubleValue
//        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//
//        // 3
//        return ShepSingleAnnotationData(title: shepTitle, locationName: shepLocationName, discipline: discipline!, coordinate: coordinate, shepsPassedVariable: shepsData, shepPassedString: shepStringData)
//
//    }
//
//    var subtitle: String? {
//        return locationName
//    }
//
//
//    // MARK: - MapKit related methods
//
//    func pinTintColor() -> UIColor  {
//        if self.shepsVariable <= 4 {
//            // return MKPinAnnotationView.redPinColor()
//            return UIColor.black // .withAlphaComponent(0.2)
//        } else if (self.shepsVariable > 3.0 && self.shepsVariable <= 15) {
//
//            return UIColor.magenta // .withAlphaComponent(0.2)
//            //return MKPinAnnotationView.purplePinColor()
//        } else {
//            //return MKPinAnnotationView.greenPinColor()
//            return UIColor.green // .withAlphaComponent(0.2)
//        }
//    }
//
//    //UIColor functions -- DEPRECATED FORMAT
//    //    public class func darkGrayColor() -> UIColor // 0.333 white
//    //    public class func lightGrayColor() -> UIColor // 0.667 white
//    //    public class func whiteColor() -> UIColor // 1.0 white
//    //    public class func grayColor() -> UIColor // 0.5 white
//    //    public class func redColor() -> UIColor // 1.0, 0.0, 0.0 RGB
//    //    public class func greenColor() -> UIColor // 0.0, 1.0, 0.0 RGB
//    //    public class func blueColor() -> UIColor // 0.0, 0.0, 1.0 RGB
//    //    public class func cyanColor() -> UIColor // 0.0, 1.0, 1.0 RGB
//    //    .yellow // 1.0, 1.0, 0.0 RGB
//
//    //     CURRENT FORMAT
//    //     UIColor.magenta // 1.0, 0.0, 1.0 RGB
//    //    .orange // 1.0, 0.5, 0.0 RGB
//    //    .purple // 0.5, 0.0, 0.5 RGB
//    //    .brown // 0.6, 0.4, 0.2 RGB
//    //    .white  0.0 white, 0.0 alpha
//    //    .yellow // 1.0, 1.0, 0.0 RGB
//    //    .black // 0.0 white
//
//
//    // annotation callout opens this mapItem in Maps app
//    func mapItem() -> MKMapItem {
//        let addressDict = [CNPostalAddressStreetKey: subtitle!]
//        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
//
//        let mapItem = MKMapItem(placemark: placemark)
//        mapItem.name = title
//
//        return mapItem
//    }
//
//}
//
//


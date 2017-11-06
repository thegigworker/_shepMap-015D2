
////
////  Enhancements to GPX.shepSingleAnnotationData to support MKMapView
//
//
//import MapKit
//
//
//// EditableWaypoints are draggable
//// so their coordinate needs to be settable
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
//extension shepDataSource.shepSingleAnnotation   // : MKAnnotation
//{
//    var coordinate: CLLocationCoordinate2D {
//        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//    }
//
//    var title: String? { return name }
//    var subtitle: String? { return info }
//
//    var thumbnailURL: URL? {
//        return getImageURLofType("thumbnail")
//    }
//
//    var imageURL: URL? {
//        return getImageURLofType("large")
//    }
//
//    // look in the hyperlink information from the GPX file
//    // try to find a url with a given type
//
//    fileprivate func getImageURLofType(_ type: String?) -> URL? {
////        for link in links {
////            if link.type == type {
////                return link.url as URL?
////            }
////        }
//        return nil
//    }
//}
//
//// ----------------------------------------------------------
//
//class ShepSingleAnnotationData: NSObject, MKAnnotation {
//    let title: String?
//    let locationName: String
//    // let discipline: String
//    let coordinate: CLLocationCoordinate2D
//    let shepsVariable: Double
//    let shepStringData: String
//
//    var subtitle: String? {
//        return locationName
//    }
//
//    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D, shepsPassedVariable: Double, shepPassedString: String) {
//        self.title = title
//        self.locationName = locationName
//        //self.discipline = discipline
//        self.coordinate = coordinate
//        self.shepsVariable = shepsPassedVariable
//        self.shepStringData = shepPassedString
//        super.init()
//    }
//
//    class func shep_testMakeSingleAnnotation() -> ShepSingleAnnotationData? {
//        // 1
//        var title: String
//        title = "shepTitle"
//        //
//        let locationName = "this is a bunch of text"
//        let shepLocationName = "Shep was here: " + locationName
//        //    let shepTitle = title + "    this is a whole lot more text"
//
//        // let discipline = json[15].string
//
//        let shepsData = Double(arc4random_uniform(20) + 1)
//        let shepStringData: String
//        shepStringData = shepCurrencyFromDouble(shepNumber: shepsData)
//        let shepTitle = shepStringData + " -- " + title
//
//        // 2
//        let latitude = THOMPSON_GPS.latitude
//        let longitude = THOMPSON_GPS.longitude
//        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//
//        // 3
//        return ShepSingleAnnotationData(title: shepTitle, locationName: shepLocationName, coordinate: coordinate, shepsPassedVariable: shepsData, shepPassedString: shepStringData)
//    }
//}
//
//
//class MyAnnotation: NSObject, MKAnnotation {
//
//    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0,0)
//    var title:String?
//    var subtitle: String?
//
//    init(coordinate:CLLocationCoordinate2D,title:String,subtitle:String) {
//        self.coordinate = coordinate
//        self.title = title
//        self.subtitle = subtitle
//    }
//
//}
//

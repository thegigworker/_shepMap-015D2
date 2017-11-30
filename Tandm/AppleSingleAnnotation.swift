/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A concrete implementation of MKAnnotation representing one bike.
*/

import MapKit

class AppleSingleAnnotation: MKPointAnnotation {

    enum BikeType: Int {
        case unicycle
        case tricycle
    }
    
    var type: BikeType = .tricycle
    var shepvar = String ()
    
    class func makeAppleArrayofAnnts(fromDictionaries dictionaries: [[String: NSNumber]]) -> [AppleSingleAnnotation] {
        let AppleAnnotationsArray = dictionaries.map { item -> AppleSingleAnnotation in
            let bike = AppleSingleAnnotation()
            bike.coordinate = CLLocationCoordinate2DMake(item["lat"]!.doubleValue, item["long"]!.doubleValue)
            bike.type = BikeType(rawValue: item["type"]!.intValue)!
            bike.shepvar = "hello \(bike.coordinate)"
            return bike
        }
        return AppleAnnotationsArray
    }

}

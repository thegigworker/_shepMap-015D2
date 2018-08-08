//
//  ShepTempSingleItem.swift
//

//import Foundation
//import MapKit
//
//import Contacts
//import UIKit
//
////public enum shepProductRating {
////    case unrated
////    case average
////    case ok
////    case good
////    case brilliant
////}
//
//
//class xShepTempSingleItem {
//    
//    var title: String
//    var description: String
//    var image: UIImage
//   // var rating: shepProductRating
//    var jobType: String
//    var foodType: String
//    var distance: Double
//    var dollar: Double
//    let shepDollarValue: Double = 0.0
//    
//    init(titled: String, description: String, imageName: String, jobType: String, foodType: String, distance: Double, dollar: Double) {
//        self.title = titled
//        self.description = description
//        self.jobType = jobType
//        self.foodType = foodType
//        self.distance = distance
//        self.dollar = dollar
//       
//        if let img = UIImage(named: imageName) {
//            image = img
//        } else {
//            image = UIImage(named: "default")!
//        }
//        //rating = .unrated
//    }
//    
//
////    //----INITIALIZATION----
////    init(myMapItem: MKMapItem, currentLinkedRoute: MKRoute, shepDollarValue: Double) {
////        self.origTitle = myMapItem.name ?? "No Title"
////        //self.locationName = myMapItem.name! //searchResult.description
////        self.shepDollarValue = shepDollarValue
////        self.myMapItem = myMapItem
////        self.currentLinkedRoute = currentLinkedRoute
////        //self.currentLinkedRoute = currentLinkedRoute
////        self.shepStringData = shepCurrencyFromDouble(shepNumber: self.shepDollarValue)
////        //        self.shepsVariable = Double(arc4random_uniform(25) + 1)
////        //        self.shepStringData = shepCurrencyFromDouble(shepNumber: self.shepsVariable)
////        let latitude = myMapItem.placemark.coordinate.latitude
////        let longitude = myMapItem.placemark.coordinate.longitude
////        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
////        super.init()
////    }
////
//    
//    func switchTintColor() -> UIColor {
//        switch shepDollarValue {
//        case 0..<1:
//            return .black
//        case 1...10:
//            return .darkGray
//        case 11...30:
//            return .orange
//        case 31...49:
//            return .green
//        case 50...60:
//            return .white
//        default:
//            return .white
//        }
//    }
//    
//    func switchGlyph() -> String? { // marker glyph/Users/shepardtamler/Library/Mobile Documents/com~apple~CloudDocs/Developer/_shepMap 015D/shepMap_015 TableView/Model/ShepTempSingleItem.swift
//        switch shepDollarValue {
//        case 0...10:
//            return "tricycle"
//        case 11...30:
//            return "unicycle"
//        case 31...49:
//            return "monopoly man"
//        case 50...60:
//            return "Flag"
//        default:
//            return "HMI"
//        }
//    }
//    
//    func switchImage() -> String? { // leftCalloutAccessory image
//        switch shepDollarValue {
//        case 0...10:
//            return "zzz..."
//        case 11...30:
//            return "coins"
//        case 31...49:
//            return "dollars"
//        case 50...60:
//            return "monopoly man"
//        default:
//            return "superman"
//        }
//    }
//    
//}
//
//
//

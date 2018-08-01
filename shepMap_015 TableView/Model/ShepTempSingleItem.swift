//
//  ShepTempSingleItem.swift
//

import Foundation
import MapKit

import Contacts
import UIKit

public enum shepProductRating {
    case unrated
    case average
    case ok
    case good
    case brilliant
}


class ShepTempSingleItem {
    
    var title: String
    var description: String
    var image: UIImage
    var rating: shepProductRating
    var jobType: String
    var foodType: String
    var distance: Double
    var dollar: Double
    let shepDollarValue: Double = 0.0
    
    init(titled: String, description: String, imageName: String, jobType: String, foodType: String, distance: Double, dollar: Double) {
        self.title = titled
        self.description = description
        self.jobType = jobType
        self.foodType = foodType
        self.distance = distance
        self.dollar = dollar
       
        if let img = UIImage(named: imageName) {
            image = img
        } else {
            image = UIImage(named: "default")!
        }
        rating = .unrated
    }
    

//    //MARK:----Initialization----
//    init(myMapItem: MKMapItem, currentLinkedRoute: MKRoute, shepDollarValue: Double) {
//        self.origTitle = myMapItem.name ?? "No Title"
//        //self.locationName = myMapItem.name! //searchResult.description
//        self.shepDollarValue = shepDollarValue
//        self.myMapItem = myMapItem
//        self.currentLinkedRoute = currentLinkedRoute
//        //self.currentLinkedRoute = currentLinkedRoute
//        self.shepStringData = shepCurrencyFromDouble(shepNumber: self.shepDollarValue)
//        //        self.shepsVariable = Double(arc4random_uniform(25) + 1)
//        //        self.shepStringData = shepCurrencyFromDouble(shepNumber: self.shepsVariable)
//        let latitude = myMapItem.placemark.coordinate.latitude
//        let longitude = myMapItem.placemark.coordinate.longitude
//        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        super.init()
//    }
//
//    //// THIS STUFF IS CODE FROM ANOTHER DEMO RE INITIALIZING FOR A TABLEVIEWS
//    //    init?(name: String, photo: UIImage?, rating: Int) {
//    //        //Failable initializers always start with either init? or init!. These initializers return optional values or implicitly unwrapped optional values, respectively. Optionals can either contain a valid value or nil. You must check to see if the optional has a value, and then safely unwrap the value before you can use it. Implicitly unwrapped optionals are optionals, but the system implicitly unwraps them for you.
//    //        //In this case, your initializer returns an optional Meal? object.
//    //
//    //        /* EXPLORE FURTHER
//    //         As you will see in later lessons, failable initializers are harder to use because you need to unwrap the returned optional before using it. Some developers prefer to enforce an initializer’s contract using assert() or precondition() methods. These methods cause the app to terminate if the condition they are testing fails. This means that the calling code must validate the inputs before calling the initializer.
//    //         For more information on initializers, see Initialization. For information on adding inline sanity checks and preconditions to your code, see assert(_:_:file:line:) and precondition(_:_:file:line:).
//    //         */
//    //        // The name must not be empty
//    //        guard !name.isEmpty else {
//    //            return nil
//    //        }
//    //        // The rating must be between 0 and 5 inclusively
//    //        guard (rating >= 0) && (rating <= 5) else {
//    //            return nil
//    //        }
//    //// THIS STUFF IS CODE FROM ANOTHER DEMO RE INITIALIZING FOR A TABLEVIEWS
//
    
    func switchTintColor() -> UIColor {
        switch shepDollarValue {
        case 0..<1:
            return .black
        case 1...10:
            return .darkGray
        case 11...30:
            return .orange
        case 31...49:
            return .green
        case 50...60:
            return .white
        default:
            return .white
        }
    }
    
    func switchGlyph() -> String? { // marker glyph/Users/shepardtamler/Library/Mobile Documents/com~apple~CloudDocs/Developer/_shepMap 015D/shepMap_015 TableView/Model/ShepTempSingleItem.swift
        switch shepDollarValue {
        case 0...10:
            return "tricycle"
        case 11...30:
            return "unicycle"
        case 31...49:
            return "monopoly man"
        case 50...60:
            return "Flag"
        default:
            return "HMI"
        }
    }
    
    func switchImage() -> String? { // leftCalloutAccessory image
        switch shepDollarValue {
        case 0...10:
            return "zzz..."
        case 11...30:
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




//
//  ShepSingleXYZ.swift
//

import Foundation
import MapKit

import Contacts
// This adds the Contacts framework, which contains dictionary key constants such as CNPostalAddressStreetKey,
// for when you need to set the address, city or state fields of a location.

import UIKit

public enum shepProductRating {
    case unrated
    case average
    case ok
    case good
    case brilliant
}


class ShepSingleXYZ {
    
    var title: String
    var description: String
    var image: UIImage
    var rating: shepProductRating
    var jobType: String
    var foodType: String
    var distance: Double
    var dollar: Double
    
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
//
//    //MARK:----My Properties----
//    let myDataModel = shepDataModel()
//    let origTitle: String?
//    let coordinate: CLLocationCoordinate2D
    let shepDollarValue: Double = 0.0
//    let shepStringData: String
//    var myMapItem: MKMapItem
//    var currentLinkedRoute: MKRoute
//
//    //   The MKAnnotation protocol requires the coordinate property. If you want your annotation view to display a title and subtitle when the user taps a pin, your class also needs properties named title and subtitle.
//    var title: String? {
//        let temp: String?
//        temp = self.origTitle
//        return shepStringData + " -- " + temp!
//    }
//
//    var subtitle: String? {
//        // takes the placemark.title string, which is really the address line, and cuts off the last 15 chars: ", United States"
//        return String(myMapItem.placemark.title!.dropLast(_:15))
//    }
//
//    var crowFliesDistance: Double = 0.0
//
//    var routeDrivingDistance: Double {
//        let drivingDistance = meters2miles(meters: currentLinkedRoute.distance)
//        return drivingDistance // drivingDistance in miles
//    }
//
//    var goldRouteScore: Double {
//        let drivingDistance = meters2miles(meters: currentLinkedRoute.distance)
//        let routeExpense = drivingDistance * Double(myDataModel.centsPerMileExpense)/100
//        let mytheChosenRouteScore = shepDollarValue - routeExpense
//        return mytheChosenRouteScore
//    }
//
//    var drivingTime: Double {
//        let drivingTime = currentLinkedRoute.expectedTravelTime / 60
//        return drivingTime // drivingDistance in miles
//    }
//
//
//    /*          The if let statement takes an optional variable. If it is nil, the else block or nothing is executed. If it has a value, the value is assigned to a different variable as a non-optional type.
//
//     So, the following code would output the value of score1 or "No" if there is none:
//
//     if let score1Unwrapped = score1
//     { print(score1Unwrapped)
//     } else {print("No")}
//
//     A shorter version of the same would be:
//     print(score1 ?? "No")
//
//     In your case, where you don't actually use the value stored in the optional variable, you can also check if the value is nil:
//
//     if score1 != nil {
//     ...
//     }
//     */
//
//
//    //    let searchResultCoordinates = item.placemark.coordinate
//    //    let searchResultLocation = CLLocation(latitude: searchResultCoordinates.latitude, longitude: searchResultCoordinates.longitude)
//    //    let mapItemDistance = myUserLocation.distance(from: searchResultLocation) // result is in meters
//    //    //let distanceInMiles = meters2miles(meters: mapItemDistance)
//
//    //    let crowFliesDistance = sourceLocation.distance(from: sourceLocationLocation) // result is in meters
//    //    let distanceInMiles = meters2miles(meters: crowFliesDistance)
//    //    self.lblCrowFlies.text = "As crow flies: \(String(format: "%.02f", distanceInMiles)) miles"
//
//
//    // Annotation right callout accessory opens this mapItem in Maps app
//    // Here you create an MKMapItem from an MKPlacemark. The Maps app is able to read this MKMapItem, and display the right thing.
//    //MARK:----My functions----
//    func mapItem() -> MKMapItem {
//        let addressDict = [CNPostalAddressStreetKey: subtitle!]
//        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
//        //var placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
//        //placemark.title = "xyz"
//
//        let mapItem = MKMapItem(placemark: placemark)
//        mapItem.name = title
//        return mapItem
//    }
    
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
    
    func switchGlyph() -> String? { // marker glyph
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




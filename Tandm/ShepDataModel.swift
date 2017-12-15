////
////  ShepDataModel.swift
////  Tandm
////
////  Created by Shepard Tamler on 12/13/17.
////  Copyright © 2017 Apple. All rights reserved.
////
//


import Foundation
import MapKit

class shepDataModel: NSObject {
    
//    let mapViewController = ViewController()
//    //
//    // 搜索
//    func performLocalSearch2(_ searchString:String) {
//        //shepAnnotationsArray.removeAll()
//        let request = MKLocalSearchRequest()
//        request.naturalLanguageQuery = searchString
//        var validSearchResultsArray: [ShepSingleAnnotation] = []
//        // 搜索当前区域
//        // print ("in performLocalSearch searchRegion search distance: \(meters2miles(meters: self.currentSearchDistance))")
//        let searchRegion1 = MKCoordinateRegionMakeWithDistance(myUserLocation.coordinate, mapViewController.currentSearchDistance, mapViewController.currentSearchDistance)
//        request.region = searchRegion1
//        //request.region = myMapView.region
//        // a MKLocalSearch object initiates a search operation and will deliver the results back into an array of MKMapItems. This will contain the name, latitude and longitude of the current POI.
//        print ("before search.start shepAnnotationsArray count: \(mapViewController.shepAnnotationsArray.count)")
//        // 启动搜索,并且把返回结果保存到数组中
//        let search = MKLocalSearch(request: request)
//        search.start(completionHandler: {(response, error) in
//            //let myViewController = ViewController()
//            //var validSearchResultsArray: [ShepSingleAnnotation] = []
//            print ("inside completionHandler shepAnnotationsArray count: \(self.mapViewController.shepAnnotationsArray.count)")
//            // Local searches are performed asynchronously
//            //and a completion handler called when the search is complete.
//            if error != nil {
//                print("Error occured in search: \(error!.localizedDescription)")
//            } else if response!.mapItems.count == 0 {
//                print("No matches found")
//            } else {
//                print("\n \(response!.mapItems.count) matches found")
//                //The code in the completion handler checks the response to make sure that matches were found
//                //and then accesses the mapItems property of the response which contains an array of mapItem instances for the matching locations.
//                shepSearchResultLoop: for item in response!.mapItems {
//                    let searchResultCoordinates = item.placemark.coordinate
//                    let searchResultLocation = CLLocation(latitude: searchResultCoordinates.latitude, longitude: searchResultCoordinates.longitude)
//                    let mapItemDistance = myUserLocation.distance(from: searchResultLocation) // result is in meters
//                    //let distanceInMiles = meters2miles(meters: mapItemDistance)
//                    print ("Current search distance: \(meters2miles(meters: self.mapViewController.currentSearchDistance)) and this distance: \(meters2miles(meters: mapItemDistance))")
//
//                    if mapItemDistance > self.mapViewController.currentSearchDistance {  // if SearchResult is further away than currentSearchDistance
//                        print ("took one down, too far away")
//                        continue shepSearchResultLoop
//                    } else {
//                        let shepDollarValue = Double(arc4random_uniform(40) + 1)
//                        //let shepPassedString = shepCurrencyFromDouble(shepNumber: shepDollarValue)
//                        let validResult = ShepSingleAnnotation(myMapItem: item, myStoredRoute: MKRoute(), shepDollarValue: shepDollarValue)
//                        validSearchResultsArray.append(validResult)
//                    }
//                    print ("still inside shepSearchResultLoop?, shepAnnotationsArray count is \(self.mapViewController.shepAnnotationsArray.count)")
//                    print ("still inside shepSearchResultLoop? validSearchResultsArray count: \(validSearchResultsArray.count) \n")
//                }
//                self.mapViewController.shepAnnotationsArray.append(contentsOf: validSearchResultsArray)
//                print ("shepSearchResultLoop is done now???, shepAnnotationsArray count is \(self.mapViewController.shepAnnotationsArray.count)")
//                print ("shepSearchResultLoop is done now???, validSearchResultsArray count is \(validSearchResultsArray.count) \n")
//               // if validSearchResultsArray.count > 0 {
//                if validSearchResultsArray.count > 0 {
//                    // MARK: WHY DOES THIS FIND NIL ?? IT'S CHECKING IN THE PREVIOUS LINE THAT IT'S NOT NIL !!!
//                    //mapViewController.myMapView.addAnnotations(annotations: validSearchResultsArray)
//                    //mapViewController.myMapView.addAnnotations( mapViewController.shepAnnotationsArray)
//
//                    self.mapViewController.myMapView.addAnnotations(validSearchResultsArray) //Thread 1: Fatal error: Unexpectedly found nil while unwrapping an Optional value
//                    // is myMapView not correctly set??  myMapView = nil??
//                    self.mapViewController.myMapView.showAnnotations(self.mapViewController.shepAnnotationsArray, animated: true) //Thread 1: Fatal error: Unexpectedly found nil while unwrapping an Optional value
//                }
//            }
//        })
//        //print ("opening gambit, validSearchResultsArray count is \(validSearchResultsArray.count) \n")  // validSearchResultsArray doesn't work here
//        print ("OPENING GAMBIT, shepAnnotationsArray count is \(mapViewController.shepAnnotationsArray.count) \n")
//    }
//
//
//func getRouteData2 (source: ShepSingleAnnotation, destination: ShepSingleAnnotation) -> (thisismyRoute: MKRoute?, thisisCrowFliesDistanceInMiles: Double) {
//    let point1 = MKPointAnnotation()
//    let point2 = MKPointAnnotation()
//    point1.coordinate = CLLocationCoordinate2DMake(source.coordinate.latitude, source.coordinate.longitude)
//    point2.coordinate = CLLocationCoordinate2DMake(destination.coordinate.latitude, destination.coordinate.longitude)
//    let point1_placemark = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point1.coordinate.latitude, point1.coordinate.longitude), addressDictionary: nil)
//    let point2_placemark = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point2.coordinate.latitude, point2.coordinate.longitude), addressDictionary: nil)
//
//    let directionsRequest = MKDirectionsRequest()
//    directionsRequest.source = MKMapItem(placemark: point1_placemark)
//    directionsRequest.destination = MKMapItem(placemark: point2_placemark)
//    directionsRequest.transportType = mapViewController.currentTransportType
//    let directions = MKDirections(request: directionsRequest)
//    var crowFliesDistanceInMiles: Double = 0.0
//
//    directions.calculate(completionHandler: {
//        response, error in
//        // response has an array of MKRoutes
//        if error != nil {
//            print ("Directions Retreival Error: \(String(describing: error))")
//        } else {
//            //self.myMapView.removeOverlays(self.myMapView.overlays)
//            self.mapViewController.myRoute = response!.routes[0] as MKRoute
//            let sourceLocation = CLLocation(latitude: point1.coordinate.latitude, longitude: point1.coordinate.longitude)
//            let destinationLocation = CLLocation(latitude: point2.coordinate.latitude, longitude: point2.coordinate.longitude)
//            let crowFliesDistance = sourceLocation.distance(from: destinationLocation) // result is in meters
//            crowFliesDistanceInMiles = meters2miles(meters: crowFliesDistance)
//            //return (thisismyRoute: myRoute, thisisCrowFliesDistanceInMiles: crowFliesDistanceInMiles)
//        }
//        //return (thisismyRoute: mapViewController.myRoute, thisisCrowFliesDistanceInMiles: crowFliesDistanceInMiles)
//    })
//    return (thisismyRoute: mapViewController.myRoute, thisisCrowFliesDistanceInMiles: crowFliesDistanceInMiles)
//    }
    
}


/*  CREATING AN ARRAY BY ADDING TWO ARRAYS TOGETHER
 
 var threeDoubles = Array(repeating: 0.0, count: 3)
 // threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]
 You can create a new array by adding together two existing arrays with compatible types with the addition operator (+). The new array’s type is inferred from the type of the two arrays you add together:
 var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
 // anotherThreeDoubles is of type [Double], and equals [2.5, 2.5, 2.5]
 var sixDoubles = threeDoubles + anotherThreeDoubles
 // sixDoubles is inferred as [Double], and equals [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
 */


/*  YES, SWIFT HAS THE SET CLASS.
 
 Check if no members same
 Set1.isDisjointWith(Set2)    Returns true if the two Sequences have no members in common.
 
 Combine Sets
 Set1.union(Set2)    Returns a new Set containing the members of both set1 and set2.
 
 Combine Sets In Place
 Set1.unionInPlace(Set2)    Mutates set2 to add the members of set1 to it.
 
 Subtract One Set From Another
 set2.subtract(entreeSet)    Returns a new Set with the values of entreeSet removed from set2, if they were present.
 
 Subtract One Set From Another In Place
 set2.subtractInPlace(entreeSet)    Mutates the set2 Set to subtract an values that were specified in the entreeSet (like above).
 
 Create Set of Common Members
 moreFoods.intersect(entreeSet)    Returns a new Set with the values that were in common between moreFoods and entreeSet.
 
 Create Set of Common Members In Place
 moreFoods.intersectInPlace(entreeSet)    Mutates the moreFoods Set to perform the intersect method above.
 
 Create Set of Uncommon Members
 moreFoods.exclusiveOr(dessertsSet)    Returns a new Set containing the values that were in either moreFoods or dessertsSet, but NOT both.
 
 Create Set of Uncommon Members In Place
 moreFoods.exclusiveOrInPlace(dessertsSet)    Mutates the moreFoods Set with the result of the exclusiveOr method above.
 
 ///////////////////////////////////////////////////////
 //entreeSet   is {"Salad", "Sandwiches"}
 //sameFoodSet is {"Salad", "Chips", "Sandwiches"}
 //otherFoods  is {"Quiche", "Donuts"}
 
 foodSet.contains("Chips")               //returns true
 
 entreeSet.isSubsetOf(foodSet)           //returns true
 sameFoodSet.isStrictSubsetOf(foodSet)   //returns false
 
 foodSet.isSupersetOf(entreeSet)         //returns true
 foodSet.isStrictSupersetOf(sameFoodSet) //returns false
 foodSet.isStrictSupersetOf(entreeSet)   //returns true
 
 foodSet.isDisjointWith(entreeSet)       //returns false
 foodSet.isDisjointWith(otherFoods)      //returns true
 ///////////////////////////////////////////////////////
 
 let array1 = ["a", "b", "c"]
 let array2 = ["a", "b", "d"]
 
 let set1:Set<String> = Set(array1)
 let set2:Set<String> = Set(array2)
 
 Swift 3.0+ can do operations on sets as:
 
 firstSet.union(secondSet)// Union of two sets
 firstSet.intersection(secondSet)// Intersection of two sets
 firstSet.symmetricDifference(secondSet)// exclusiveOr
 
 Swift 2.0 can calculate on array arguments:
 
 set1.union(array2)       // {"a", "b", "c", "d"}
 set1.intersect(array2)   // {"a", "b"}
 set1.subtract(array2)    // {"c"}
 set1.exclusiveOr(array2) // {"c", "d"}
 
 Swift 1.2+ can calculate on sets:
 
 set1.union(set2)        // {"a", "b", "c", "d"}
 set1.intersect(set2)    // {"a", "b"}
 set1.subtract(set2)     // {"c"}
 set1.exclusiveOr(set2)  // {"c", "d"}
 
 If you're using custom structs, you need to implement Hashable.
 */

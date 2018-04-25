/*
 
import Foundation
import UIKit
import MapKit

class shepDataSource: NSObject, XMLParserDelegate
{
    // MARK: - Public API
    
    var shepArrayOfAnnotations = [shepSingleAnnotation]()
    //    var tracks = [Track]()
    //    var routes = [Track]()
    
    typealias GPXCompletionHandler = (shepDataSource?) -> Void
    
    class func parse(_ url: URL, completionHandler: @escaping GPXCompletionHandler) {
        shepDataSource(url: url, completionHandler: completionHandler).parse()
    }
    
    
    // MARK: - Public Classes
    //
    class shepSingleAnnotation: Entry, MKAnnotation
    {
        var latitude: Double
        var longitude: Double
        let shepsVariable: Double
        let shepStringData: String
        var shepName : String? = "I am not empty"
        var shepDesc : String? = "I am not empty"
        
        init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
            self.shepsVariable = Double(arc4random_uniform(20) + 1)
            self.shepStringData = shepCurrencyFromDouble(shepNumber: shepsVariable)
            super.init()
        }
 
        lazy var date: Date? = self.attributes["time"]?.asGpxDate
        
        override var description: String {
            //            print ("In shepShepSingleAnnotation override description: \(self.description) \n")
            return ["lat=\(latitude)", "lon=\(longitude)", super.description].joined(separator: " ")
        }
    }
    
    
    class Entry: NSObject
    {
        // var links = [Link]()
        var attributes = [String:String]()
        
        var name: String? {
            set { attributes["name"] = newValue }
            get {
                let shepNAMEInEntry = attributes["name"]
                // let shepDESCInEntry = attributes["desc"]
                print ("In Entry info var, attributes[name] is: \(shepNAMEInEntry!)")
                if let shepDESCInEntry = attributes["desc"] {
                    print ("In Entry info var, attributes[desc] is: \(shepDESCInEntry) \n")
                } else {
                    print ("In Entry info var, attributes[desc] is NIL \n")
                }
                return attributes["name"] }
        }
        
        var shepInEntry: String? = "What am I doing here?"
        
        override var description: String {
            var descriptions = [String]()
            if attributes.count > 0 { descriptions.append("attributes=\(attributes)")
                //                let shepDesc = descriptions
                //                print ("In Entry override, descriptions are: \(shepDesc)")
                //                print ("In Entry override, attributes: \(attributes) \n")
            }
//            if links.count > 0 { descriptions.append("links=\(links)") }
            return descriptions.joined(separator: " ")
        }
    }
 
    //   SHEP I'll get back to this
    //
    //    class Track: Entry
    //    {
    //        var fixes = [shepShepSingleAnnotation]()
    //
    //        override var description: String {
    //            let waypointDescription = "fixes=[\n" + fixes.map { $0.description }.joined(separator: "\n") + "\n]"
    //            return [super.description, waypointDescription].joined(separator: " ")
    //        }
    //    }
    
    // MARK: - CustomStringConvertible
    
    override var description: String {
        var descriptions = [String]()
        if shepArrayOfAnnotations.count > 0 { descriptions.append("waypoints = \(shepArrayOfAnnotations)") }
        //        if tracks.count > 0 { descriptions.append("tracks = \(tracks)") }
        //        if routes.count > 0 { descriptions.append("routes = \(routes)") }
        return descriptions.joined(separator: "\n")
    }

 
 */

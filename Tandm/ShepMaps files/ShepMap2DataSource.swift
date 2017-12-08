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
        
        var info: String? {
            set { attributes["desc"] = newValue
                attributes["desc"] = (self.shepStringData + "  " + (attributes["desc"])!)
            }
            get {
                print ("In shepShepSingleAnnotation info var, shepString is: \(shepStringData)")
                if shepName != "" {
                    shepName  = attributes["name"]!
                    attributes["name"] = (self.shepStringData + " -- " + attributes["name"]!)
                    shepName = ""
                }
                print ("In shepShepSingleAnnotation info var, attributes[name] is: \(String(describing: attributes["name"]!))")
                if shepDesc != "" {
                    if attributes["desc"] == nil {
                        print ("In shepShepSingleAnnotation info var, attributes[desc] is NIL \n")
                    } else {
                        shepDesc  = attributes["desc"]!
                        attributes["desc"] = ("Shep says: " + attributes["desc"]!)
                        print ("In shepShepSingleAnnotation info var, attributes[desc] is: \(String(describing: attributes["desc"]!)) \n")
                    }
                    shepDesc = ""
                }
                // let shepDesc = attributes["desc"]
                // print ("In shepShepSingleAnnotation info var, attributes[desc] is: \(String(describing: attributes["desc"]!)) \n")
                
                return attributes["desc"] }
        }
        lazy var date: Date? = self.attributes["time"]?.asGpxDate
        
        func pinTintColor() -> UIColor  {
            if self.shepsVariable <= 3 {
                return MKPinAnnotationView.redPinColor()
            } else if (self.shepsVariable > 3.0 && self.shepsVariable <= 10) {
                return MKPinAnnotationView.purplePinColor()
            } else {
                return MKPinAnnotationView.greenPinColor()
            }
        }
        
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
    
    
    
//    class Link: CustomStringConvertible
//    {
//        var href: String
//        var linkattributes = [String:String]()
//        
//        init(href: String) { self.href = href }
//        
//        var url: URL? { return URL(string: href) }
//        var text: String? { return linkattributes["text"] }
//        var type: String? { return linkattributes["type"] }
//        
//        var description: String {
//            var descriptions = [String]()
//            descriptions.append("href=\(href)")
//            if linkattributes.count > 0 { descriptions.append("linkattributes=\(linkattributes)") }
//            return "[" + descriptions.joined(separator: " ") + "]"
//        }
//    }
    
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
    
    
    
    
    
    // GPX PARSER STUFF
    
    // MARK: - Private Implementation
    
    fileprivate let url: URL
    fileprivate let completionHandler: GPXCompletionHandler
    
    fileprivate init(url: URL, completionHandler: @escaping GPXCompletionHandler) {
        self.url = url
        self.completionHandler = completionHandler
    }
    
    fileprivate func complete(success: Bool) {
        DispatchQueue.main.async {
            self.completionHandler(success ? self : nil)
        }
    }
    
    fileprivate var waypoint: shepSingleAnnotation?
    
    fileprivate func fail() { complete(success: false) }
    fileprivate func succeed() { complete(success: true) }
    
    fileprivate func parse() {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
            if let data = try? Data(contentsOf: self.url) {
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.shouldProcessNamespaces = false
                parser.shouldReportNamespacePrefixes = false
                parser.shouldResolveExternalEntities = false
                parser.parse()
            } else {
                self.fail()
            }
        }
    }
    
    //func parserDidEndDocument(_ parser: XMLParser) { succeed() }
    //func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) { fail() }
    //func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) { fail() }
    
    fileprivate var input = ""
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        input += string
    }
    
    // fileprivate var waypoint: shepSingleAnnotation?
    
    // fileprivate var track: Track?
    //fileprivate var link: Link?
    
    //    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
    //        switch elementName {
    //        case "trkseg":
    //            break
    //        // if track == nil { fallthrough }
    //        case "trk":
    //            break
    //            //                tracks.append(Track())
    //        //                track = tracks.last
    //        case "rte":
    //            break
    //            //                routes.append(Track())
    //        //                track = routes.last
    //        case "rtept", "trkpt", "wpt":
    //            let latitude = Double(attributeDict["lat"] ?? "0") ?? 0.0
    //            let longitude = Double(attributeDict["lon"] ?? "0") ?? 0.0
    //            waypoint = shepShepSingleAnnotation(latitude: latitude, longitude: longitude)
    //        case "link":
    //            if let href = attributeDict["href"] {
    //                link = Link(href: href)
    //            }
    //        default: break
    //        }
    //    }
    //
    //    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    //        switch elementName {
    //        case "wpt":
    //            if waypoint != nil {
    //                _ = waypoint?.info  // seems to trigger waypoint var info
    //
    //                //                    print ("In parser wpt, INFO is: \(String(describing: shepWaypointInfo!)) \n")
    //                //                    let shepWaypointDesc = waypoint?.description
    //                //                    print ("In parser wpt, DESC is: \(String(describing: shepWaypointDesc!)) \n")
    //
    //                MapViewController.append(waypoint!); waypoint = nil }
    //        case "trkpt", "rtept":
    //            break
    //        //                if waypoint != nil { track?.fixes.append(waypoint!); waypoint = nil }
    //        case "trk", "trkseg", "rte":
    //            break
    //        // track = nil
    //        case "link":
    //            if link != nil {
    //                if waypoint != nil {
    //                    waypoint!.links.append(link!)
    //                }
    //                //                    else if track != nil {
    //                //                        track!.links.append(link!)
    //                //                    }
    //            }
    //            link = nil
    //        default:
    //            if link != nil {
    //                link!.linkattributes[elementName] = input.trimmed
    //            } else if waypoint != nil {
    //                waypoint!.attributes[elementName] = input.trimmed
    //            }
    //            //                    else if track != nil {
    //            //                    track!.attributes[elementName] = input.trimmed
    //            //                }
    //            input = ""
    //        }
}





// MARK: - Extensions

private extension String {
    var trimmed: String {
        return (self as NSString).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

extension String {
    var asGpxDate: Date? {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z"
            return dateFormatter.date(from: self)
        }
    }
}
 
 
/*
 
 
 */*/

//
//  sectionOfProducts_class.swift
//
// testing...

import Foundation
import MapKit

class fakeAnnotationsSingleArray_class {
    
    class func buildSingleTableArray() -> [fakeShepSingleAnnotation] {
        var tempSingleArray = [fakeShepSingleAnnotation]()
        
        var mySingleAnnotation = fakeShepSingleAnnotation(myMapItem: MKMapItem(), currentLinkedRoute: MKRoute(), shepDollarValue: 05.0, myGigSource: GigSource.EasyShift, title: "Temp Name 1", subtitle: "this is a 1 subtitle", StreetAddressLine: "123 Main St.", City: "Thompson", routeDrivingDistance: 3.0, ZipCode: "06277")
        tempSingleArray.append(mySingleAnnotation)
        mySingleAnnotation = fakeShepSingleAnnotation(myMapItem: MKMapItem(), currentLinkedRoute: MKRoute(), shepDollarValue: 27.0, myGigSource: GigSource.EasyShift, title: "Temp Name 2", subtitle: "this is a 2 subtitle", StreetAddressLine: "123 Main St.", City: "Thompson", routeDrivingDistance: 22.0, ZipCode: "06277")
        tempSingleArray.append(mySingleAnnotation)
       mySingleAnnotation = fakeShepSingleAnnotation(myMapItem: MKMapItem(), currentLinkedRoute: MKRoute(), shepDollarValue: 24.0, myGigSource: GigSource.GigWalk, title: "Temp Name 3", subtitle: "this is a 3 subtitle", StreetAddressLine: "123 Main St.", City: "Webster", routeDrivingDistance: 13.0, ZipCode: "06278")
        tempSingleArray.append(mySingleAnnotation)
        mySingleAnnotation = fakeShepSingleAnnotation(myMapItem: MKMapItem(), currentLinkedRoute: MKRoute(), shepDollarValue: 25.0, myGigSource: GigSource.FieldAgent, title: "Temp Name 4", subtitle: "this is a 4 subtitle", StreetAddressLine: "123 Main St.", City: "Webster", routeDrivingDistance: 24.0, ZipCode: "06278")
        tempSingleArray.append(mySingleAnnotation)
        mySingleAnnotation = fakeShepSingleAnnotation(myMapItem: MKMapItem(), currentLinkedRoute: MKRoute(), shepDollarValue: 3.0, myGigSource: GigSource.GigWalk, title: "Temp Name 5", subtitle: "this is a 5 subtitle", StreetAddressLine: "123 Main St.", City: "Webster", routeDrivingDistance: 25.0, ZipCode: "06278")
        tempSingleArray.append(mySingleAnnotation)
        mySingleAnnotation = fakeShepSingleAnnotation(myMapItem: MKMapItem(), currentLinkedRoute: MKRoute(), shepDollarValue: 22.0, myGigSource: GigSource.FieldAgent, title: "Temp Name 6", subtitle: "this is a 6 subtitle", StreetAddressLine: "123 Main St.", City: "Putnam", routeDrivingDistance: 25.0, ZipCode: "06279")
        tempSingleArray.append(mySingleAnnotation)
        mySingleAnnotation = fakeShepSingleAnnotation(myMapItem: MKMapItem(), currentLinkedRoute: MKRoute(), shepDollarValue: 100.0, myGigSource: GigSource.FieldAgent, title: "Temp Name 22", subtitle: "this is a 7 subtitle", StreetAddressLine: "123 Main St.", City: "Putnam", routeDrivingDistance: 36.0, ZipCode: "06280")
        tempSingleArray.append(mySingleAnnotation)
        mySingleAnnotation = fakeShepSingleAnnotation(myMapItem: MKMapItem(), currentLinkedRoute: MKRoute(), shepDollarValue: 20.0, myGigSource: GigSource.Safari, title: "Temp Name 21", subtitle: "this is a 8 subtitle", StreetAddressLine: "123 Main St.", City: "Pomfret", routeDrivingDistance: 09.0, ZipCode: "06281")
        tempSingleArray.append(mySingleAnnotation)
        mySingleAnnotation = fakeShepSingleAnnotation(myMapItem: MKMapItem(), currentLinkedRoute: MKRoute(), shepDollarValue: 21.0, myGigSource: GigSource.TaskRabbit, title: "Temp Name 50", subtitle: "this is a 8 subtitle", StreetAddressLine: "123 Main St.", City: "Killingly", routeDrivingDistance: 06.0, ZipCode: "06276")
        tempSingleArray.append(mySingleAnnotation)
        mySingleAnnotation = fakeShepSingleAnnotation(myMapItem: MKMapItem(), currentLinkedRoute: MKRoute(), shepDollarValue: 31.0, myGigSource: GigSource.TaskRabbit, title: "Temp Name 51", subtitle: "this is a 8 subtitle", StreetAddressLine: "123 Main St.", City: "Killingly", routeDrivingDistance: 16.0, ZipCode: "06276")
        tempSingleArray.append(mySingleAnnotation)
        return tempSingleArray
        
    }
}
//        tempSingleArray.append(fakeShepSingleAnnotation(titled: "Tamler Watch", description: "Featuring revolutionary new Tamler technologies.", imageName: "alfred_e 1024", jobType: "Park", distance: 12.3, dollar: 12.4))
//        tempSingleArray.append(fakeShepSingleAnnotation(titled: "iPad", description: "iPad Air 2 is the thinnest and most powerful iPad ever. With iPad, we’ve always had a somewhat paradoxical goal: to create a device that’s immensely powerful, yet so thin and light you almost forget it’s there.", imageName: "ipad-air2", jobType: "Target", foodType: "rasberry", distance: 32.4, dollar: 23.34))
//        tempSingleArray.append(fakeShepSingleAnnotation(titled: "iPhone", description: "The biggest advancements in iPhone history, featuring two models with stunning 4.7-inch and 5.5-inch Retina HD displays.", imageName: "iphone6", jobType: "McDonalds", foodType: "ice cream", distance: 06.4, dollar: 19))
//        tempSingleArray.append(fakeShepSingleAnnotation(titled: "Tamler Mac", description: "Featuring revolutionary new Tamler Macintosh technologies.", imageName: "alfred_e 1024", jobType: "Park", foodType: "pizza", distance: 67.0, dollar: 43.9))
//        tempSingleArray.append(fakeShepSingleAnnotation(titled: "MacBook", description: "The thinnest and lightest Mac ever with every component meticulously redesigned to create a Mac that is just two pounds and 13.1 mm thin. ", imageName: "ios8", jobType: "Gas station", foodType: "pretzel", distance: 33.9, dollar: 21.09))
//        tempSingleArray.append(fakeShepSingleAnnotation(titled: "MacBook Pro with Retina Display", description: "A stunning high-resolution display, an amazing thin and light design, and the latest technology to power through the most demanding projects.", imageName: "macbook-pro-13", jobType: "Pub", foodType: "pretzel", distance: 11.0, dollar: 96))
//        tempSingleArray.append(fakeShepSingleAnnotation(titled: "MacBook Air", description: "All day battery life, fourth generation Intel Core processors with faster graphics, 802.11ac Wi-Fi and flash storage that is up to 45 percent faster than the previous generation.", imageName: "ios8", jobType: "Park", foodType: "rasberry", distance: 94, dollar: 93))
//        tempSingleArray.append(fakeShepSingleAnnotation(titled: "iMac", description: "The 27-inch iMac with Retina 5K display features a breathtaking 14.7 million pixel display so text appears sharper than ever, videos are unbelievably lifelike.", imageName: "imac-5k", jobType: "Pub", foodType: "pretzel", distance: 92, dollar: 91))
//        tempSingleArray.append(fakeShepSingleAnnotation(titled: "Mac Pro", description: "Designed around a revolutionary unified thermal core, the Mac Pro introduces a completely new pro desktop architecture and design that is optimized for performance inside and out.", imageName: "mac-pro", jobType: "Park", foodType: "ice cream", distance: 87, dollar: 86))
//        tempSingleArray.append(fakeShepSingleAnnotation(titled: "Mac Mini", description: "With its sleek aluminum design, a removable bottom panel for easy access to memory, and a space-saving built-in power supply, Mac mini is pretty incredible.", imageName: "mac-mini", jobType: "Target", foodType: "pizza", distance: 85, dollar: 84))
//        tempSingleArray.append(fakeShepSingleAnnotation(titled: "Tamler software", description: "Built on a rock-solid Tamler Tamler Shep Shep.", imageName: "brass coin", jobType: "McDonalds", foodType: "pizza", distance: 89.1, dollar: 88.1))
//        tempSingleArray.append(fakeShepSingleAnnotation(titled: "iLife", description: "Do more with movies and music than you ever thought possible.", imageName: "ilife", jobType: "Gas station", foodType: "pretzel", distance: 88.2, dollar: 88.3))
//        tempSingleArray.append(fakeShepSingleAnnotation(titled: "Tamler Plain Vanilla", description: " Tamler Plain Vanilla icecream is the easiest way to create great-looking documents, spreadsheets, and presentations. ", imageName: "alfred_e 1024", jobType: "McDonalds", foodType: "ice cream", distance: 88.3, dollar: 12.82 ))
//        tempSingleArray.append(fakeShepSingleAnnotation(titled: "Tamler ipod", description: "Built on a rock-solid real iCoy.  This is filler to go to at least two lines", imageName: "brass coin", jobType: "Park", foodType: "rasberry", distance: 14, dollar: 14.1))
//        tempSingleArray.append(fakeShepSingleAnnotation(titled: "iPod shuffle", description: "Crafted from a single piece of aluminium and polished to a beautiful shine, iPod shuffle feels solid, sleek and durable.", imageName: "ipod-shuffle", jobType: "Gas station", foodType: "pizza", distance: 14.2, dollar: 14.35))
//        tempSingleArray.append(fakeShepSingleAnnotation(titled: "iPod touch", description: "Featuring a brilliant 4-inch Retina display; a 5-megapixel iSight camera with 1080p HD video recording.", imageName: "ipod-touch", jobType: "Target", foodType: "ice cream", distance: 14.4, dollar: 14.52))
//         tempSingleArray.append(fakeShepSingleAnnotation(titled: "Tamler Pencil", description: "Featuring revolutionary new Tamler technologies.", imageName: "alfred_e 1024", jobType: "McDonalds", foodType: "pizza", distance: 22.3, dollar: 22.45))















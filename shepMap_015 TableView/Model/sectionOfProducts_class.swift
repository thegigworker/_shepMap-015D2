////
////  sectionOfProducts_class.swift
////  TableViewDemo
////
////  Created by Duc Tran on 3/22/15.
////  Copyright (c) 2015 Duc Tran. All rights reserved.
////
//
//import Foundation
//
//class sectionOfProducts_class {
//
//    var sectionName: String            // name of the product line
//    var oneSectionProductsArray: [ShepSingleXYZ]     // all products in the line
//    
//    init(named: String, includeProducts: [ShepSingleXYZ]) {
//        sectionName = named
//        oneSectionProductsArray = includeProducts
//    }
//
//    class func getAllTheSections() -> [sectionOfProducts_class] {
//        return [self.iDevices(), self.iPod(), self.mac(), self.software()]
//    }
//
//
//    // Private methods
//
//    private class func iDevices() -> sectionOfProducts_class {
//        var tempProductsArray = [ShepSingleXYZ]()
//
//        tempProductsArray.append(ShepSingleXYZ(titled: "Tamler Watch", description: "Featuring revolutionary new Tamler technologies.", imageName: "alfred_e 1024"))
//        tempProductsArray.append(ShepSingleXYZ(titled: "iPad", description: "iPad Air 2 is the thinnest and most powerful iPad ever. With iPad, we’ve always had a somewhat paradoxical goal: to create a device that’s immensely powerful, yet so thin and light you almost forget it’s there.", imageName: "ipad-air2"))
//        tempProductsArray.append(ShepSingleXYZ(titled: "iPhone", description: "The biggest advancements in iPhone history, featuring two models with stunning 4.7-inch and 5.5-inch Retina HD displays.", imageName: "iphone6"))
//
//        return sectionOfProducts_class(named: "iDevices", includeProducts: tempProductsArray)
//    }
//
//
//    private class func mac() -> sectionOfProducts_class {
//        var tempProductsArray = [ShepSingleXYZ]()
//
//        tempProductsArray.append(ShepSingleXYZ(titled: "Tamler Mac", description: "Featuring revolutionary new Tamler Macintosh technologies.", imageName: "alfred_e 1024"))
//        tempProductsArray.append(ShepSingleXYZ(titled: "MacBook", description: "The thinnest and lightest Mac ever with every component meticulously redesigned to create a Mac that is just two pounds and 13.1 mm thin. ", imageName: "macbook"))
//        tempProductsArray.append(ShepSingleXYZ(titled: "MacBook Pro with Retina Display", description: "A stunning high-resolution display, an amazing thin and light design, and the latest technology to power through the most demanding projects.", imageName: "macbook-pro-retina"))
//        tempProductsArray.append(ShepSingleXYZ(titled: "MacBook Air", description: "All day battery life, fourth generation Intel Core processors with faster graphics, 802.11ac Wi-Fi and flash storage that is up to 45 percent faster than the previous generation.", imageName: "macbook-air"))
//        tempProductsArray.append(ShepSingleXYZ(titled: "iMac", description: "The 27-inch iMac with Retina 5K display features a breathtaking 14.7 million pixel display so text appears sharper than ever, videos are unbelievably lifelike.", imageName: "imac-5k"))
//        tempProductsArray.append(ShepSingleXYZ(titled: "Mac Pro", description: "Designed around a revolutionary unified thermal core, the Mac Pro introduces a completely new pro desktop architecture and design that is optimized for performance inside and out.", imageName: "mac-pro"))
//        tempProductsArray.append(ShepSingleXYZ(titled: "Mac Mini", description: "With its sleek aluminum design, a removable bottom panel for easy access to memory, and a space-saving built-in power supply, Mac mini is pretty incredible.", imageName: "mac-mini"))
//
//        return sectionOfProducts_class(named: "Mac", includeProducts: tempProductsArray)
//    }
//
//
//    private class func software() -> sectionOfProducts_class {
//        var tempProductsArray = [ShepSingleXYZ]()
//
//        tempProductsArray.append(ShepSingleXYZ(titled: "Tamler software", description: "Built on a rock-solid Tamler Tamler Shep Shep.", imageName: "brass coin"))
//        tempProductsArray.append(ShepSingleXYZ(titled: "iLife", description: "Do more with movies and music than you ever thought possible.", imageName: "ilife"))
//        tempProductsArray.append(ShepSingleXYZ(titled: "iWork", description: " iWork is the easiest way to create great-looking documents, spreadsheets, and presentations. ", imageName: "iwork"))
//
//        return sectionOfProducts_class(named: "Software", includeProducts: tempProductsArray)
//    }
//
//
//    private class func iPod() -> sectionOfProducts_class {
//        var tempProductsArray = [ShepSingleXYZ]()
//
//        tempProductsArray.append(ShepSingleXYZ(titled: "Tamler ipod", description: "Built on a rock-solid real iCoy.  This is filler to go to at least two lines", imageName: "brass coin"))
//        tempProductsArray.append(ShepSingleXYZ(titled: "iPod shuffle", description: "Crafted from a single piece of aluminium and polished to a beautiful shine, iPod shuffle feels solid, sleek and durable.", imageName: "ipod-shuffle"))
//        tempProductsArray.append(ShepSingleXYZ(titled: "iPod touch", description: "Featuring a brilliant 4-inch Retina display; a 5-megapixel iSight camera with 1080p HD video recording.", imageName: "ipod-touch"))
//
//        return sectionOfProducts_class(named: "iPod and iTunes", includeProducts: tempProductsArray)
//    }
//
//}
//
//
//
//
//
//
//
//
//
//
//
//
//

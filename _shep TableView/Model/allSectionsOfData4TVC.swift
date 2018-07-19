//
//  sectionOfProducts_class.swift
//  TableViewDemo
//
//  Created by Duc Tran on 3/22/15.
//  Copyright (c) 2015 Duc Tran. All rights reserved.
//

/*  RE INSTANCE METHOD V CLASS METHOD
 
 You can only call an instance method on an instance of a class. For example, you would have to create an instance of myScript, then call it:
 
 let script = myScript()
 script.thisIsmyFunction()
 
 You can also choose to make thisIsmyFunction a class method (which is formally known as a "type method" in Swift), and call it like the way you are doing right now:
 
 class func thisIsmyFunction() {...}
 
 Note the class modifier in front of func. Of course, this means you can't access self inside the function, because there is no longer an instance of the class.
 
 */


import Foundation

struct allSectionsOfData4TVC {
    
    var sectionName: String            // name of the product line
    var oneSectionOfData : [ShepSingleXYZ]
    
    init(named: String, includeItems: [ShepSingleXYZ]) {
        sectionName = named
        oneSectionOfData = includeItems
    }
    
    static func handleAllTheSections(whichSort: String) -> [allSectionsOfData4TVC] {
        var myBigKahunaSectionedArray = [allSectionsOfData4TVC]()
        let MYtempSingleArray = tempSingleArray_class.buildSingleTableArray()
        
        switch whichSort {
        case "jobType" :   // CATEGORY !
            let sortedTempSingleArray = MYtempSingleArray.sorted(by: { $0.jobType < $1.jobType })
            myBigKahunaSectionedArray = doMultipleSections(sortedTempSingleArray: sortedTempSingleArray, whichSort: whichSort)
        case "foodType" :   // CATEGORY 2
            let sortedTempSingleArray = MYtempSingleArray.sorted(by: { $0.foodType < $1.foodType })
            myBigKahunaSectionedArray = doMultipleSections(sortedTempSingleArray: sortedTempSingleArray, whichSort: whichSort)
        case "dollars" : // SINGLE SECTION 1
            let sortedTempSingleArray = MYtempSingleArray.sorted(by: { $0.dollar > $1.dollar })
            myBigKahunaSectionedArray = doOneSection(sortedTempSingleArray: sortedTempSingleArray, whichSort: whichSort)
        case "distance" : // SINGLE SECTION 2
            let sortedTempSingleArray = MYtempSingleArray.sorted(by: { $0.distance < $1.distance })
            myBigKahunaSectionedArray = doOneSection(sortedTempSingleArray: sortedTempSingleArray, whichSort: whichSort)
        case "title" : // SINGLE SECTION 3
            let sortedTempSingleArray = MYtempSingleArray.sorted(by: { $0.title < $1.title })
            myBigKahunaSectionedArray = doOneSection(sortedTempSingleArray: sortedTempSingleArray, whichSort: whichSort)
////    SORTING TEXT w CASE INSENSITIVE
//            let array = ["def","Ghi","Abc" ]
//            let sorted1 = array.sorted{$0.compare($1) == .orderedAscending}
//            print(sorted1)  // ["Abc", "Ghi", "def"]
//            let sorted2 = array.sorted{$0.localizedCompare($1) == .orderedAscending}
//            print(sorted2) // ["Abc", "def", "Ghi"]
////    you can also use the String compare options parameter to give you more control when comparing your strings
//            let sorted3 = array.sorted{$0.compare($1, options: .caseInsensitive) == .orderedAscending }
//            print(sorted3)   // ["Abc", "def", "Ghi"]\n"
////    which can be simplifyed using the string method caseInsensitiveCompare
//            let sorted4 = array.sorted{$0.caseInsensitiveCompare($1) == .orderedAscending}
//            print(sorted4) // ["Abc", "def", "Ghi"]\n"
////    or localized caseInsensitiveCompare
//            let array5 = ["Cafe B","Café C","Café A"]
//            let sorted5 = array5.sorted{$0.localizedCaseInsensitiveCompare($1) == .orderedAscending}
//            print(sorted5) // "["Café A", "Cafe B", "Café C"]\n"

        default:
            let sortedTempSingleArray = MYtempSingleArray.sorted(by: { $0.dollar > $1.dollar })
            myBigKahunaSectionedArray = doOneSection(sortedTempSingleArray: sortedTempSingleArray, whichSort: "NO SORT SPECIFIED??")
            
            /*
             //Starting with Swift 4 you can define a sorting method which takes a Key-Path Expression as argument:
             
             extension Array {
             mutating func sort<T: Comparable>(byKeyPath keyPath: KeyPath<Element, T>) {
             sort(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })
             }
             }
             // Example usage:
             
             persons.sort(byKeyPath: \.name)
             cars.sort(byKeyPath: \.manufacturer)
             
             // MORE NOTES BELOW
             */
        }
        print(" \n I'm done building myBigKahunaSectionedArray w sort \(whichSort)")
        return myBigKahunaSectionedArray
    }
    
    static func doOneSection(sortedTempSingleArray: [ShepSingleXYZ], whichSort: String) -> [allSectionsOfData4TVC] {
        var tempBigKahunaSectionedArray = [allSectionsOfData4TVC]()
        //tempBigKahunaSectionedArray.append (allSectionsOfData4TVC(named: "ALL ONE SECTION", includeItems: sortedTempSingleArray))
        tempBigKahunaSectionedArray.append (allSectionsOfData4TVC(named: whichSort, includeItems: sortedTempSingleArray))
        print("****  I'm in doOneSection w sort \(whichSort)")
        return tempBigKahunaSectionedArray
    }
    
    static func doMultipleSections(sortedTempSingleArray: [ShepSingleXYZ], whichSort: String) -> [allSectionsOfData4TVC] {
        var tempBigKahunaSectionedArray = [allSectionsOfData4TVC]()
        var oneSectionOfData = [ShepSingleXYZ]()
        var currentSectionName = ""
        var loopCount = 0
        print("**** I'm in MultipleSections w sort \(whichSort)")
        
        for item in sortedTempSingleArray {
            // NOTE: "continue" to move loop to next iteration/item
            //       "break" to exit the loop statement
            var thisItemSectionName: String
            if whichSort == "foodType" {thisItemSectionName = item.foodType} else {thisItemSectionName = item.jobType}
            loopCount += 1
            if currentSectionName == "" {
                // no currentSectionName, first item through
                currentSectionName = thisItemSectionName
                oneSectionOfData.append(item)
            } else { // not first time through
                if thisItemSectionName == currentSectionName {  // same category/section as previous one, so just add the item
                    oneSectionOfData.append(item)
                } else { // is new category/section
                    // so append to myBigKahunaSectionedArray and start clean oneSectionOfData
                    //SORT ONE SECTION AT A TIME -- if needed???
                    tempBigKahunaSectionedArray.append (allSectionsOfData4TVC(named: currentSectionName, includeItems: oneSectionOfData))
                    oneSectionOfData.removeAll()
                    currentSectionName = thisItemSectionName
                    oneSectionOfData.append(item)
                }
            }
            if loopCount == sortedTempSingleArray.count {  // last iteration
                //SORT ONE SECTION AT A TIME -- if needed???
                tempBigKahunaSectionedArray.append (allSectionsOfData4TVC(named: currentSectionName, includeItems: oneSectionOfData))
            }
        }
        return tempBigKahunaSectionedArray
    }
}

/*
 //Swift keypaths are a way of storing uninvoked references to properties, which is a fancy way of saying they refer to a property itself rather than to that property’s value.
 
 //Here’s an example struct storing a name and maximum warp speed of a starship:
 struct Starship {
 var name: String
 var maxWarp: Double
 }
 
 let voyager = Starship(name: "Voyager", maxWarp: 9.975)
 //Keypaths let us refer to the name or maxWarp properties without reading them directly, like this:
 
 let nameKeyPath = \Starship.name
 let warpKeyPath = \Starship.maxWarp
 //If you want to read those keypaths on a specific starship, Swift will return you the actual values attached to those properties:
 
 print(voyager[keyPath: nameKeyPath])
 print(voyager[keyPath: warpKeyPath])
 //In practice, this means you can refer to the same property in multiple places all using the same keypath – and if you decide you want a different property you can change it in just one place.
 */

/*
 //Let define a struct called Cavaliers and a struct called Player, then create one instance of each:
 
 // an example struct
 struct Player {
 var name: String
 var rank: String
 }
 
 // another example struct, this time with a method
 struct Cavaliers {
 var name: String
 var maxPoint: Double
 var captain: Player
 
 func goTomaxPoint() {
 print("\(name) is now travelling at warp \(maxPoint)")
 }
 }
 
 // create instances of those two structs
 let james = Player(name: "Lebron", rank: "Captain")
 let irving = Cavaliers(name: "Kyrie", maxPoint: 9.975, captain: james)
 
 // grab a reference to the `goTomaxPoint()` method
 let score = irving.goTomaxPoint
 
 // call that reference
 score()
 //The last lines create a reference to the goTomaxPoint() method called score. The problem is, we can't create a reference to the captain's name property but keypath can do.
 
 let nameKeyPath = \Cavaliers.name
 let maxPointKeyPath = \Cavaliers.maxPoint
 let captainName = \Cavaliers.captain.name
 let cavaliersName = irving[keyPath: nameKeyPath]
 let cavaliersMaxPoint = irving[keyPath: maxPointKeyPath]
 let cavaliersNameCaptain = irving[keyPath: captainName]
 */

////////////////////////////////

/*
 //Since Swift is a statically dispatched language, dynamic features are not its strong suit. Swift 4 added support for key path and allow you to do something like this:
 
 extension Array {
 mutating func sort<T: Comparable>(byKeyPath keyPath: KeyPath<Element, T>) {
 sort(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })
 }
 }
 
 struct DataModel {
 var title: String
 var dollar: Double
 }
 
 var myArray = [DataModel(title: "A", dollar: 12), DataModel(title: "B", dollar: 10)]
 let keyPath = \DataModel.dollar
 myArray.sort(byKeyPath: keyPath)
 
 //But there is no way to construct the key path from String. It must be known at compile time to ensure type safety.
 */

















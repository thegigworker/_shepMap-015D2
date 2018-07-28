//
//  sectionOfProducts_class.swift
//
//  Thanks to by Duc Tran on 3/22/15.
//  Copyright (c) 2015 Duc Tran. All rights reserved.
//


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


















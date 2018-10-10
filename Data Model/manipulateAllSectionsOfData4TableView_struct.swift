//
//  sectionOfProducts_class.swift
//
//  Thanks to by Duc Tran on 3/22/15.
//  Copyright (c) 2015 Duc Tran. All rights reserved.
//


import Foundation

struct manipulateAllSectionsOfData4TableView_struct {
    
    var sectionName: String            // name of the product line
    var oneSectionOfData : [ShepSingleAnnotation]

    init(named: String, includeItems: [ShepSingleAnnotation]) {
        sectionName = named
        oneSectionOfData = includeItems
    }
    
    static func handleAllTheSections(whichSort: String) -> [manipulateAllSectionsOfData4TableView_struct] {
        //let mySingleArray = fakeAnnotationsSingleArray_class.buildSingleTableArray()
        let mySingleArray = shepDataModel.theMASTERAnnotationsArray
        print("theMASTERAnnotationsArray.count =  \(shepDataModel.theMASTERAnnotationsArray.count)")
        print ("mySingleArray.count =  \(mySingleArray.count)")
        
        var myBigKahunaSectionedArray = [manipulateAllSectionsOfData4TableView_struct]()
        
        switch mySort { // mySort.rawValue = String of mySort
        case .JobTitle :
            let sortedSingleArray = mySingleArray.sorted(by: { $0.jobTitle! < $1.jobTitle! })
            myBigKahunaSectionedArray = doOneSection(sortedSingleArray: sortedSingleArray, whichSort: mySort.rawValue)
        case .JobPay :
            let sortedSingleArray = mySingleArray.sorted(by: { $0.shepDollarValue > $1.shepDollarValue })
            myBigKahunaSectionedArray = doOneSection(sortedSingleArray: sortedSingleArray, whichSort: mySort.rawValue)
        case .DrivingDistance :
            let sortedSingleArray = mySingleArray.sorted(by: { $0.routeDrivingDistance < $1.routeDrivingDistance })
            myBigKahunaSectionedArray = doOneSection(sortedSingleArray: sortedSingleArray, whichSort: mySort.rawValue)
        case .JobProfit :
            let sortedSingleArray = mySingleArray.sorted(by: { $0.routeProfit > $1.routeProfit })
            myBigKahunaSectionedArray = doOneSection(sortedSingleArray: sortedSingleArray, whichSort: mySort.rawValue)
        case .CrowFliesDistance :
            let sortedSingleArray = mySingleArray.sorted(by: { $0.crowFliesDistance < $1.crowFliesDistance })
            myBigKahunaSectionedArray = doOneSection(sortedSingleArray: sortedSingleArray, whichSort: mySort.rawValue)
        case .ZIPCode :
            let sortedSingleArray = mySingleArray.sorted(by: { $0.ZipCode! < $1.ZipCode! })
            myBigKahunaSectionedArray = doOneSection(sortedSingleArray: sortedSingleArray, whichSort: mySort.rawValue)
        case .City :
            let sortedSingleArray = mySingleArray.sorted(by: { $0.City! < $1.City! })
            myBigKahunaSectionedArray = doMultipleSections(sortedSingleArray: sortedSingleArray, whichSort: mySort.rawValue)
        case .JobSource:
            let sortedSingleArray = mySingleArray.sorted(by: { $0.myGigSource.rawValue < $1.myGigSource.rawValue })
            myBigKahunaSectionedArray = doMultipleSections(sortedSingleArray: sortedSingleArray, whichSort: mySort.rawValue)
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
    
    static func doOneSection(sortedSingleArray: [ShepSingleAnnotation], whichSort: String) -> [manipulateAllSectionsOfData4TableView_struct] {
        var tempBigKahunaSectionedArray = [manipulateAllSectionsOfData4TableView_struct]()
        //tempBigKahunaSectionedArray.append (allSectionsOfData4TVC_NEW(named: "ALL ONE SECTION", includeItems: sortedTempSingleArray))
        tempBigKahunaSectionedArray.append (manipulateAllSectionsOfData4TableView_struct(named: whichSort, includeItems: sortedSingleArray))
        print("****  I'm in doOneSection w sort \(whichSort)")
        return tempBigKahunaSectionedArray
    }
    
    static func doMultipleSections(sortedSingleArray: [ShepSingleAnnotation], whichSort: String) -> [manipulateAllSectionsOfData4TableView_struct] {
        var tempBigKahunaSectionedArray = [manipulateAllSectionsOfData4TableView_struct]()
        var oneSectionOfData = [ShepSingleAnnotation]()
        var currentSectionName = ""
        var loopCount = 0
        print("**** I'm in MultipleSections w sort \(whichSort)")
        
        for item in sortedSingleArray {
            // NOTE: "continue" to move loop to next iteration/item
            //       "break" to exit the loop statement
            var thisItemSectionName: String
            if mySort == .JobSource{thisItemSectionName = item.myGigSource.rawValue} else {thisItemSectionName = item.City!}
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
                    tempBigKahunaSectionedArray.append (manipulateAllSectionsOfData4TableView_struct(named: currentSectionName, includeItems: oneSectionOfData))
                    oneSectionOfData.removeAll()
                    currentSectionName = thisItemSectionName
                    oneSectionOfData.append(item)
                }
            }
            if loopCount == sortedSingleArray.count {  // last iteration
                //SORT ONE SECTION AT A TIME -- if needed???
                tempBigKahunaSectionedArray.append (manipulateAllSectionsOfData4TableView_struct(named: currentSectionName, includeItems: oneSectionOfData))
            }
        }
        return tempBigKahunaSectionedArray
    }
}


















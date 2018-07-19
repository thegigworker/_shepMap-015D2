//
//  UI POPOVER PRESENTATION CONTROLLER
//

/*
 A NOTE RE ?? OPERATOR RE OPTIONALS
 "nil coalescing operator" (also called "default operator")
 
 let something = myVariable ?? myOtherVariable
 Can be thought of as  "let something = UNWRAPPED myVariable if it's not nil, OTHERWISE let something = myOtherVariable"
 
 equivalent to
 let something = myVariable != nil ? myVariable! : myOtherVariable
 */

import UIKit
import MapKit

var whichSort = "distance"

//case "distance" : // SINGLE SECTION 1
//case "title" : // SINGLE SECTION 2
//case "dollars" : // SINGLE SECTION 3
//case "jobType" :   // CATEGORY !
//case "foodType" :   // CATEGORY 2

class sortingHatPopover: UIViewController, UIPopoverPresentationControllerDelegate {
    
    //@IBOutlet weak var xyz: UIButton!
    
    //let myDataModel = shepDataModel()
    
    var myShepTVController = ShepTVController()
    
    @IBOutlet weak var btnDrivingDistance: UIButton!
    @IBOutlet weak var checkmark1: UIImageView!
    @IBOutlet weak var btnTitle: UIButton!
    @IBOutlet weak var checkmark2: UIImageView!
    @IBOutlet weak var btnDollars: UIButton!
    @IBOutlet weak var checkmark3: UIImageView!
    @IBOutlet weak var btnCat1_jobType: UIButton!
    @IBOutlet weak var checkmark4: UIImageView!
    @IBOutlet weak var btnCat2_foodType: UIButton!
    @IBOutlet weak var checkmark5: UIImageView!
    
    @IBAction func selected_DrivingDistance(_ sender: UIButton) {
        clearCheckMarks()
        whichSort = "distance"
        checkmark1.isHidden = false
        print ("whichSort tapped: \(whichSort)")
       myShepTVController.redrawTableView()
    }
    
    @IBAction func selected_Title(_ sender: UIButton) {
        clearCheckMarks()
        whichSort = "title"
        checkmark2.isHidden = false
        print ("whichSort tapped: \(whichSort)")
       myShepTVController.redrawTableView()
    }
    
    @IBAction func selected_Dollars(_ sender: UIButton) {
        clearCheckMarks()
        whichSort = "dollars"
        checkmark3.isHidden = false
        print ("whichSort tapped: \(whichSort)")
       myShepTVController.redrawTableView()
    }
    
    @IBAction func selected_Cat1_jobType(_ sender: UIButton) {
        clearCheckMarks()
        whichSort = "jobType"
        checkmark4.isHidden = false
        print ("whichSort tapped: \(whichSort)")
        myShepTVController.redrawTableView()
    }
    
    @IBAction func selected_Cat2_foodType(_ sender: UIButton) {
        clearCheckMarks()
        whichSort = "foodType"
        checkmark5.isHidden = false
        print ("whichSort tapped: \(whichSort)")
        myShepTVController.redrawTableView()
    }
    
    func clearCheckMarks() {
        checkmark1.isHidden = true
        checkmark2.isHidden = true
        checkmark3.isHidden = true
        checkmark4.isHidden = true
        checkmark5.isHidden = true
    }
    
//    func redrawMyTableView() {  // not quite working yet
//        myShepTVController.BigKahunaSectionedArray = allSectionsOfData4TVC.handleAllTheSections(whichSort: whichSort)
//        myShepTVController.tableView.reloadData()  // Reloads everything from scratch. Redisplays visible rows. Note that this will cause any existing drop placeholder rows to be removed.
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearCheckMarks()
        switch whichSort{
        case "distance" : // SINGLE SECTION 2
            checkmark1.isHidden = false
        case "title" : // SINGLE SECTION 3
            checkmark2.isHidden = false
        case "dollars" : // SINGLE SECTION 1
            checkmark3.isHidden = false
        case "jobType" :   // CATEGORY !
            checkmark4.isHidden = false
        case "foodType" :   // CATEGORY 2
            checkmark5.isHidden = false
        default:
            checkmark5.isHidden = false  // "foodType"
        }
        
        //checkmark1.isHidden = false
        // Do any additional setup after loading the view, typically from a nib.
        //        SearchDistanceSlider.value = Float(meters2miles(meters: myDataModel.currentSearchDistance))
        //        let value = SearchDistanceSlider.value
        //        print ("UIPopover SearchDistanceSlider.value: \(value)")
        //        SearchRadiusText.text = String(format: "%.01f", value) + " mi."
        
        print ("UIPopover viewDidLoad")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



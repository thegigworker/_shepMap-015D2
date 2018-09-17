//
//  UI POPOVER PRESENTATION CONTROLLER
//

import UIKit
import MapKit

var mySort = whichSort_enum.JobTitle

enum whichSort_enum : String {
    case JobTitle
    case JobPay
    case DrivingDistance
    case JobProfit
    case CrowFliesDistance
    case ZIPCode
    case City
    case JobSource
}

protocol TableViewSortingHatDelegate: class {
    func redrawTableView()
}

class sortingHatPopover: UIViewController, UIPopoverPresentationControllerDelegate {

    weak var myTableViewSortingHatDelegate: TableViewSortingHatDelegate!
    
    @IBOutlet weak var checkmark0: UIImageView!
    @IBOutlet weak var btnjobTitle: UIButton!
    @IBOutlet weak var checkmark1: UIImageView!
    @IBOutlet weak var btnJobPay: UIButton!
    @IBOutlet weak var checkmark2: UIImageView!
    @IBOutlet weak var btnDrivingDistance: UIButton!
    @IBOutlet weak var checkmark3: UIImageView!
    @IBOutlet weak var btnJobProfit: UIButton!
    @IBOutlet weak var checkmark4: UIImageView!
    @IBOutlet weak var btnCrowFliesDistance: UIButton!
    @IBOutlet weak var checkmark5: UIImageView!
    @IBOutlet weak var btnZIPCode: UIButton!
    @IBOutlet weak var checkmark6: UIImageView!
    @IBOutlet weak var btnCity: UIButton!
    @IBOutlet weak var checkmark7: UIImageView!
    @IBOutlet weak var btnJobSource: UIButton!
    
    //MARK: - Functions
    
    @IBAction func selected_JobTitle(_ sender: UIButton) {
        clearCheckMarks()
        mySort = whichSort_enum.JobTitle
        checkmark0.isHidden = false
        print ("whichSort tapped: \(mySort)")
        myTableViewSortingHatDelegate.redrawTableView()
    }
    
    @IBAction func selected_JobPay(_ sender: UIButton) {
        clearCheckMarks()
        mySort = whichSort_enum.JobPay
        checkmark1.isHidden = false
        print ("whichSort tapped: \(mySort)")
        myTableViewSortingHatDelegate.redrawTableView()
    }
    
    @IBAction func selected_DrivingDistance(_ sender: UIButton) {
        clearCheckMarks()
        mySort = whichSort_enum.DrivingDistance
        checkmark2.isHidden = false
        print ("whichSort tapped: \(mySort)")
        myTableViewSortingHatDelegate.redrawTableView()
    }
    
    @IBAction func selected_JobProfit(_ sender: UIButton) {
        clearCheckMarks()
        mySort = whichSort_enum.JobProfit
        checkmark3.isHidden = false
        print ("whichSort tapped: \(mySort)")
        myTableViewSortingHatDelegate.redrawTableView()
    }
    
    @IBAction func selected_CrowFliesDistance(_ sender: UIButton) {
        clearCheckMarks()
        mySort = whichSort_enum.CrowFliesDistance
        checkmark4.isHidden = false
        print ("whichSort tapped: \(mySort)")
        myTableViewSortingHatDelegate.redrawTableView()
    }
    
    @IBAction func selected_ZIPCode(_ sender: UIButton) {
        clearCheckMarks()
        mySort = whichSort_enum.ZIPCode
        checkmark5.isHidden = false
        print ("whichSort tapped: \(mySort)")
        myTableViewSortingHatDelegate.redrawTableView()
    }
    
    @IBAction func selected_City(_ sender: UIButton) {
        clearCheckMarks()
        mySort = whichSort_enum.City
        checkmark6.isHidden = false
        print ("whichSort tapped: \(mySort)")
        myTableViewSortingHatDelegate.redrawTableView()
    }
    
    @IBAction func selected_JobSource(_ sender: UIButton) {
        clearCheckMarks()
        mySort = whichSort_enum.JobSource
        checkmark7.isHidden = false
        print ("whichSort tapped: \(mySort)")
        myTableViewSortingHatDelegate?.redrawTableView()
    }
    
    func clearCheckMarks() {
        checkmark0.isHidden = true
        checkmark1.isHidden = true
        checkmark2.isHidden = true
        checkmark3.isHidden = true
        checkmark4.isHidden = true
        checkmark5.isHidden = true
        checkmark6.isHidden = true
        checkmark7.isHidden = true
        //BELOW FOR LOOP NOT WORKING.  WHY?
        //      for i in 0...7 {
        //          let checkmarkName = UIImage(named: "checkmark + \(i)")
        //          //let whichCheckmarkName = "checkmark + \(i)"
        //          let whichImageView = UIImageView(image: checkmarkName)
        //          //let whichImageView = UIImageView(
        //          whichImageView.isHidden = true
        //      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearCheckMarks()
        
        switch mySort{
        case .JobTitle :
            checkmark0.isHidden = false
        case .JobPay :
            checkmark1.isHidden = false
        case .DrivingDistance :
            checkmark2.isHidden = false
        case .JobProfit :
            checkmark3.isHidden = false
        case .CrowFliesDistance :
            checkmark4.isHidden = false
        case .ZIPCode :
            checkmark5.isHidden = false
        case .City :
            checkmark6.isHidden = false
        case .JobSource :
            checkmark7.isHidden = false
        }
        
        print ("sortingHatPopover viewDidLoad")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



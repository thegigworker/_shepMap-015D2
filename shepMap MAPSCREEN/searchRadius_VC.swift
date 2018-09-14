//
//  UI POPOVER PRESENTATION CONTROLLER
//


import UIKit
import MapKit

protocol SearchDistanceSliderDelegate: class {
    func drawSearchDistanceCircle(searchDistance: Double)
    func clearSearchDistanceCircle()
}

class searchRadiusViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    //let myDataModel = shepDataModel()
    weak var mySearchDistanceSliderDelegate : SearchDistanceSliderDelegate!
    let myMAPSCREEN_VC = MAPSCREEN_VC()
    
    //var searchDistanceCircle:MKCircle!

    @IBOutlet weak var SearchDistanceSlider: UISlider!
    @IBOutlet weak var SearchRadiusText: UILabel!
   // @IBOutlet weak var myMapView: MKMapView!
    
    //MARK: - Functions
    
    @IBAction func SearchDistanceSliderMoved(_ sender: UISlider) {
        let value = SearchDistanceSlider.value
        SearchRadiusText.text = String(format: "%.01f", value) + " mi."
        let mySearchDistance = miles2meters(miles: Double(value))
        //print ("in SearchDistanceSliderMoved,mySearchDistance: \(mySearchDistance)")
        mySearchDistanceSliderDelegate.drawSearchDistanceCircle(searchDistance: mySearchDistance)
    }
    
//    @IBAction func touchDOWNInSearchDistanceSlider(_ sender: UISlider) {
//        print ("Touch DOWN in popover slider.")
//    }
    
    @IBAction func touchUPInSearchDistanceSlider(_ sender: UISlider) {
        //print ("Touch UP in popover slider.")
        mySearchDistanceSliderDelegate.clearSearchDistanceCircle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SearchDistanceSlider.value = Float(meters2miles(meters: (myMAPSCREEN_VC.myDataModel.currentSearchDistance)))
        let value = SearchDistanceSlider.value
        //print ("In viewDidLoad, UIPopover SearchDistanceSlider.value: \(value)")
        mySearchDistanceSliderDelegate.drawSearchDistanceCircle(searchDistance: miles2meters(miles: Double(value)))
        SearchRadiusText.text = String(format: "%.01f", value) + " mi."
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
//    Set the preferred content size on the view controller being presented not the popoverPresentationController
//
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) { // func for popover
//    if segue.identifier == "popoverViewSegue" {
//            let vc = segue.destinationViewController
//            vc.preferredContentSize = CGSize(width: 200, height: 300)
//            let controller = vc.popoverPresentationController
//            controller?.delegate = self
//            //you could set the following in your storyboard
//            controller?.sourceView = self.view
//            controller?.sourceRect = CGRect(x:CGRectGetMidX(self.view.bounds), y: CGRectGetMidY(self.view.bounds),width: 315,height: 230)
//            controller?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
//        }
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let controller = segue.destination
//        if let nv = controller.popoverPresentationController{
//            nv.delegate = self
//        }
//    }
//    
//    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
//        return true
//    }
//    
//    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
//        print ("Dismissed")
//    }
//    
//    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
//        return .none
//    }
}


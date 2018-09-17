//
//DebugViewController.swift
//

import Foundation
import UIKit


class DebugViewController : UIViewController {
    
    var myMAPSCREEN_VC = MAPSCREEN_VC()
    var myDataModel = shepDataModel()
    
    
    @IBAction func logout(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var RouteDataView: UIView!
    @IBOutlet weak var theGoldRouteView: UIView!
    @IBOutlet weak var lblCrowFlies: UILabel!
    @IBOutlet weak var lblDrivingDistance: UILabel!
    @IBOutlet weak var lblDrivingTime: UILabel!
    @IBOutlet weak var lblPay: UILabel!
    @IBOutlet weak var lblExpense: UILabel!
    @IBOutlet weak var lblEarning: UILabel!
    
    func showRouteInfo (asCrowFlies: String, DrivingDistance: String, DrivingTime: String) {
        RouteDataView.alpha = 1
        lblCrowFlies.text = asCrowFlies
        lblDrivingDistance.text = DrivingDistance
        lblDrivingTime.text = DrivingTime
    }
    
    func showGoldRouteInfo (Pay: String, Expense: String, Earning: String) {
        lblPay.text = Pay
        lblExpense.text = Expense
        lblEarning.text = Earning
        theGoldRouteView.alpha = 0.9
    }
    
    func clearRouteInfo() {
        RouteDataView.alpha = 0
        theGoldRouteView.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print ("DebugViewController ViewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print ("in DebugViewController.ViewWillAppear \n")
    }
    
    //override func viewWillAppear(_ animated: Bool) {
        //print ("in DebugViewController.ViewWillAppear \n")
//        switch myRouteInfo {
//        case .None :
//            RouteDataView.alpha = 0
//            theGoldRouteView.alpha = 0
//        case .Route :
//            RouteDataView.alpha = 1
//            let thisRoute = myDataModel.currentRoute
//            let drivingDistance = meters2miles(meters: (thisRoute.distance)) // response distance in meters
//            let drivingTime = ((thisRoute.expectedTravelTime) / 60)  //expectedTravelTime is in secs
//            RouteDataView.alpha = 0.9
//            lblCrowFlies.text = "As crow flies: \(String(format: "%.02f", myDataModel.crowFliesDistance)) miles"
//            lblDrivingDistance.text = "Driving distance: \(String(format: "%.02f", drivingDistance)) miles"
//            lblDrivingTime.text = "Driving time: \(String(format: "%.02f", drivingTime)) minutes"
//        case .GoldRoute :
//            RouteDataView.alpha = 1
//            theGoldRouteView.alpha = 1
//            let myTitle = myMAPSCREEN_VC.myChosenGoldAnnotation?.title
//            let myDrivingDistance = myMAPSCREEN_VC.myChosenGoldAnnotation?.routeDrivingDistance
//            let routeExpense : Double = (myDrivingDistance)! * Double(myDataModel.centsPerMileExpense)/100
//            let myGoldRouteScore = myMAPSCREEN_VC.myChosenGoldAnnotation?.routeProfit
//            lblPay.text = "PAY:           \(String(describing: myTitle!))"
//            lblExpense.text = "EXPENSE:  \(shepCurrencyFromDouble(shepNumber: routeExpense))      (60¢ / mile)"
//            lblEarning.text = "EARNING: \(shepCurrencyFromDouble(shepNumber: myGoldRouteScore!))"
//            theGoldRouteView.alpha = 0.9
//            RouteDataView.alpha = 0.9
//        }
        
    //}
    

}

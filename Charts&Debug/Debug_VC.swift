//
//DebugViewController.swift
//

import Foundation
import UIKit


struct labelInfo_struct {
    
    enum whichDataView: String {
        case RouteInfo
        case GoldRouteInfo
        case None
    }
    
    static var myDataView: whichDataView = .None
    static var lblCrowFlies: String = ""
    static var lblDrivingDistance: String = ""
    static var lblDrivingTime: String = ""
    static var lblPay: String = ""
    static var lblExpense: String = ""
    static var lblEarning: String = ""
}


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
    
//    func showRouteInfo () {
//        RouteDataView.alpha = 1
//        theGoldRouteView.alpha = 0
//        lblCrowFlies.text = labelInfo_struct.lblCrowFlies
//        lblDrivingDistance.text = labelInfo_struct.lblDrivingDistance
//        lblDrivingTime.text = labelInfo_struct.lblDrivingTime
//    }
//    
//    func showGoldRouteInfo () {
//        RouteDataView.alpha = 1
//        theGoldRouteView.alpha = 1
//        lblCrowFlies.text = labelInfo_struct.lblCrowFlies
//        lblDrivingDistance.text = labelInfo_struct.lblDrivingDistance
//        lblDrivingTime.text = labelInfo_struct.lblDrivingTime
//        lblPay.text = labelInfo_struct.lblPay
//        lblExpense.text = labelInfo_struct.lblExpense
//        lblEarning.text = labelInfo_struct.lblEarning
//    }
//    
//    func clearRouteInfo() {
//        RouteDataView.alpha = 0
//        theGoldRouteView.alpha = 0
//        lblCrowFlies.text = ""
//        lblDrivingDistance.text = ""
//        lblDrivingTime.text = ""
//        lblPay.text = ""
//        lblExpense.text = ""
//        lblEarning.text = ""
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print ("DebugViewController ViewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        switch labelInfo_struct.myDataView {
            
        case .None :
            RouteDataView.alpha = 0
            theGoldRouteView.alpha = 0
            lblCrowFlies.text = ""
            lblDrivingDistance.text = ""
            lblDrivingTime.text = ""
            lblPay.text = ""
            lblExpense.text = ""
            lblEarning.text = ""
            
        case .RouteInfo :
            RouteDataView.alpha = 1
            theGoldRouteView.alpha = 0
            lblCrowFlies.text = labelInfo_struct.lblCrowFlies
            lblDrivingDistance.text = labelInfo_struct.lblDrivingDistance
            lblDrivingTime.text = labelInfo_struct.lblDrivingTime
            
        case .GoldRouteInfo :
            RouteDataView.alpha = 1
            theGoldRouteView.alpha = 1
            lblCrowFlies.text = labelInfo_struct.lblCrowFlies
            lblDrivingDistance.text = labelInfo_struct.lblDrivingDistance
            lblDrivingTime.text = labelInfo_struct.lblDrivingTime
            lblPay.text = labelInfo_struct.lblPay
            lblExpense.text = labelInfo_struct.lblExpense
            lblEarning.text = labelInfo_struct.lblEarning
        }
    }
}

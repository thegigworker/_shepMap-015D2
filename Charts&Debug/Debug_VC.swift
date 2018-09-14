
//
//DebugViewController.swift
//


import Foundation
import UIKit

class DebugViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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
}

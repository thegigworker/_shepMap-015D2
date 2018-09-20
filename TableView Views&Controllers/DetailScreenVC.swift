//
//  EditTableViewController.swift
//
//  Created by Duc Tran on 3/30/15.
//  Copyright (c) 2015 Duc Tran. All rights reserved.
//

import UIKit
import MapKit

protocol MAPSCREEN_DetailScreenDelegate: class {
    func centerMapOnLocation(location: CLLocation)
}

class shepDetailScreenVC: UITableViewController, UITextFieldDelegate, UITextViewDelegate {

    // Model:
    var mySingleAnnotation: ShepSingleAnnotation?
    let myDataModel = shepDataModel()
    let myMAPSCREEN = MAPSCREEN_VC()
    let mySlideInBounce_AnimTransition = slideInBounce_AnimTransition()
    weak var myMAPSCREEN_DetailScreenDelegate: MAPSCREEN_DetailScreenDelegate!

    @IBOutlet weak var myDescriptionTextView: UITextView!
    @IBOutlet weak var myImage1: UIImageView!
    @IBOutlet weak var myImage2: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lblStreetAddress: UILabel!
    @IBOutlet weak var lblPay: UILabel!
    @IBOutlet weak var lblPayCents: UILabel!
    @IBOutlet weak var lblExpense: UILabel!
    @IBOutlet weak var lblExpenseCents: UILabel!
    @IBOutlet weak var lblProfit: UILabel!
    @IBOutlet weak var lblProfitCents: UILabel!
    @IBOutlet weak var lblCrowFlies: UILabel!
    @IBOutlet weak var lblCrowFlies2: UILabel!
    @IBOutlet weak var lblDriveDistance: UILabel!
    @IBOutlet weak var lblDriveDistance2: UILabel!
    @IBOutlet weak var lblDriveTime: UILabel!
    @IBOutlet weak var lblDriveTime2: UILabel!
    @IBOutlet weak var lblForBelow: UILabel!
    
    @IBAction func doDirections(_ sender: Any) {
        if let location = mySingleAnnotation {
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//        // Note: Explore the MKMapItem documentation to see other launch option dictionary keys,
//        // and the openMaps(with:launchOptions:) method that lets you pass an array of MKMapItem objects.
        location.sendMapItemToAppleMaps().openInMaps(launchOptions: launchOptions)
        }
    }
    
    @IBAction func goToMAPSCREEN_centerOnPin(_ sender: Any) {
        self.tabBarController!.selectedIndex = 0
        if let thisSingleAnnotation =  mySingleAnnotation, let delegate = myMAPSCREEN_DetailScreenDelegate {
            let location = CLLocation(latitude: (thisSingleAnnotation.coordinate.latitude), longitude: (thisSingleAnnotation.coordinate.longitude))
            //myMAPSCREEN.centerMapOnLocation(location: location)
            delegate.centerMapOnLocation(location: location)
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // dismiss the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - UIScrollViewDelegate (is a subclass of UITableViewController)
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // resigns keyboard whenever view scrolls
        myDescriptionTextView.resignFirstResponder()
    }
    
    // MARK: - Table View Interaction
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 0 && indexPath.row == 0 {
            return indexPath
        } else {
            return nil
        }
    }
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail View"
       // myImage1.image = UIImage(named: (mySingleAnnotation?.switchGigIcon())!)
        myImage2.image = UIImage(named: (mySingleAnnotation?.switchGigIcon())!)
        myImage1.image = UIImage(named: (mySingleAnnotation?.switchGigIcon())!)
//        myImage4.image = UIImage(named: (mySingleAnnotation?.switchGigIcon())!)
//        myImage5.image = UIImage(named: (mySingleAnnotation?.switchGigIcon())!)
//        myImage6.image = UIImage(named: (mySingleAnnotation?.switchGigIcon())!)

        var tempCurrency = myDataModel.shepCurrencyFromDouble(shepNumber : (mySingleAnnotation?.shepDollarValue)!)
        lblPay.text = String(tempCurrency.dropLast(3)) // justTheDollars
        lblPayCents.text = String(tempCurrency.suffix(2)) // justTheCents
        lbTitle.text = mySingleAnnotation?.mapItem_Name
        lblForBelow.text = "This scrolling screen about the job at " +  (mySingleAnnotation?.mapItem_Name)! + " could have lots more stuff ..."
        
        let myDrivingDistance = mySingleAnnotation!.routeDrivingDistance
        
        let routeExpense : Double = myDrivingDistance * Double(myDataModel.centsPerMileExpense)/100
        tempCurrency = myDataModel.shepCurrencyFromDouble(shepNumber: routeExpense)
        lblExpense.text = String(tempCurrency.dropLast(3)) // justTheDollars
        lblExpenseCents.text = String(tempCurrency.suffix(2)) // justTheCents
        
        let myGoldRouteScore = mySingleAnnotation!.routeProfit
        tempCurrency = myDataModel.shepCurrencyFromDouble(shepNumber: myGoldRouteScore)
        lblProfit.text = String(tempCurrency.dropLast(3)) // justTheDollars
        lblProfitCents.text = String(tempCurrency.suffix(2)) // justTheCents
  
        var temp = mySingleAnnotation!.crowFliesDistance
        //lblCrowFlies.text = "As Crow Flies:"
        lblCrowFlies2.text = "\(String(format: "%.02f", temp)) miles"
        temp = mySingleAnnotation!.drivingTime
        //lblDriveTime.text = "Drive Time:"
        lblDriveTime2.text = "\(String(format: "%.02f", temp)) minutes"
        //lblDriveDistance.text = "Drive Distance:"
        lblDriveDistance2.text = "\(String(format: "%.02f", myDrivingDistance)) miles"
        lblStreetAddress.text = mySingleAnnotation?.formattedFullAddress
        myDescriptionTextView.text = mySingleAnnotation!.description
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        } else {
            // Fallback on earlier versions
        }
    }
    
    //    override func viewWillDisappear(_ animated: Bool) {
    //        shepProductDetail?.title = productTitleLabel.text!
    //        shepProductDetail?.description = productDescriptionTextView.text
    //        shepProductDetail?.image = productImageView.image!
    //    }
}

























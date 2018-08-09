//
//  EditTableViewController.swift
//
//  Created by Duc Tran on 3/30/15.
//  Copyright (c) 2015 Duc Tran. All rights reserved.
//

import UIKit

class shepDetailScreenVC: UITableViewController, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate {

    // Model:
    var mySingleAnnotation: fakeShepSingleAnnotation?
    //var shepProductDetail: ShepTempSingleItem?
    
    //@IBOutlet weak var myImageView: UIImageView!
    //@IBOutlet weak var myTitleLabel: UITextField!
    @IBOutlet weak var myDescriptionTextView: UITextView!
    @IBOutlet weak var myImage1: UIImageView!
    @IBOutlet weak var myImage2: UIImageView!
    @IBOutlet weak var myImage3: UIImageView!
    @IBOutlet weak var myImage4: UIImageView!
    @IBOutlet weak var myImage5: UIImageView!
    @IBOutlet weak var myImage6: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lblStreetAddress: UILabel!
    @IBOutlet weak var lblPay2: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblGigSource: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblExpense: UILabel!
    @IBOutlet weak var lblPay: UILabel!
    @IBOutlet weak var lblProfit: UILabel!
    @IBOutlet weak var lblCrowFlies: UILabel!
    @IBOutlet weak var lblDrivingTime: UILabel!
    @IBOutlet weak var lblDrivingDistance: UILabel!
    
    
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
        myImage1.image = UIImage(named: (mySingleAnnotation?.switchGigIcon())!)
        myImage2.image = UIImage(named: (mySingleAnnotation?.switchGigIcon())!)
        myImage3.image = UIImage(named: (mySingleAnnotation?.switchGigIcon())!)
        myImage4.image = UIImage(named: (mySingleAnnotation?.switchGigIcon())!)
        myImage5.image = UIImage(named: (mySingleAnnotation?.switchGigIcon())!)
        myImage6.image = UIImage(named: (mySingleAnnotation?.switchGigIcon())!)
        lblPay2.text = "Dollars: \(shepCurrencyFromDouble(shepNumber : (mySingleAnnotation?.shepDollarValue)!))"
        lblDistance.text = "\(String(describing: mySingleAnnotation!.routeDrivingDistance)) miles"
        lblGigSource.text = mySingleAnnotation?.myGigSource.rawValue
        lblStreetAddress.text = mySingleAnnotation?.formattedFullAddress
        //lblCity.text = mySingleAnnotation?.City
        //productImageView.image = shepProductDetail?.image
        lbTitle.text = mySingleAnnotation?.title
        //myTitleLabel.text = mySingleAnnotation?.title
        lblExpense.text = "Expense Label NOT DONE"
        lblPay.text = "Dollars: \(shepCurrencyFromDouble(shepNumber : (mySingleAnnotation?.shepDollarValue)!))"
        lblProfit.text = "Profit Label NOT DONE"
        lblCrowFlies.text = "As the Crow Flies: \(String(describing: mySingleAnnotation!.crowFliesDistance)) miles"
        lblDrivingTime.text = "Driving Time: \(String(describing: mySingleAnnotation!.drivingTime)) minutes"
        lblDrivingDistance.text = "Driving Distance: \(String(describing: mySingleAnnotation!.routeDrivingDistance)) miles"
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






























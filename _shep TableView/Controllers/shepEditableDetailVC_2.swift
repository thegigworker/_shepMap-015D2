//
//  EditTableViewController.swift
//
//  Created by Duc Tran on 3/30/15.
//  Copyright (c) 2015 Duc Tran. All rights reserved.
//

import UIKit

class shepEditableDetailVC_2: UITableViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // Model:
    var shepProductDetail: ShepSingleXYZ?
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UITextField!
    @IBOutlet weak var productDescriptionTextView: UITextView!
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
    @IBOutlet weak var lblJobType: UILabel!
    @IBOutlet weak var lblFoodType: UILabel!
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail View"
        myImage1.image = shepProductDetail?.image
        myImage2.image = shepProductDetail?.image
        myImage3.image = shepProductDetail?.image
        myImage4.image = shepProductDetail?.image
        myImage5.image = shepProductDetail?.image
        myImage6.image = shepProductDetail?.image
        lblPay2.text = "Dollars: \(shepCurrencyFromDouble(shepNumber : (shepProductDetail?.dollar)!))"
        lblDistance.text = "\(String(describing: shepProductDetail!.distance)) miles"
        lblJobType.text = shepProductDetail?.jobType
        lblFoodType.text = shepProductDetail?.foodType
        //productImageView.image = shepProductDetail?.image
        lbTitle.text = shepProductDetail?.title
        productTitleLabel.text = shepProductDetail?.title
        productDescriptionTextView.text = shepProductDetail?.description
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
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // dismiss the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - UIScrollViewDelegate (is a subclass of UITableViewController)
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // resigns keyboard whenever view scrolls
        productDescriptionTextView.resignFirstResponder()
    }
    
    // MARK: - Table View Interaction
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 0 && indexPath.row == 0 {
            return indexPath
        } else {
            return nil
        }
    }
    
    // MARK: - Image Picker Controller
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0
        {
            let picker = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary  // .Camera
            picker.allowsEditing = false
            picker.delegate = self
            present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        shepProductDetail?.image = image
        productImageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
}






























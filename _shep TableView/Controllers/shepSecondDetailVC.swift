//
//  ProductDetailViewController.swift
//
//  Created by Duc Tran on 3/30/15.
//  Copyright (c) 2015 Duc Tran. All rights reserved.
//

import UIKit

class shepSecondDetailVC: UITableViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Model
    var product: ShepSingleXYZ?
    var shepProductDetail: ShepSingleXYZ?

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblDollars: UILabel!
    @IBOutlet weak var productDescriptionTextView: UITextView!
    @IBOutlet weak var lblStreetAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail View"
        
        productImageView.image = product?.image
        
        productImageView.image = shepProductDetail?.image
        lblTitle.text = shepProductDetail?.title
        productDescriptionTextView.text = shepProductDetail?.description
        
    }
    
    
    ///////
    
    // Model:
//    var shepProductDetail: ShepSingleXYZ?
    
//    @IBOutlet weak var productImageView: UIImageView!
//    @IBOutlet weak var productTitleLabel: UITextField!
//    @IBOutlet weak var productDescriptionTextView: UITextView!
    
    // MARK: - VC Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Editable Details"
//        productImageView.image = shepProductDetail?.image
//        productTitleLabel.text = shepProductDetail?.title
//        productDescriptionTextView.text = shepProductDetail?.description
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //shepProductDetail?.title = productTitleLabel.text!
        shepProductDetail?.description = productDescriptionTextView.text
        shepProductDetail?.image = productImageView.image!
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // dismiss the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - UIScrollViewDelegate (is a subclass of UITableViewController)
    override func scrollViewWillBeginDragging(_ scrolcView: UIScrollView) {
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

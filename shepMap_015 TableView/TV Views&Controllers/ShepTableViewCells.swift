//
//  ShepTableViewCell.swift
//
//


import UIKit

//Select Cocoa Touch Class, and click Next.
//In the Class field, type Meal.
//In the “Subclass of” field, select UITableViewCell.
//The class title changes to MealTableViewCell. Xcode makes it clear from the naming that you’re creating a custom table view cell, so leave the new name as is.

//Click Next.
//The save location defaults to your project directory.
//The Group option defaults to your app name, FoodTracker.

//In the Targets section, make sure your app is selected and the tests for your app are unselected.
//Click Create.
//Xcode creates a file that defines the MealTableViewCell class: MealTableViewCell.swift.
//

//////////////////////
//In the Attributes inspector, find the field labeled Interaction and deselect the User Interaction Enabled checkbox.
//You designed your custom rating control class to be interactive, but you don’t want users to be able to change the rating from the cell view. Instead, tapping anywhere in the cell should select the cell. So it’s important to disable that interaction when it’s in this context.
//////////////////////

class shepOrigProductTVCell: UITableViewCell {
    
    @IBOutlet weak var myGigSourceImageView: UIImageView!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    
    func setupCell(_ mySingleAnnotation: fakeShepSingleAnnotation)
    {
        myGigSourceImageView.image = UIImage(named: mySingleAnnotation.switchGigIcon())
        productDescriptionLabel.text = mySingleAnnotation.description
        productTitleLabel.text = mySingleAnnotation.title
    }
}

class ShepTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var CategoryLbl1: UILabel!
    @IBOutlet weak var CategoryLbl2: UILabel!
    // The simplest approach is to add this attribute to the LABEL YOU WANT TO HAVE ROUNDED CORNERS.
    //          layer.cornerRadius
    
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
   // @IBOutlet weak var PayLbl: UILabel!
    @IBOutlet weak var ExpenseLbl: UILabel!
    @IBOutlet weak var EarningLbl: UILabel!
    @IBOutlet weak var DrivingDistanceLbl: UILabel!
    //@IBOutlet weak var DrivingTimeLbl: UILabel!
    //@IBOutlet weak var CrowFliesLbl: UILabel!
    //@IBOutlet weak var ratingControl: RatingControl!
    //@IBOutlet weak var namelabel2: UILabel! // shep test
    
    //MARK: - Functions
    func setupCell(_ myShepSingleAnnotation: fakeShepSingleAnnotation) {
        //photoImageView.image = myShepSingleAnnotation.image
        //PayLbl.text = product.description
        NameLbl.text = myShepSingleAnnotation.title
        photoImageView.image = UIImage(named: myShepSingleAnnotation.switchGigIcon())
        CategoryLbl1.text = myShepSingleAnnotation.myGigSource.rawValue
        CategoryLbl2.text = myShepSingleAnnotation.City
        EarningLbl.text = "Dollars: \(shepCurrencyFromDouble(shepNumber : myShepSingleAnnotation.shepDollarValue))"
        DrivingDistanceLbl.text = String(myShepSingleAnnotation.routeDrivingDistance) + " miles"
       //self.selectionStyle = UITableViewCellSelectionStyle.blue // not working?
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

class HeaderInSectionTVCell: UITableViewCell {

    @IBOutlet weak var lblCategory: UILabel!
    func configureCellWith(labelText: String) // (labelText: String, image: UIImage) etc.
        {
            //productImageView.image = product.image
            lblCategory.text = labelText
        }

//    func setupCell(_ product: shepProduct)
//    {
//        //productImageView.image = product.image
//        lblCategory.text = product.title
//    }

}

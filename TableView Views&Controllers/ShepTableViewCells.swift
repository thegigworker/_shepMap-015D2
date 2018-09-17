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
    
    func setupCell(_ mySingleAnnotation: ShepSingleAnnotation)
    {
        myGigSourceImageView.image = UIImage(named: mySingleAnnotation.switchGigIcon())
        productDescriptionLabel.text = mySingleAnnotation.description
        productTitleLabel.text = mySingleAnnotation.title
    }
}

class ShepTableViewCell: UITableViewCell {
    
    let myDataModel = shepDataModel()
    
    //MARK: Properties
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var UNKNOWN_label2: UILabel!
    // The simplest approach is to add this attribute to the LABEL YOU WANT TO HAVE ROUNDED CORNERS.
    //          layer.cornerRadius
    
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var UNKNOWN_label: UILabel!
    @IBOutlet weak var lblDollars: UILabel!
    @IBOutlet weak var lblCents: UILabel!
    @IBOutlet weak var DriveDistanceLbl: UILabel!
    @IBOutlet weak var lblStreetAddress: UILabel!
    
    //MARK: - Functions
    func setupCell(_ myShepSingleAnnotation: ShepSingleAnnotation) {
        let shepCurrency = myDataModel.shepCurrencyFromDouble(shepNumber : myShepSingleAnnotation.shepDollarValue)
        lblDollars.text = String(shepCurrency.dropLast(3)) // justTheDollars
        lblCents.text = String(shepCurrency.suffix(2)) // justTheCents
        DriveDistanceLbl.text = String(format: "%.02f", myShepSingleAnnotation.routeDrivingDistance)
        NameLbl.text = myShepSingleAnnotation.mapItem_Name
        lblCity.text = myShepSingleAnnotation.City! + ", " + myShepSingleAnnotation.ZipCode!
        lblStreetAddress.text = myShepSingleAnnotation.StreetAddressLine! + ","
        UNKNOWN_label2.text = "who knows what?"
        UNKNOWN_label.text = "more fields here"
        photoImageView.image = UIImage(named: myShepSingleAnnotation.switchGigIcon())
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


/*  STRING MANIPULATION BY SEARCHING FOR SPACES
For example, to retrieve the first word of a longer string, you can search for a space and then create a substring from a prefix of the string up to that point:

let name = "Marie Curie"
let firstSpace = name.index(of: " ") ?? name.endIndex
let firstName = name[..<firstSpace]
// firstName == "Marie"
*/


/* STRING FUNCTIONS
 
 func drop(while: (Character) -> Bool)
    Returns a subsequence by skipping elements while predicate returns true and returning the remaining elements.

 func dropFirst(_ k: Int) -> Substring
    Returns a subsequence containing all but the given number of initial elements.
         let numbers = [1, 2, 3, 4, 5]
         print(numbers.dropFirst(2))
         // Prints "[3, 4, 5]"
         print(numbers.dropFirst(10))
         // Prints "[]"
 
 func dropLast(_ k: Int) -> Substring
    Returns a subsequence containing all but the specified number of final elements.
         let numbers = [1, 2, 3, 4, 5]
         print(numbers.dropLast(2))
         // Prints "[1, 2, 3]"
         print(numbers.dropLast(10))
         // Prints "[]"
 
 STRING SUFFIX FUNCTION
 let last4 = a.suffix(4)
        The type of the result is a new type Substring which behaves as a String in many cases. However if the substring is supposed to leave the scope where it's created in
            you have to create a new String instance.
 let last4 = String(a.suffix(4))
 
*/

//
//  sectionHeaderTVCell.swift



/*
 NOTE RE THIS SYSTEM ERROR:  this class is not key value coding-compliant for the key XXX.'
 Another common cause if you are using Storyboard, your UIButton might have more then one assignings, a wrong Outlet or Action or an extra one.
 Open your storyboard and right click the XXX
 You will see that there is more than one assign/ref to this XXX. Remove one of the "Main..." greyed windows with the small "x":
 */


import UIKit

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

class ShepTableViewCell2: UITableViewCell {
    
    //    The most simplest approach is to add this attribute to the LABEL YOU WANT TO HAVE ROUNDED CORNERS.
    //             layer.cornerRadius
    
    //MARK: Properties
    @IBOutlet weak var CategoryLbl: UILabel!
    //    The most simplest approach is to add this attribute to the LABEL YOU WANT TO HAVE ROUNDED CORNERS.
    //             layer.cornerRadius
    
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var PayLbl: UILabel!
    @IBOutlet weak var ExpenseLbl: UILabel!
    @IBOutlet weak var EarningLbl: UILabel!
    @IBOutlet weak var DrivingDistanceLbl: UILabel!
    //@IBOutlet weak var DrivingTimeLbl: UILabel!
    //@IBOutlet weak var CrowFliesLbl: UILabel!
    //@IBOutlet weak var ratingControl: RatingControl!
    //@IBOutlet weak var namelabel2: UILabel! // shep test
    
    //func configureCellWith(_ product: ShepSingleXYZ) {
     func setupCell(_ product: ShepSingleXYZ) {
        photoImageView.image = product.image
        PayLbl.text = product.description
        NameLbl.text = product.title
        EarningLbl.text = String(product.dollar)
        DrivingDistanceLbl.text = String(product.distance)
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


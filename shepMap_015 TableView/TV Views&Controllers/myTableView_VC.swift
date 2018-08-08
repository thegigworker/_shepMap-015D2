//
// myTableViewController.swift
//
//  Thanks to by Duc Tran
//

import UIKit

/* To display dynamic data, a table view needs two important helpers: a data source and a delegate. A table view data source, as implied by its name, supplies the table view with the data it needs to display. A table view delegate helps the table view manage cell selection, row heights, and other aspects related to displaying the data. By default, UITableViewController and its subclasses adopt the necessary protocols to make the table view controller both a data source (UITableViewDataSource protocol) and a delegate (UITableViewDelegate protocol) for its associated table view. Your job is to implement the appropriate protocol methods in your table view controller subclass so that your table view has the correct behavior.
 
 // A functioning table view requires three table view data source methods.
 func numberOfSections(in tableView: UITableView) -> Int
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
 */


//    //// THIS STUFF IS CODE FROM ANOTHER DEMO RE INITIALIZING FOR A TABLEVIEWS
//    //    init?(name: String, photo: UIImage?, rating: Int) {
//    //        //Failable initializers always start with either init? or init!. These initializers return optional values or implicitly unwrapped optional values, respectively. Optionals can either contain a valid value or nil. You must check to see if the optional has a value, and then safely unwrap the value before you can use it. Implicitly unwrapped optionals are optionals, but the system implicitly unwraps them for you.
//    //        //In this case, your initializer returns an optional Meal? object.
//    //
//    //        /* EXPLORE FURTHER
//    //         As you will see in later lessons, failable initializers are harder to use because you need to unwrap the returned optional before using it. Some developers prefer to enforce an initializer’s contract using assert() or precondition() methods. These methods cause the app to terminate if the condition they are testing fails. This means that the calling code must validate the inputs before calling the initializer.
//    //         For more information on initializers, see Initialization. For information on adding inline sanity checks and preconditions to your code, see assert(_:_:file:line:) and precondition(_:_:file:line:).
//    //         */
//    //        // The name must not be empty
//    //        guard !name.isEmpty else {
//    //            return nil
//    //        }
//    //        // The rating must be between 0 and 5 inclusively
//    //        guard (rating >= 0) && (rating <= 5) else {
//    //            return nil
//    //        }
//    //// THIS STUFF IS CODE FROM ANOTHER DEMO RE INITIALIZING FOR A TABLEVIEWS


////////////////////
//The final step to displaying data in the user interface is to connect the code defined in shepProductsTVController.swift to the Shep TableView Scene.
//In the Identity inspector, find the field labeled Class, and select shepProductsTVController.
///////////////////

class myTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    //MARK: Properties
    
    lazy var BigKahunaSectionedArray: [allSectionsOfData4TVC_NEW] = {
        print("I think I'm changing BigKahunaSectionedArray")
        // Line above declares as an array of sectionOfProducts_class
        // then in line below, populates this array by using allSectionsOfData4TVC_class.getAllTheSections method
        return allSectionsOfData4TVC_NEW.handleAllTheSections(whichSort: mySort.rawValue)
        //case "distance" : // SINGLE SECTION 1
        //case "title" : // SINGLE SECTION 2
        //case "dollars" : // SINGLE SECTION 3
        //case "jobType" :   // CATEGORY !
        //case "foodType" :   // CATEGORY 2
    }()
    
    // This code declares a property on ShepTableViewController and initializes it with a default value (an empty array of ShepSingleItem objects)
    // var meals = [Meal]()
    //var ShepItems = [ShepTempSingleItem]()
    
    
    // MARK: - Table view DATASOURCE methods
    
    /*
     The DATASOURCE method  tableView(_:cellForRowAt:)  configures and provides a cell to display for a given row. Each row in a table view has one cell, and that cell determines the content that appears in that row and how that content is laid out.
     For table views with a small number of rows, all rows may be onscreen at once, so this method gets called for each row in your table. But table views with a large number of rows display only a small fraction of their total items at a given time. It’s most efficient for table views to ask for only the cells for rows that are being displayed, and that’s what tableView(_:cellForRowAt:) allows the table view to do.
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Because you created a custom cell class that you want to use, downcast the type of the cell to your custom cell subclass, shepOrigProductTVCell.
        //let cell = tableView.dequeueReusableCell(withIdentifier: "shepOrigProductTVCell", for: indexPath) as! shepOrigProductTVCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShepTableViewCell", for: indexPath) as! ShepTableViewCell
        let mySectionOfData = BigKahunaSectionedArray[indexPath.section]
        let mySingleAnnotationData = mySectionOfData.oneSectionOfData[indexPath.row]
        print("DATASOURCE CALLED cellForRowAt indexPath w indexPath \(indexPath)")
        // print("cellForRowAt w sort \(whichSort)")
        print("cellForRowAt indexPath w SECTION NAME \(mySectionOfData.sectionName)")
        print("mySingleAnnotationData = \(String(describing: mySingleAnnotationData.title))       \(mySingleAnnotationData.myGigSource)")
        print("distance = \(mySingleAnnotationData.routeDrivingDistance)     PAY = \(mySingleAnnotationData.shepDollarValue) \n")
        cell.setupCell(mySingleAnnotationData)
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let temp = BigKahunaSectionedArray.count
        print("DATASOURCE CALLED numberOfSections: BigKahunaSectionedArray.count is \(temp) \n")
        return BigKahunaSectionedArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let mySectionOfData = BigKahunaSectionedArray[section]
        let temp = mySectionOfData
        print("DATASOURCE CALLED numberOfRowsInSection  oneSectionOfData.count is \(mySectionOfData.oneSectionOfData.count)")
        //print("numberOfRowsInSection of BigKahunaSectionedArray w sort \(whichSort)")
        print("numberOfRowsInSection of BigKahunaSectionedArray w SECTION NAME \(temp.sectionName)")
        print("numberOfRowsInSection of BigKahunaSectionedArray w SECTION ??? \(section) \n")
        return mySectionOfData.oneSectionOfData.count   // the number of products in the section
        //productLine.oneSectionOfData
    }
    
    // Override to support EDITING the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            var mySectionOfData = BigKahunaSectionedArray[indexPath.section]
            mySectionOfData.oneSectionOfData.remove(at: indexPath.row)
            
            //            // tell the table view to update with new data source
            //            // tableView.reloadData()    Bad way!
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            //            // Note that there are many other types of UITableViewRowAnimation possible
            
            // DANGER, DANGER WILL ROBINSON  ////
            /*
             2018-04-25 14:35:09.041858-0400 shepProductName[18221:4466219] *** Assertion failure in -[UITableView _endCellAnimationsWithContext:], /BuildRoot/Library/Caches/com.apple.xbs/Sources/UIKit_Sim/UIKit-3698.52.10/UITableView.m:2012
             2018-04-25 14:35:09.047566-0400 shepProductName[18221:4466219] *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Invalid update: invalid number of rows in section 1.  The number of rows contained in an existing section after the update (4) must be equal to the number of rows contained in that section before the update (4), plus or minus the number of rows inserted or deleted from that section (0 inserted, 1 deleted) and plus or minus the number of rows moved into or out of that section (0 moved in, 0 moved out).'
             *** First throw call stack:
             */
            
            /*
             //             if editingStyle == .delete {
             //             // Delete the row from the data source
             //             tableView.deleteRows(at: [indexPath], with: .fade)
             //             } else if editingStyle == .insert {
             //             // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
             //             }
             */
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let productToMove = BigKahunaSectionedArray[sourceIndexPath.section].oneSectionOfData[sourceIndexPath.row]
        
        // move productToMove to destinationIndexPath
        BigKahunaSectionedArray[destinationIndexPath.section].oneSectionOfData.insert(productToMove, at: destinationIndexPath.row)
        
        // delete the productToMove from sourceIndexPath
        BigKahunaSectionedArray[sourceIndexPath.section].oneSectionOfData.remove(at: sourceIndexPath.row)
    }
    
    
    // MARK: - TableView Delegate Methods
    
    /*
     optional func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
     // Instance Method. Tells the delegate that the specified row is now selected.
     Parameters
     tableView --A table-view object informing the delegate about the new row selection.
     indexPath --An index path locating the new selected row in tableView.
     The delegate handles selections in this method. One of the things it can do is exclusively assign the check-mark image (checkmark) to one row in a section (radio-list style).
     This method isn’t called when the isEditing property of the table is set to true (that is, the table view is in editing mode).
     See "Managing Selections" in Table View Programming Guide for iOS for further information (and code examples) related to this method.
     SHEP'S NOTE: Good place to put performSegue(withIdentifier code
     */
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("DELEGATE CALLED  willDisplay cell, forRowAt indexPath: \(indexPath)")
        let view = cell.contentView
        view.layer.opacity = 0.4
        print ("TRiGGERING ANIMATION")
        view.layer.transform = myTableViewController.cellLoadTransform(cell.layer)
        UIView.animate(withDuration: 0.5, animations: {
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 1
        })
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print("DELEGATE CALLED tableView(_ tableView: UITableView, viewForHeaderInSection   \(section)")
        // CREATE HEADER CELL VIA STORYBOARD PROTOTYPE CELL & CUSTOM UITableViewCell CLASS
        let headerInSectionCell = tableView.dequeueReusableCell(withIdentifier: "HeaderInSectionTVCell") as! HeaderInSectionTVCell
        // let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTVCell \(section)") as! headerTVCell
        // // Can add section number to cell identifier name in order to differentiate between a series of different section header cells
        // // such as HeaderTVCell0, HeaderTVCell1, HeaderTVCell2, etc.
        
        // WAY TO SET PROPERTIES RIGHT HERE: headerCell.lblCategory.text =  BigKahunaSectionedArray[section].sectionName
        let labelText = BigKahunaSectionedArray[section].sectionName    // sectionTitles[section]
        headerInSectionCell.configureCellWith(labelText: "---   " + labelText + "   ---") // (labelText: String, image: UIImage) etc.
        return headerInSectionCell
        
        // CREATE HEADER CELL VIA CODE
        //let view = UIView()
        //view.backgroundColor = UIColor.orange
        // let image = UIImageView(image: sectionImages[section])  // BigKahunaSectionedArray[section].sectionImages
        // image.frame = CGRect(x: , y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        // view.addSubview(image)
        // let label = UILabel()
        // label.text = BigKahunaSectionedArray[section].sectionName  // sectionTitles[section]
        // label.frame = CGRect(x: 40, y: 5, width: 150, height: 25)
        //view.addSubview(label)
        //return view
    }
    
    // don't even need this function at all if using viewForHeaderInSection
    //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        let productLine = BigKahunaSectionedArray[section]
    //        return productLine.sectionName
    //    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            print ("You selected the RED DELETE button for cell indexPath \(indexPath)")
        }
        
        let blueButtonItem = UITableViewRowAction(style: .normal, title: "Button") { (action, indexPath) in
            // share item at indexPath
            print ("You selected the BLUE Button_2 for cell indexPath \(indexPath)")
        }
        blueButtonItem.backgroundColor = UIColor.blue
        
        let greyButtonItem = UITableViewRowAction(style: .normal, title: "...") { (action, indexPath) in
            // share item at indexPath
            print ("You selected the GREY Button_1 for cell indexPath \(indexPath)")
        }
        greyButtonItem.backgroundColor = UIColor.darkGray
        
        return [delete, blueButtonItem, greyButtonItem]
    }
    
    
    // MARK: - Navigation / Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        // The UIViewController class’s implementation doesn’t do anything, but it’s a good habit to always call super.prepare(for:sender:) whenever you override prepare(for:sender:). That way you won’t forget it when you subclass a different class.
        
        let controller = segue.destination
        if let sortByPopOver = controller.popoverPresentationController{
            sortByPopOver.delegate = self
        }
        
        if let identifier = segue.identifier {
            switch identifier {
                // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
//            case "Second Detail View":
//                let productDetailVC = segue.destination as! shepSecondDetailVC
//                if let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell) {
//                    productDetailVC.product = productAtIndexPath(indexPath)
//                }
            case "Show Editable Detail":
                let editTableVC = segue.destination as! shepEditableDetailVC
                if let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell) {
                    editTableVC.mySingleAnnotation = theAnnotationAtIndexPath(indexPath)
                }
                
            default: break
            }
        }
    }
    
    
    //MARK: - popoverPresentationController functions
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        let controller = segue.destination
    //        if let xsearchRadiusPopOver = controller.popoverPresentationController{
    //            //nv.delegate = self
    //            xsearchRadiusPopOver.delegate = self
    //        }
    //    }
    
    //    internal func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    //        return .none
    //    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        print ("\n")
        print ("SORT BY MENU DISMISSED. \n" + "You chose: \(mySort)")
        redrawTableView()
        
        //        BigKahunaSectionedArray = allSectionsOfData4TVC.handleAllTheSections(whichSort: whichSort)
        //        tableView.reloadData()  // Reloads everything from scratch. Redisplays visible rows. Note that this will cause any existing drop placeholder rows to be removed.
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    
    // MARK: - Helper Methods
    
    func redrawTableView() {
        BigKahunaSectionedArray = allSectionsOfData4TVC_NEW.handleAllTheSections(whichSort: mySort.rawValue)
        print("I'm in redrawTableView w sort \(mySort)")
        self.tableView.reloadData()  // Reloads everything from scratch. Redisplays visible rows. Note that this will cause any existing drop placeholder rows to be removed.
        /*
         The UITableView's reloadData() method is explicitly a force reload of the entire tableView. It works well, but is usually jarring and a bad user experience if you're going to do that with a tableview that the user is currently looking at.
         
         Instead, take a look at reloadRowsAtIndexPaths(_:withRowAnimation:) and
         reloadSections(_:withRowAnimation:) in the documentation.
         */
    }
    
    func theAnnotationAtIndexPath(_ indexPath: IndexPath) -> fakeShepSingleAnnotation {
        print("productAtIndexPath w indexPath \(indexPath)")
        let myAnnotationsSection = BigKahunaSectionedArray[indexPath.section]
        return myAnnotationsSection.oneSectionOfData[indexPath.row]
    }
   
////    transformDropdown
    private static let cellLoadTransform = { (layer: CALayer) -> CATransform3D in
        print ("performing transformFlip CATransform3DRotate \n" )
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0.0, -40.0, 0.0)
        transform = CATransform3DRotate(transform, -CGFloat(Double.pi)/2.0, 1.0, 0.0, 0.0)
        transform = CATransform3DTranslate(transform, 0.0, layer.bounds.size.height/2.0, 0.0)
        return transform
    }
    
////    transformCurl
//         private static let cellLoadTransform = { (layer: CALayer) -> CATransform3D in
//        var transform = CATransform3DIdentity
//        //transform.m34 = 1.0 / -500 // orig setting
//        transform.m34 = -1.0 / 1500
//        transform = CATransform3DTranslate(transform, -layer.bounds.size.width/2.0, 0.0, 0.0)
//        transform = CATransform3DRotate(transform, CGFloat(Double.pi)/2.0, 0.0, 1.0, 0.0)
//        transform = CATransform3DTranslate(transform, layer.bounds.size.width/2.0, 0.0, 0.0)
//        print ("performing transformCurl CATransform3DRotate \n" )
//        return transform
//    }

////   transformHelix
 //       private static let cellLoadTransform = { (layer: CALayer) -> CATransform3D in
//        var transform = CATransform3DIdentity
//        transform = CATransform3DTranslate(transform, 0.0, layer.bounds.size.height/2.0, 0.0)
//        transform = CATransform3DRotate(transform, CGFloat(Double.pi), 0.0, 1.0, 0.0)
//        transform = CATransform3DTranslate(transform, 0.0, -layer.bounds.size.height/2.0, 0.0)
//        print ("performing transformHelix CATransform3DRotate \n" )
//        return transform
//    }
   
    // MARK: - VC Lifecycle
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this one line of code automatically provides all kinds of UI Edit functionality.
        // editButtonItem only available w UITableViewController
        // actual edit funtionality in func:  commit editingStyle: UITableViewCellEditingStyle
        navigationItem.rightBarButtonItem = editButtonItem
        
        //        // Make the row height dynamic
        //        tableView.estimatedRowHeight = tableView.rowHeight
        //        //tableView.estimatedRowHeight = 185.0
        //        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentSize.height = 150
        
        navigationItem.title = "Shep's TableView"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
        // --------------------------------------------------------------------------
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //The template implementation of this method includes comments that were inserted by Xcode when it created MealTableViewController.swift. Code comments like this provide helpful hints and contextual information in source code files, but you don’t need them for this lesson.
        // --------------------------------------------------------------------------
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //tableView.reloadData()  // Reloads everything from scratch. Redisplays visible rows. Note that this will cause any existing drop placeholder rows to be removed.
    }
}


//  private func loadSampleMeals() {

//        let photo1 = UIImage(named: "meal1")
//        let photo2 = UIImage(named: "meal2")
//        let photo3 = UIImage(named: "meal3")

//  Because the Meal class’s init!(name:, photo:, rating:) initializer is failable, you need to check the result returned by the initializer. In this case, you are passing valid parameters, so the initializer should never fail. If the initializer does fail, you have a bug in your code. To help you identify and fix any bugs, if the initializer does fail, the fatalError() function prints the error message to the console and the app terminates.

//        guard let meal1 = ShepTempSingleItem(name: "Caprese Salad", photo: photo1, rating: 4) else {
//            fatalError("Unable to instantiate meal1")
//        }
//
//        guard let meal2 = ShepTempSingleItem(name: "Chicken and Potatoes", photo: photo2, rating: 5) else {
//            fatalError("Unable to instantiate meal2")
//        }
//
//        guard let meal3 = ShepTempSingleItem(name: "Pasta with Meatballs", photo: photo3, rating: 3) else {
//            fatalError("Unable to instantiate meal2")
//        }
//
//        // note the way that this array gets built below
//        ShepItems += [meal1, meal2, meal3]
//  }


//    //THIS IS A PLACEHOLDER FOR AN ALTERNATIVE cellForRowAt indexPath
//    //WITH COMMENTS AND AN INTERESTING GUARD STATEMENT
//    func xtableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        //override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        // Table view cells are reused and should be dequeued using a cell identifier.
//        // To make this code work for your app, you’ll need to change the identifier to the prototype cell identifier you set in the storyboard (MealTableViewCell), and then add code to configure the cell.
//
//        let cellIdentifier = "shepOrigProductTVCell"
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? shepOrigProductTVCell  else {
//            fatalError("The dequeued cell is not an instance of shepOrigProductTVCell.")
//        }
//        /* There’s a lot going on in this code:
//         The as? shepOrigProductTVCell expression attempts to downcast the returned object from the UITableViewCell class to your shepOrigProductTVCell class. This returns an optional.
//         The guard let expression safely unwraps the optional.
//         If your storyboard is set up correctly, and the cellIdentifier matches the identifier from your storyboard, then the downcast should never fail. If the downcast does fail, the fatalError() function prints an error message to the console and terminates the app.
//         */
//
//        return cell
//    }




































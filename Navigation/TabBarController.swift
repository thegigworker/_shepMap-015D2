//
//  MainTabController.swift
//  tabcontroller_tutorial
//

import Foundation
import UIKit

class MainTabController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: UNWIND SEGUE
//
//  The next step in creating the unwind segue is to add an action method to the destination view controller (the view controller that the segue is going to). This method must be marked with the IBAction attribute and take a segue (UIStoryboardSegue) as a parameter. Because you want to unwind back to the meal list scene, you need to add an action method with this format to MealTableViewController.swift.
//  In this method, you’ll write the logic to add the new meal (that’s passed from MealViewController, the source view controller) to the meal list data and add a new row to the table view in the meal list scene.

/* Now, when users tap the Save button, they navigate back to the meal list scene, during which process the unwindToMealList(sender:) action method is called.
 EXPLORE FURTHER
 Unwind segues provide a simple method for passing information back to an earlier view controller. Sometimes, however, you need more complex communication between your view controllers. In those cases, consider using the DELEGATE pattern.  See Delegation in The Swift Programming Language (Swift 4.0.3).
 */

//    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
//
////            There’s a lot happening in the condition for this if statement.
////            This code uses the optional type cast operator (as?) to try to downcast the segue’s source view controller to a MealViewController instance. You need to downcast because sender.sourceViewController is of type UIViewController, but you need to work with a MealViewController.
////            The operator returns an optional value, which will be nil if the downcast wasn’t possible. If the downcast succeeds, the code assigns the MealViewController instance to the local constant sourceViewController, and checks to see if the meal property on sourceViewController is nil. If the meal property is non-nil, the code assigns the value of that property to the local constant meal and executes the if statement.
////            If either the downcast fails or the meal property on sourceViewController is nil, the condition evaluates to false and the if statement doesn’t get executed.
//
//        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
//
//            // Add a new meal.
//            let newIndexPath = IndexPath(row: ShepItems.count, section: 0)
//           // This code computes the location in the table view where the new table view cell representing the new meal will be inserted, and stores it in a local constant called newIndexPath.
//
//           // meals.append(meal)
//           // ShepItems.append(meal) // THIS LINE NEEDS TO BE FIXED, ShepItems can't work with "meals"
//
//            tableView.insertRows(at: [newIndexPath], with: .automatic)
//            // This animates the addition of a new row to the table view for the cell that contains information about the new meal. The .automatic animation option uses the best animation based on the table’s current state, and the insertion point’s location.
//        }
//    }

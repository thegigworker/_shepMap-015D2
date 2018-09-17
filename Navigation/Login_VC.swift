//
//  LoginViewController.swift
//
///

import Foundation
import UIKit


class LoginViewController : UIViewController {
    override func viewDidLoad() {
        //print ("LoginViewController viewDidLoad")
        super.viewDidLoad()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//       print ("LoginViewController ViewWillAppear \n")
//    }
    
    @IBAction func loginTapped(_ sender: Any) {
       
        let mainTabController = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
        mainTabController.selectedViewController = mainTabController.viewControllers?[0]
        present(mainTabController, animated: true, completion: nil)
    
    }
}

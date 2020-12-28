//
//  NavigationViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/26/20.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    @IBOutlet weak var nav_bar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nav_bar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.TEXT()]
        nav_bar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.TEXT()]
        nav_bar.barTintColor = Constants.BACKGROUND()
        nav_bar.tintColor = Constants.TINT()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

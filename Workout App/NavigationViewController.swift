//
//  NavigationViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/26/20.
//

import UIKit

class NavigationViewController: UINavigationController {

    var BACKGROUND : UIColor = UIColor.white
    var TEXT : UIColor = UIColor.white
    var SECTION : UIColor = UIColor.white
    var CELL_0 : UIColor = UIColor.white
    var CELL_1 : UIColor = UIColor.white
    
    @IBOutlet weak var nav_bar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BACKGROUND = Constants.DARK_BACKGROUND
        TEXT = Constants.DARK_TEXT
        SECTION = Constants.DARK_SECTION
        CELL_0 = Constants.DARK_CELL_0
        CELL_1 = Constants.DARK_CELL_1
        
        nav_bar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: TEXT]
        nav_bar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: TEXT]
        nav_bar.backgroundColor = BACKGROUND
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

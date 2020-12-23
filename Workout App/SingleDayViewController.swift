//
//  SingleDayViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/23/20.
//

import UIKit

class SingleDayViewController: UIViewController {
    
    var day : Day?
    var exercises = [Exercise]()
    
    @IBOutlet weak var day_name_label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("loaded")
        day_name_label.text = day?.get_day_str()
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

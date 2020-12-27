//
//  ProgressViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/22/20.
//

import UIKit
import Charts

class ProgressViewController: UIViewController, ChartViewDelegate{
    
    var cycles = [Cycle]()
    var routine_delegate : RoutinesTableViewControllerDelegate?
    var progress_charts =  [LineChartView]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.BACKGROUND()
        
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

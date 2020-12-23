//
//  TabViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/22/20.
//

import UIKit

class TabViewController: UITabBarController, UITabBarControllerDelegate {

    var routine_delegate : RoutinesTableViewControllerDelegate?
    var cycles = [Cycle]()
    @IBOutlet weak var nav_bar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.delegate = self
        if let previous = routine_delegate as? RoutinesTableViewController{
            nav_bar.title = previous.stored_cell?.name
            cycles = previous.stored_cell?.cycles ?? [Cycle]()
        }
        
        for vc in viewControllers ?? [UIViewController]() {
            
            if let current = vc as? CyclesViewController{
                current.cycles = cycles
            }
            
            if let current = vc as? ProgressViewController{
                current.cycles = cycles
            }
        }
    }
    
    /*
     called every time the views of this tab controller is switched
     we will set the values of the sub view controllers so that they can be initialized correctly
     */
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        /*
        //if clicked on the cyclesView Controller
        if let destination = viewController as? CyclesViewController {
            print("cycles")
            //destination.cycles = cycles
        }
        //if clicked on the progress view controller
        if let destination = viewController as? ProgressViewController{
            print("progress")
            //destination.cycles = cycles
        }*/
        
    }
    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? CyclesViewController {
            destination.cycles = self.routine?.cycles ?? [Cycle]()
        }
    }
    */

}

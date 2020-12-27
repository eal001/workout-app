//
//  TabViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/22/20.
//

import UIKit

class TabViewController: UITabBarController, UITabBarControllerDelegate {

    var routine_delegate : RoutinesTableViewControllerDelegate?
    @IBOutlet weak var nav_bar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.delegate = self
        routine_delegate?.save_routines()
        
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = Constants.BACKGROUND()
        
        var cycles = [Cycle]()
        if let previous = routine_delegate as? RoutinesTableViewController{
            nav_bar.title = previous.stored_cell?.name
            cycles = previous.stored_cell?.cycles ?? [Cycle]()
        }
        
        for vc in viewControllers ?? [UIViewController]() {
            
            if let current = vc as? CyclesViewController{
                current.routine_delegate = self.routine_delegate
                current.cycles = cycles
                current.nav_title = nav_bar.title ?? ""
            }
            
            if let current = vc as? ProgressViewController{
                current.cycles = cycles
                current.routine_delegate = self.routine_delegate
            }
        }
    }
    
    /*
     use the plus button in this view's navigation bar to create a new cycle
     we will also need to save this cycle to the first vc'c routines, and save to user defaults
     */
    @IBAction func create_new_cycle(_ sender: Any) {
        
        if let current = selectedViewController as? CyclesViewController{
            
            if current.cycles.count <= 0 {
                current.cycles.insert(current.hidden_base_cycle!.compute_next(), at: 0)
                current.hidden_base_cycle = nil
            } else {
                current.cycles.insert(current.cycles[0].compute_next(), at: 0)
            }
            current.cycles_table.reloadData()
            
            if let first_vc = routine_delegate as? RoutinesTableViewController {
                let i = first_vc.routines.firstIndex(of: first_vc.stored_cell!)
                first_vc.routines[i ?? 0].cycles = current.cycles
            }
            
        }
        
        routine_delegate?.save_routines()
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
       
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        routine_delegate?.save_routines()
    }
    

}

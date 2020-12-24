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
        routine_delegate?.save_routines()
        if let previous = routine_delegate as? RoutinesTableViewController{
            nav_bar.title = previous.stored_cell?.name
            cycles = previous.stored_cell?.cycles ?? [Cycle]()
        }
        
        for vc in viewControllers ?? [UIViewController]() {
            
            if let current = vc as? CyclesViewController{
                current.cycles = cycles
                current.nav_title = nav_bar.title ?? ""
            }
            
            if let current = vc as? ProgressViewController{
                current.cycles = cycles
            }
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        routine_delegate?.save_routines()
    }
    

}

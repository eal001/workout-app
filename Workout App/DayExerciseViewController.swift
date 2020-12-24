//
//  DayExerciseViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/23/20.
//

import UIKit

class DayExerciseViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var day_views = [SingleDayViewController]()
    var days = [Day]()
    var cycles_delegate : CyclesViewControllerDelegate?
    var routine_delegate : RoutinesTableViewControllerDelegate?
    
    @IBOutlet weak var nav_bar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        if let previous = cycles_delegate as? CyclesViewController {
            self.days = previous.stored_cell?.days ?? [Day]()
        }
        
        for day in days {
            //can edit the values for day here
            if let day_vc = create_day_vcs(id: "certain_day") as? SingleDayViewController {
                //can initialize the values for the day vc here
                day_vc.day = day
                day_vc.exercises = day.exercises
                day_vc.routine_delegate = self.routine_delegate
                day_views.append(day_vc)
            }
        
        }
        
        
        if let first_vc = day_views.first {
            setViewControllers([first_vc] as [SingleDayViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func create_day_vcs( id : String ) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: id) as! SingleDayViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = day_views.firstIndex(of: viewController as! SingleDayViewController) else {
            return nil
        }
    
        guard index - 1 >= 0 else {
            return day_views.last
        }
        
        guard day_views.count >= index - 1 else {
            return nil
        }
        
        return day_views[index - 1]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = day_views.firstIndex(of: viewController as! SingleDayViewController) else {
            return nil
        }
    
        guard index + 1 != day_views.count else {
            return day_views.first
        }
        
        guard day_views.count > index + 1 else {
            return nil
        }
        
        return day_views[index + 1]
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

//
//  SetViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/23/20.
//

import UIKit

class SetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SetViewControllerDelegate {
    
    var exercise : Exercise?
    var sets = [Single_Set]()
    var day_delegate : SingleDayViewControllerDelegate?
    var routine_delegate : RoutinesTableViewControllerDelegate?
    
    @IBOutlet weak var max_label: UILabel!
    @IBOutlet weak var set_table: UITableView!
    @IBOutlet weak var exercise_name_label: UILabel!
    @IBOutlet weak var info_segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        set_table.dataSource = self
        set_table.delegate = self
        
        info_segment.selectedSegmentIndex = 0
    }
    
    /*
     use this function to initialize self in another class, workaround because the on select method for tableview
     executes after the view did load does
     @param exercise, sets, name
     */
    func initialize(exercise: Exercise, sets: [Single_Set], name: String){
        self.exercise = exercise
        self.sets = sets
        self.exercise_name_label.text = name
        max_label.text = "\(self.exercise!.max_weight.weight) Kgs"
        set_table.reloadData()
    }
    
    /*
     the number of sections in the tableview
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /*
     the title of the section(s)
     */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Sets"
    }
    
    /*
     the amount of elements in each section
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sets.count
    }
    
    /*
     what does each element look like
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "set_cell", for: indexPath) as! SingleSetCell
        cell.set_label?.text = "Set \(indexPath.row + 1)"
        cell.rep_field?.text = String(sets[indexPath.row].reps)
        cell.weight_field?.text = String(sets[indexPath.row].weight)
        if(sets[indexPath.row].is_complete){
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    /*
     implement select and deselect fuctionality and visuals
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(sets[indexPath.row].is_complete){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            sets[indexPath.row].not_complete()
        } else {
            sets[indexPath.row].complete()
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        exercise?.compute_maxes()
        routine_delegate?.save_routines()
    }
    
    /*
     for the segmented view, when it is switched we will update the label
     */
    @IBAction func changed_val(_ sender: Any) {
        if info_segment.selectedSegmentIndex == 0{
            max_label.text = "\(exercise!.max_weight.weight) Kgs"
        } else if info_segment.selectedSegmentIndex == 1 {
            max_label.text = "\(exercise!.max_reps.reps) Reps"
        } else {
            let vol = exercise!.max_volume.weight * Double(exercise!.max_volume.reps)
            max_label.text = "\(vol) Kgs x Reps"
        }
    }
    
    
    // MARK: - Navigation
    
    /*
     we want to send some information back to the previous view once this one is dismissed
     */
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParent{
            day_delegate?.update_sets(sets: sets)
        }
    }
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol SetViewControllerDelegate {
    func initialize(exercise: Exercise, sets: [Single_Set], name: String)
}

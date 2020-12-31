//
//  SingleDayViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/23/20.
//

import UIKit

class SingleDayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SingleDayViewControllerDelegate {
    
    var day : Day?
    var exercises = [Exercise]()
    var set_delegate : SetViewControllerDelegate?
    var routine_delegate : RoutinesTableViewControllerDelegate?
    var stored_index = 0
    
    @IBOutlet weak var day_name_label: UILabel!
    @IBOutlet weak var exercise_table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exercise_table.rowHeight = Constants.STD_ROW_HEIGHT
        exercise_table.backgroundColor = Constants.BACKGROUND()
        self.view.backgroundColor = Constants.BACKGROUND()
        day_name_label.textColor = Constants.TEXT()
        day_name_label.backgroundColor = Constants.SECTION()
        
        exercise_table.delegate = self
        exercise_table.dataSource = self
        day_name_label.text = day?.get_day_str()
        
    }
    
    /*
     this method will be called in a subsequen view controller to update the sets, and be able to store them
     */
    func update_sets(sets : [Single_Set]){
        self.exercises[stored_index].sets = sets
        exercise_table.reloadData()
    }
    
    func reload_table() {
        exercise_table.reloadData()
    }
    
    /*
     the number of sections
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /*
     the title of the section(s)
     */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.EXERCISES
    }

    /*
     the amount of cells in each section
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    /*
     what does each cell look like
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_ID_2, for: indexPath) as! ExerciseCell
        cell.exercise = exercises[indexPath.row]
        cell.name_label.text = exercises[indexPath.row].name
        //cell.reload_progress()
        cell.backgroundColor = Constants.CELL_0()
        return cell
    }
    
    /*
     we will get the cell taht is selected and use it to initialize the next view
     implement on tapped functionality
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        stored_index = indexPath.row
        set_delegate?.initialize(exercise: exercises[indexPath.row], sets: exercises[indexPath.row].sets, name: exercises[indexPath.row].name )
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*
     the color and style of the tableview header
     */
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = Constants.SECTION()
        
        if let sect_header = view as? UITableViewHeaderFooterView {
            sect_header.textLabel?.textColor = Constants.TEXT()
        }
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        self.view.endEditing(true)
        if let destination = segue.destination as? SetViewControllerDelegate{
            set_delegate = destination
        }
        
        if let destination = segue.destination as? SetViewController {
            destination.day_delegate = self
            destination.routine_delegate = routine_delegate
        }
        
    }
    

}

protocol SingleDayViewControllerDelegate {
    func update_sets(sets : [Single_Set])
    func reload_table()
}



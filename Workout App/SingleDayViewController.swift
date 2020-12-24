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
        //print("loaded")
        exercise_table.delegate = self
        exercise_table.dataSource = self
        day_name_label.text = day?.get_day_str()
        
    }
    
    func update_sets(sets : [Single_Set]){
        self.exercises[stored_index].sets = sets
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Exercises"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "proto_cell", for: indexPath)
        cell.textLabel?.text = exercises[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        stored_index = indexPath.row
        set_delegate?.initialize(sets: exercises[indexPath.row].sets, name: exercises[indexPath.row].name )
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? SetViewControllerDelegate{
            set_delegate = destination
        }
        
        if let destination = segue.destination as? SetViewController{
            destination.day_delegate = self
            destination.routine_delegate = routine_delegate
        }
        
    }
    

}

protocol SingleDayViewControllerDelegate {
    func update_sets(sets : [Single_Set])
}



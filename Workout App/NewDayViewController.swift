//
//  NewDayViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/15/20.
//

import UIKit

class NewDayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, NewDayViewControllerDelegate {
    
    var exercises : [Exercise] = [Exercise]()
    var routine_delegate : NewRoutineViewControllerDelegate?
    var stored_cell : Exercise?

    @IBOutlet weak var day_name_field: UITextField!
    @IBOutlet weak var new_exercise_button: UIButton!
    @IBOutlet weak var exercise_table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exercise_table.dataSource = self
        exercise_table.delegate = self
        // Do any additional setup after loading the view.
        
        if let previous = routine_delegate as? NewRoutineViewController {
            self.day_name_field?.text = previous.stored_cell?.name
            self.exercises = previous.stored_cell?.exercises ?? [Exercise]()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        let cell =  tableView.dequeueReusableCell(withIdentifier: "proto_cell", for: indexPath)
        cell.textLabel?.text = exercises[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        stored_cell = exercises[indexPath.row]
    }
    // MARK: - Navigation
    /*
     this function needs to exist, becasue in another function it is going to be used to pass data back
     into this view controller
     */
    func append_exercises(_ exercise: Exercise) {
        if(exercise.name == ""){
            return;
        }
        self.exercises.append(exercise)
        exercise_table.reloadData()
    }
    
    /*
     call this function when this current view controller dissapears
     */
    override func viewWillDisappear(_ animated: Bool) {
        if(self.isMovingFromParent){
            //add only if we didnt come from a cell
            //a clickale cell will never have an emty string as a name
            var will_add = "0"
            if let previous = routine_delegate as? NewRoutineViewController {
                will_add = previous.stored_cell?.name ?? ""
            }
            if(will_add == ""){
                routine_delegate?.append_days( day_name_field?.text ?? "none", exercises )
            } else {
                routine_delegate?.edit_day( day_name_field?.text ?? "none", exercises)
            }
        }
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let destination = segue.destination as? NewExerciseViewController {
            destination.delegate = self
        }
    }
    

}

protocol NewDayViewControllerDelegate {
    func append_exercises(_ exercises : Exercise )
}

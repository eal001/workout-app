//
//  NewExerciseViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/16/20.
//

import UIKit

class NewExerciseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    var delegate : NewDayViewControllerDelegate?
    var sets : [Single_Set] = [Single_Set]()
    
    @IBOutlet weak var type_picker: UIPickerView!
    @IBOutlet weak var set_table: UITableView!
    @IBOutlet weak var add_button: UIButton!
    @IBOutlet weak var name_field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        set_table.dataSource = self
        set_table.delegate = self
        type_picker.dataSource = self
        type_picker.delegate = self        
        // Do any additional setup after loading the view.
        
        if let previous = delegate as? NewDayViewController{
            self.name_field?.text = previous.stored_cell?.name
            self.sets = previous.stored_cell?.sets ?? [Single_Set]()
            set_table.reloadData()
            load_cells()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Sets"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "set_cell") as! SingleSetCell
        cell.set_label.text = "Set \(indexPath.row + 1)"
        cell.weight_field.text = String(sets[indexPath.row].weight)
        cell.rep_field.text = String(sets[indexPath.row].reps)
        return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "Primary"
        case 1:
            return "Secondary"
        case 2:
            return "Compound"
        case 3:
            return "Accessory"
        case 4:
            return "Calisthenic"
        case 5:
            return "Other"
        default:
            return "Other"
        }
    }
    
    @IBAction func add_set(_ sender: Any) {
        var new_set : Single_Set
        if ( sets.count == 0){
            new_set = Single_Set(0,0)
        } else {
            new_set = Single_Set(sets[sets.count - 1])
        }
        sets.append(new_set)
        load_sets()
        set_table.reloadData()
    }
    
    //MARK: Calculations
    
    func compute_exercise() -> Exercise{
        let name = name_field?.text ?? "none"
        let type : ExerciseType
        switch type_picker.selectedRow(inComponent: 0){
        case 0:
            type = ExerciseType.Primary
        case 1:
            type = ExerciseType.Secondary
        case 2:
            type = ExerciseType.Compound
        case 3:
            type = ExerciseType.Accessory
        case 4:
            type = ExerciseType.Calisthenic
        case 5:
            type = ExerciseType.Other
        default:
            type = ExerciseType.Other
        }
        load_sets()
        return Exercise(name, type, sets)
    }
    
    func load_sets(){
        var i = 0
        for cell in set_table.visibleCells as! [SingleSetCell] {
            sets[i].weight = Double(cell.weight_field?.text ?? "0") ?? 0.0
            sets[i].reps = Int(cell.rep_field?.text ?? "0") ?? 0
            i+=1
        }
    }
    
    func load_cells(){
        let cells = set_table.visibleCells as! [SingleSetCell]
        var i = 0
        for set in sets{
            cells[i].weight_field?.text = String(set.weight)
            cells[i].rep_field?.text = String(set.reps)
            i+=1
        }
    }
    
    // MARK: - Navigation
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParent {
            var will_add = "0"
            if let previous = delegate as? NewDayViewController{
                will_add = previous.stored_cell?.name ?? ""
            }
            if(will_add == ""){
                delegate?.append_exercises(compute_exercise())
            }
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

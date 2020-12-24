//
//  SetViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/23/20.
//

import UIKit

class SetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SetViewControllerDelegate {
    
    var sets = [Single_Set]()
    var day_delegate : SingleDayViewControllerDelegate?
    
    @IBOutlet weak var set_table: UITableView!
    @IBOutlet weak var exercise_name_label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        set_table.dataSource = self
        set_table.delegate = self
        
    }
    
    func initialize(sets: [Single_Set], name: String){
        self.sets = sets
        self.exercise_name_label.text = name
        set_table.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "set_cell", for: indexPath) as! SingleSetCell
        cell.set_label?.text = "Set \(indexPath.row + 1)"
        cell.rep_field?.text = String(sets[indexPath.row].reps)
        cell.weight_field?.text = String(sets[indexPath.row].weight)
        if(sets[indexPath.row].is_complete){
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(sets[indexPath.row].is_complete){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            sets[indexPath.row].not_complete()
        } else {
            sets[indexPath.row].complete()
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    
    // MARK: - Navigation
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
    func initialize(sets: [Single_Set], name: String)
}

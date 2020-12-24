//
//  CyclesViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/22/20.
//

import UIKit

class CyclesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CyclesViewControllerDelegate {

    var cycles = [Cycle]()
    var stored_cell : Cycle?
    var nav_title = String()
    var routine_delegate : RoutinesTableViewControllerDelegate?
    
    @IBOutlet weak var cycles_table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cycles_table.dataSource = self
        cycles_table.delegate = self
        stored_cell = nil
        //cycles =
        // Do any additional setup after loading the view.
    }
    
    /*
     number of sections in the cycles table
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /*
     title for the section(s)
     */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cycles"
    }
    
    /*
     the number of elements in the table  should represent the cycles in the routine
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cycles.count
    }
    
    /*
     what does each cell in the table look like
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "proto_cell", for: indexPath)
        cell.textLabel?.text = cycles[indexPath.row].to_string()
        return cell
    }
    
    /*
     implement delete functionality
     */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cycles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        cycles_table.reloadData()
    }
    
    /*
     implement on tapped functionality
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        stored_cell = cycles[indexPath.row]
    }
    
    /*
     this method will create a new cycle based on the most recent cycle, whether the elements are completed or not
     does not matter. This methtod will use the cycle increment function, and add the returned cycle to the cycle
     array
     */
    @IBAction func create_new_cycle(_ sender: Any) {
        cycles.append(cycles[cycles.count - 1].compute_next())
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? DayExerciseViewController{
            destination.routine_delegate = routine_delegate
            destination.cycles_delegate = self
            destination.nav_bar.title = self.nav_title
        }
    }
    

}

protocol CyclesViewControllerDelegate {
    
}

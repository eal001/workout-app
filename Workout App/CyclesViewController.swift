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
    var hidden_base_cycle : Cycle?
    var nav_title = String()
    var routine_delegate : RoutinesTableViewControllerDelegate?
    
    @IBOutlet weak var cycles_table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cycles_table.dataSource = self
        cycles_table.delegate = self
        stored_cell = nil
        
        cycles_table.backgroundColor = Constants.BACKGROUND()
        self.view.backgroundColor = Constants.BACKGROUND()
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
        return Constants.CYCLES
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_ID_0, for: indexPath)
        cell.textLabel?.text = cycles[indexPath.row].to_string()
        cell.backgroundColor = Constants.CELL_0()
        cell.textLabel?.textColor = Constants.TEXT()
        return cell
    }
    
    /*
     implement delete functionality
     */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if cycles.count - 1  == 0 {
                hidden_base_cycle = cycles[0]
                hidden_base_cycle!.adjust_hidden_cycle()
            }
            
            cycles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
        if let first_vc = routine_delegate as? RoutinesTableViewController{
            let i = first_vc.routines.firstIndex(of: first_vc.stored_cell!)
            first_vc.routines[i ?? 0].cycles = cycles
        }
        
        cycles_table.reloadData()
        routine_delegate?.save_routines()
    }
    
    /*
     implement on tapped functionality
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        stored_cell = cycles[indexPath.row]
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
        if let destination = segue.destination as? DayExerciseViewController{
            destination.routine_delegate = routine_delegate
            destination.cycles_delegate = self
            destination.nav_bar.title = self.nav_title
        }
    }
    

}

protocol CyclesViewControllerDelegate {
    
}

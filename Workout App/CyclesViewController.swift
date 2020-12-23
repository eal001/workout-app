//
//  CyclesViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/22/20.
//

import UIKit

class CyclesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var cycles = [Cycle]()
    
    @IBOutlet weak var cycles_table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cycles_table.dataSource = self
        cycles_table.delegate = self
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  RoutinesTableViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/15/20.
//

import UIKit

class RoutinesTableViewController: UITableViewController {

    /*
     the master key will be used to access the array of key strings that are used to access the data for
     the routines
     */
    let MASTER_KEY : String = "MASTER KEY"
    var routines : [Routine] = [Routine]()
    
    @IBOutlet weak var create_button: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load_routines()
    }

    // MARK: save and load
    
    /*
     each routine will be stored to UDM using the save method that each routine instance has
     then each of these strings will be stored to the master key using UDM
     */
    func save_routines(){
        var routine_keys = [String]()
        
        for routine in routines {
            routine_keys.append(routine.save())
        }
        
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(routine_keys) {
            UDM.shared.defaults?.setValue( data, forKey: MASTER_KEY )
        }else {
            print("RoutineViewComtroller: unable to encode the routine keys to the master key")
        }
    }
    
    /*
     this function will re load all the routine keys from the master key.
     Then it will re load the routines based on these keys
     the routine load method should be used
     */
    func load_routines(){
        var routine_keys = [String]()
        
        if let key_data = UDM.shared.defaults?.data(forKey:  MASTER_KEY){
            let decoder = JSONDecoder()
            if let keys = try? decoder.decode([String].self, from: key_data){
                routine_keys = keys
            } else {
                print("RoutineViewController: some data existed at the master key but was not decoded")
            }
        } else {
            print("RoutineViewVontroller: unable to get data for the routine keys")
        }
        
        routines.removeAll()
        for key in routine_keys {
            routines.append( Routine.load(key) )
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: Table view data source

    /*
     the number of routine sections should be one (all routines are stored in one tableview section)
     */
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    /*
    the number of active cells in the table view should be representative of the cells in routines
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return routines.count
    }

    /*
     the cells should ahve the names of the routines, to differentiate 
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "proto_cell", for: indexPath)
        cell.textLabel?.text = routines[indexPath.row].name
        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            routines.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            save_routines()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Routines"
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    //MARK: - Navigation
    /*
     this method will handle a return from a future view to this view.
     It is essentially called from the "exit" of another view controller
     this is handled in main.storyboard. This method needs to get the recently
     created routine from the new view, put it into the data source and reload the table
     */
    @IBAction func handle_return_from_new(_ unwind_segue: UIStoryboardSegue){
        if let from_view = unwind_segue.source as? NewRoutineViewController {
            let new_routine : Routine = from_view.create_routine()
            if(new_routine.name == ""){
                return
            }
            routines.append(from_view.create_routine())
            save_routines()
            load_routines()
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



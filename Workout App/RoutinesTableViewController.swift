//
//  RoutinesTableViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/15/20.
//

import UIKit

class RoutinesTableViewController: UITableViewController, RoutinesTableViewControllerDelegate {

    /*
     the master key will be used to access the array of key strings that are used to access the data for
     the routines NOTE: master key is now stored in the constants class
     */
    var routines : [Routine] = [Routine]()
    var stored_cell : Routine?
    
    @IBOutlet weak var nav_bar: UINavigationItem!
    @IBOutlet weak var create_button: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = Constants.BACKGROUND()
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
            UDM.shared.defaults?.setValue( data, forKey: Constants.MASTER_KEY )
        }else {
            print(Constants.SAVE_ERR_MSG_1)
        }
    }
    
    /*
     this function will re load all the routine keys from the master key.
     Then it will re load the routines based on these keys
     the routine load method should be used
     */
    func load_routines(){
        var routine_keys = [String]()
        
        if let key_data = UDM.shared.defaults?.data(forKey:  Constants.MASTER_KEY){
            let decoder = JSONDecoder()
            if let keys = try? decoder.decode([String].self, from: key_data){
                routine_keys = keys
            } else {
                print(Constants.LOAD_ERR_MSG_2)
            }
        } else {
            print(Constants.LAOD_ERR_MSG_3)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_ID_0, for: indexPath)
        cell.backgroundColor = Constants.CELL_0()
        cell.textLabel?.textColor = Constants.TEXT()
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
    
    /*
     implement on tapped fuctionality
     the stored cell will be used to determine aspects of the next screen
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        stored_cell = routines[indexPath.row]
    }
    
    /*
     the title of the section(s)
     */
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.ROUTINES
    }
    
    /*
     the color and style of the tableview header
     */
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = Constants.SECTION()
        
        if let sect_header = view as? UITableViewHeaderFooterView {
            sect_header.textLabel?.textColor = Constants.TEXT()
        }
        
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
    
    //MARK: Calculations
    
    
    /*
     we will use the value of the stored cell in this vc and set all of its exercise values in this stored
     routine to their max rep/weight/volume. WE will deterimine which ones are the same based on their string titles
     ignore the capitalization when comparing the names. This function operates on the assumption that stored_cell exists
     @param the string exercise that we are comparing to
     */
    func compute_all_pr(name : String) {
        //the maximum weight/reps/volume values for the exercise with the given name
        var max_w : Single_Set = Single_Set(0,0)
        var max_r : Single_Set = Single_Set(0,0)
        var max_v : Single_Set = Single_Set(0,0)
        //print("##################")
        for cycle in stored_cell!.cycles {
            //print("checking cycle: \(cycle.to_string())")
            for day in cycle.days{
                //print("checking day : \(day.name)")
                for exercise in day.exercises{
                    //print("checking exercise : \(exercise.name)", terminator: " ")
                    if(exercise.name.capitalized == name.capitalized){
                        //print("matches")
                        for set in exercise.sets{
                            //print("set is complete?", terminator: " ")
                            if set.is_complete {
                                //print("yes")
                                if set.weight > max_w.weight {
                                    max_w = set
                                }
                                if set.reps > max_r.reps {
                                    max_r = set
                                }
                                if (Double(set.reps) * set.weight ) > (Double(max_v.reps) * max_v.weight) {
                                    max_v = set
                                }
                                
                            } //else { print("no") }
                            //print("maxes at this point: \(max_w.weight) \(max_r.reps)")
                        }
                        
                    } //else { print("doesnt match") }
                }
            }
        }
        
        
        for cycle in stored_cell!.cycles {
            for day in cycle.days{
                for exercise in day.exercises{
                    if(exercise.name.capitalized == name.capitalized){
                        //print("should have set stat")
                        exercise.max_weight = max_v
                        exercise.max_reps = max_r
                        exercise.max_volume = max_v
                    }
                }
            }
        }
        
    }
        

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
            routines.append(new_routine)
            save_routines()
            load_routines()
            //self.tableView.reloadData()
        }
        
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        self.view.endEditing(true)
        
        //if the destination is the tab view
        if let destination = segue.destination as? TabViewController {
            destination.routine_delegate = self
        }
        stored_cell = nil
    }
    
    

}

protocol RoutinesTableViewControllerDelegate {
    
    //a function to save the routines that we have in User Defaults
    func save_routines();
    
    //a function to get all of the same exercises and find the maximum prs that you have done (previously or currently)
    func compute_all_pr(name: String);
}


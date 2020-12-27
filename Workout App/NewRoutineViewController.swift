//
//  NewRoutineViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/15/20.
//

import UIKit

class NewRoutineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, NewRoutineViewControllerDelegate {
    
    var days : [Day] = [Day]()
    var load_routine : Routine = Routine()
    var change_flag = 0
    var stored_cell : Day?
    var returning_index : Int?
    
    @IBOutlet weak var routine_name_field: UITextField!
    @IBOutlet weak var day_table: UITableView!
    @IBOutlet weak var new_day_button: UIButton!
    @IBOutlet weak var create_button: UIBarButtonItem!
    @IBOutlet weak var rest_day_field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        day_table.dataSource = self
        day_table.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    /*
     on touching the screen (not in a text/button view)
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        adjust_rest_days()
    }
    
    /*
     the sections of days taht a routine holds is 1
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /*
     the name of the section(s)
     */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return Constants.DAYS
    }
    
    /*
     the amount of cells should be representative of the days in a cycle in a routine
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    /*
     the day cells should have light gray for rest days, and dark gray for exercise days
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_ID_0, for: indexPath)
        cell.textLabel?.text = days[indexPath.row].name
        if(days[indexPath.row].is_rest){
            cell.backgroundColor = UIColor.systemGray6
        } else {
            cell.backgroundColor = UIColor.systemGray5
        }
        return cell
    }
    
    /*
     on tapping the cell, perform an action
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //note thta this method is executed after the prepare method
        stored_cell = days[indexPath.row]
        returning_index = indexPath.row
    }
    
    /*
     implement delete finctionality
     */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            //check if a rest day was deleted
            let day = days.remove(at: indexPath.row)
            if(day.is_rest){ //if so adjust the text field and the change flag and the names
                rest_day_removed()
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        day_table.reloadData()
    }
    
    //MARK: Calculations
    
    /*
     first we are going to collect each set into an array, and put those sets into each
     exercise with a name. This can be done with the method in the new Exercise View Controller, and
     should have already executed when you are on the DAY (or this is the first screen). Next, after the day
     screen is exited, a day should be created and sent to the routine screen (this one), and held as an
     array in the table. Finally, we will take the days field, put them into a cycle, and create a routine.
     the routine is new and only has one cycle so far. Cycles should be editable in the usage area of this program
     @return new routine
     */
    func create_routine() -> Routine {
        //print("called")
        let first_cycle = Cycle(days)   // we are assuming days is initialized as something useful here;
                                          //if not things would just be blank
        var cycles = [Cycle]()
        cycles.append(first_cycle)
        //print("days: \(days[0].name)")
        //print("cycles: \(Calendar.current.component(.day, from: cycles[0].start_date))")
        return Routine(routine_name_field?.text ?? "", cycles)
    }
    
    /*
     this function will take an index that should fall within the bounds of days and use it to calculate the
     day of the next function (the following day)
     @param index that the new date will be based on
     @return the new date (one day after)
     */
    func compute_next_date(based_on_index index: Int) -> Date{
        if(days.count == 0){
            return Date() //the day of week of this day is today if there are no new dates
        } //if other preceding days exist
        let past_date = days[index].date
        var components = DateComponents()
        components.year = Calendar.current.component(.year, from: past_date)
        components.month = Calendar.current.component(.month, from: past_date)
        components.day = Calendar.current.component(.day, from: past_date) + 1
        components.hour = Calendar.current.component(.hour, from: past_date)
        components.minute = Calendar.current.component(.minute, from: past_date)
        components.second = Calendar.current.component(.minute, from: past_date)
            
        return Calendar.current.date(from: components)!
        
    }
    
    /*
     This function is to be called when we are performing an action after editing something (possibly the
     number of rest days field) essentially it runs through the number in the rest day field and compares
     it to how many rest days there are now. It will update by either removing days from the end, or adding
     to the end
     */
    func adjust_rest_days(){
        
        let num = Int(rest_day_field?.text ?? Constants.ZERO_STR) ?? 0
        
        if(change_flag != num){
            //MARK: LEFT OFF HERE
            var to_remove = num - change_flag //check how many rest days we want to add or subtract
            
            var i = days.count - 1
            while (to_remove < 0 && i >= 0){ //we have a negative difference, so we want to remove some rest days
                if(days[i].is_rest){
                    days.remove(at: i)
                    to_remove += 1
                }
                i -= 1
            }
            
            var day : Day
            i = 1
            if(to_remove > 0){
                for i in 1...to_remove {//we must have a positivve difference meaning we want to add
                    day = Day("\(Constants.REST_DAY) \(change_flag + i)", compute_next_date(based_on_index: days.count - 1), true, [Exercise]())
                    days.append(day)
                }
            }
            
            adjust_rest_names(newRestNum: num)
            change_flag = num
            day_table.reloadData()
        }
        
    }
    
    
    /*
     helper function to change the names of rest days
     */
    private func adjust_rest_names(newRestNum num : Int){
        //after the right number of rest days is determined, edit names
        if(num == 1){ // special case, we only have 1 rest day, so change the name
            for day in days {
                if(day.is_rest){
                    day.name = Constants.REST_DAY
                }
            }
        } else { //change the name, to numbered
            var i = 1
            for day in days {
                if day.is_rest {
                    day.name = "\(Constants.REST_DAY) \(i)"
                    i+=1
                }
            }
        }
    }
    
    /*
     this function is a helper to manage the editing of rest days
     should be called after a rest day is removed, or changed to not
     be a rest day anymore
     */
    private func rest_day_removed(){
        var rds = Int(rest_day_field?.text ?? Constants.ZERO_STR) ?? 0
        if(rds>0){
            rds-=1
        }
        rest_day_field?.text = String(rds)
        change_flag -= 1
        //adjust_rest_names(newRestNum: rds)
    }
    

    // MARK: - Navigation
    
    /*
     this function must be completed, because its delegate will call this fuction
     in another class in order to pass the data backwards back to this class,
     the offset of time (in days needs to be decided in here, becasue the data is
     coming from a place where it does not have the information of the amount of days
     */
    //_ name : String,  _ offset : Int, _ dow : DayOfWeek, _ is_rest : Bool, _ exercises: [Exercise]
    func append_days(_  name : String, _ exercises: [Exercise]) {
        
        let date : Date = compute_next_date(based_on_index: days.count - 1)
        
        //print("\(Calendar.current.component(.month, from: date)) : \(Calendar.current.component(.day, from: date))")
        if(name == ""){
            return
        }
        let new_day = Day(name, date, false, exercises)
        self.days.append(new_day)
        day_table.reloadData()
    }
    
    func edit_day(_ name: String, _ exercises: [Exercise]) {
        if returning_index == nil {
            return
        }
        days[returning_index ?? 0].name = name
        days[returning_index ?? 0].exercises = exercises
        
        if(exercises.count != 0){
            if(days[returning_index ?? 0].is_rest){
                days[returning_index ?? 0].is_rest = false
                day_table.visibleCells[returning_index ?? 0].backgroundColor = UIColor.systemGray5
                rest_day_removed()
            }
            
        }
        
        day_table.reloadData()
        returning_index = nil
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        self.view.endEditing(true)
        adjust_rest_days()
        
        //if the new view controller is going to be of type NewDayViewController
        if let destination = segue.destination as? NewDayViewController {
            destination.routine_delegate = self //create a delegatte for this instance
        }
        stored_cell = nil
    }

}

protocol NewRoutineViewControllerDelegate {
    func append_days(_ name : String, _ exercises: [Exercise]);
    func edit_day(_ name : String, _ exercise: [Exercise]);
}

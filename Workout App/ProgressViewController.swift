//
//  ProgressViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/22/20.
//

import UIKit
import Charts

class ProgressViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    var cycles = [Cycle]()
    var chart_coords = [[(Date, Exercise)]]()
    var routine_delegate : RoutinesTableViewControllerDelegate?
    
    @IBOutlet weak var chart_table: UITableView!
    
    override func viewDidLoad() {
        //print("loaded progress vc")
        super.viewDidLoad()
        chart_table.delegate = self
        chart_table.dataSource = self
        self.view.backgroundColor = Constants.BACKGROUND()
        chart_table.backgroundColor = Constants.BACKGROUND()
        
        chart_table.rowHeight = Constants.CHART_ROW_HEIGHT
        create_coordinates()
        //print("cycles that exist? \(cycles.count)")
        //chart_table.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //create_coordinates()
        //chart_table.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chart_coords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chart_cell", for: indexPath) as! ChartCell
        
        cell.exercise_name_label.text = chart_coords[indexPath.row][0].1.name
        cell.data = [(Date, Exercise)]()
        cell.data = chart_coords[indexPath.row]
        cell.backgroundColor = Constants.CELL_0()
        //cell.textLabel?.text = "loading?"
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func create_coordinates(){
        chart_coords = [[(Date, Exercise)]]()
        var current_date = Date()
        for cycle in cycles{
            //print("cycle checked")
            for day in cycle.days{
                //print("    day checked")
                current_date = day.date
                for exercise in day.exercises{
                    //print("          exercise checked")
                    append_data(date: current_date, exercise: exercise)
                }
            }
        }
    }
    
    /*
     this is a helper fuction to be used to append new exercises and dates to the dataset correctly
     @param date of when the exercise was performed
     @param exercise that was perormed
     */
    private func append_data(date : Date, exercise: Exercise){
        
        //if the data set is empty
        if(chart_coords.count == 0){
            var temp = [(Date, Exercise)]()
            temp.append( (date, exercise) )
            chart_coords.append(temp)
            return;
        }
        
        //loop through the data set and check if there is an existnig exercise array already
        for i in 0..<chart_coords.count {
            //print("looping to check")
            if chart_coords[i][0].1.name.capitalized == exercise.name.capitalized{
                chart_coords[i].append( (date, exercise) )
                return;
            }
        }
        
        //if we didnt append to some array in the data set already
        var temp = [(Date, Exercise)]()
        temp.append( (date, exercise) )
        chart_coords.append(temp)
        return;
        
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

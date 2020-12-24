//
//  SingleDayViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/23/20.
//

import UIKit

class SingleDayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var day : Day?
    var exercises = [Exercise]()
    
    @IBOutlet weak var day_name_label: UILabel!
    @IBOutlet weak var exercise_table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("loaded")
        exercise_table.delegate = self
        exercise_table.dataSource = self
        day_name_label.text = day?.get_day_str()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Exercices"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "proto_cell", for: indexPath)
        cell.textLabel?.text = exercises[indexPath.row].name
        return cell
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

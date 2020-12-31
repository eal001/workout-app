//
//  SetViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/23/20.
//

import UIKit

class SetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SetViewControllerDelegate {
    
    var exercise : Exercise?
    var sets = [Single_Set]()
    var day_delegate : SingleDayViewControllerDelegate?
    var routine_delegate : RoutinesTableViewControllerDelegate?
    
    @IBOutlet weak var info_button: UIButton!
    @IBOutlet weak var max_label: UILabel!
    @IBOutlet weak var set_table: UITableView!
    @IBOutlet weak var exercise_name_label: UILabel!
    @IBOutlet weak var info_segment: UISegmentedControl!
    @IBOutlet weak var max_background_label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("loading")
        set_table.dataSource = self
        set_table.delegate = self
        
        self.view.backgroundColor = Constants.BACKGROUND()
        info_segment.tintColor = Constants.BACKGROUND()
        info_segment.selectedSegmentTintColor = Constants.SECTION()
        info_segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Constants.TEXT()], for: .selected)
        info_segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Constants.BACKGROUND()], for: .normal)
        exercise_name_label.textColor = Constants.TEXT()
        exercise_name_label.backgroundColor = Constants.SECTION()
        max_background_label.backgroundColor = Constants.SECTION()
        max_label.textColor = Constants.TEXT()
        set_table.backgroundColor = Constants.BACKGROUND()
        info_button.tintColor = Constants.TINT()
        set_table.tintColor = Constants.TINT()
        
        set_table.rowHeight = Constants.STD_ROW_HEIGHT
        info_segment.selectedSegmentIndex = 0
    }
    
    /*
     use this function to initialize self in another class, workaround because the on select method for tableview
     executes after the view did load does
     @param exercise, sets, name
     */
    func initialize(exercise: Exercise, sets: [Single_Set], name: String){
        self.exercise = exercise
        self.sets = sets
        self.exercise_name_label.text = name
        
        //exercise.compute_maxes()
        update_maxes_label()
        set_table.reloadData()
        //day_delegate?.reload_table()
        //print("\(self.exercise?.type)")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        //print("touched")
        day_delegate?.reload_table()
        //routine_delegate?.compute_all_pr(name: exercise?.name ?? "" )
        //update_maxes_label()
        //routine_delegate?.save_routines()
    }
    /*
     the number of sections in the tableview
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /*
     the title of the section(s)
     */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.SETS
    }
    
    /*
     the amount of elements in each section
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sets.count
    }
    
    /*
     what does each element look like
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_ID_1, for: indexPath) as! SingleSetCell
        cell.set_label?.text = "\(Constants.SET_TITLE) \(indexPath.row + 1)"
        cell.rep_field?.text = String(sets[indexPath.row].reps)
        cell.weight_field?.text = String((sets[indexPath.row].weight * (Constants.KILOS ? 1 : Constants.K_TO_LB)).round(places: 1))
        cell.set = sets[indexPath.row]
        cell.backgroundColor = Constants.CELL_0()
        if(sets[indexPath.row].is_complete){
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    /*
     implement select and deselect fuctionality and visuals
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(sets[indexPath.row].is_complete){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            sets[indexPath.row].not_complete()
        } else {
            sets[indexPath.row].complete()
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.cellForRow(at: indexPath)?.selectedBackgroundView?.backgroundColor = Constants.CELL_0()
        //print("\(exercise!.max_weight.weight) \(exercise!.max_reps.reps)")
        routine_delegate?.compute_all_pr(name: exercise?.name ?? "" )
        //print("\(exercise!.max_weight.weight) \(exercise!.max_reps.reps)")

        update_maxes_label()
        routine_delegate?.save_routines()
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
    
    /*
     a helper method to update the segmented control's label display
     */
    func update_maxes_label(){
        if info_segment.selectedSegmentIndex == 0{
            max_label.text = "\((exercise!.max_weight.weight * (Constants.KILOS ? 1 : Constants.K_TO_LB)).round(places: 1)) \(Constants.WEIGHT_UNIT())"
        } else if info_segment.selectedSegmentIndex == 1 {
            max_label.text = "\(exercise!.max_reps.reps) \(Constants.REP_UNIT)"
        } else {
            let vol = (exercise!.max_volume.weight * Double(exercise!.max_volume.reps) * (Constants.KILOS ? 1 : Constants.K_TO_LB)).round(places: 1)
            max_label.text = "\(vol) \(Constants.VOL_UNIT())"
        }
    }
    
    /*
     for the segmented view, when it is switched we will update the label
     */
    @IBAction func changed_val(_ sender: Any) {
        update_maxes_label()
    }
    
    @IBAction func max_info(_ sender: Any) {
        let msg : String
        let title : String
        if info_segment.selectedSegmentIndex == 0{
            msg = "\((exercise!.max_weight.weight * (Constants.KILOS ? 1 : Constants.K_TO_LB)).round(places: 1)) \(Constants.WEIGHT_UNIT()) : \(exercise!.max_weight.reps) \(Constants.REP_UNIT)"
            title = "\(Constants.WEIGHT_MSG) \(exercise!.name)"
        } else if info_segment.selectedSegmentIndex == 1 {
            msg = "\(exercise!.max_reps.weight) \(Constants.WEIGHT_UNIT()) : \(exercise!.max_reps.reps) \(Constants.REP_UNIT)"
            title = "\(Constants.REPS_MSG) \(exercise!.name)"
        }else {
            msg = "\((exercise!.max_volume.weight * (Constants.KILOS ? 1 : Constants.K_TO_LB)).round(places: 1)) \(Constants.WEIGHT_UNIT()) : \(exercise!.max_volume.reps) \(Constants.REP_UNIT)"
            title = "\(Constants.VOLUME_MSG) \(exercise!.name)"
        }
        let alert = UIAlertController(title: title,
                                      message: msg,
                                      preferredStyle: UIAlertController.Style.alert )
        alert.addAction( UIAlertAction(title: Constants.FINISHED_TXT, style: .default, handler: nil) )
        self.present(alert, animated: true, completion: nil)
        set_table.reloadData()  //this only avoids a cell coloring issue with the accessory
                                //-- can be removed for performance if necessary
    }
    
    // MARK: - Navigation
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol SetViewControllerDelegate {
    func initialize(exercise: Exercise, sets: [Single_Set], name: String)
}

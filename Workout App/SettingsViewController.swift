//
//  SettingsViewController.swift
//  Workout App
//
//  Created by Elliot Lee on 12/27/20.
//

import UIKit

class SettingsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var routine_delegate : RoutinesTableViewControllerDelegate?
    
    @IBOutlet weak var color_scheme_table: UITableView!
    @IBOutlet weak var settings_label: UILabel!
    @IBOutlet weak var pounds_label: UILabel!
    @IBOutlet weak var kilos_label: UILabel!
    @IBOutlet weak var unit_switch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        color_scheme_table.rowHeight = 100
        
        color_scheme_table.delegate = self
        color_scheme_table.dataSource = self
        settings_label.backgroundColor = Constants.SECTION()
        settings_label.textColor = Constants.TEXT()
        self.view.backgroundColor = Constants.BACKGROUND()
        color_scheme_table.backgroundColor = Constants.BACKGROUND()
        pounds_label.textColor = Constants.TEXT()
        kilos_label.textColor = Constants.TEXT()
        unit_switch.onTintColor = Constants.TINT()
        unit_switch.thumbTintColor = Constants.TEXT()
        
        if(Constants.KILOS){
            unit_switch.isOn = true
        } else {
            unit_switch.isOn = false
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Color Schemes"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.COLOR_SCHEME_AMT
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "color_cell", for: indexPath) as! ColorCell
        
        var name : String
        var image : UIImage
        switch indexPath.row{
        case 0:
            name = Constants.LD_NAME
            image = Constants.LIGHT_DEFAULT
        case 1:
            name = Constants.DD_NAME
            image = Constants.DARK_DEFAULT
        case 2:
            name = Constants.LR_NAME
            image = Constants.LIGHT_RED
        case 3:
            name = Constants.DR_NAME
            image = Constants.DARK_RED
        case 4:
            name = Constants.B_NAME
            image = Constants.BEE
        case 5:
            name = Constants.S_NAME
            image = Constants.SHAN
        case 6:
            name = Constants.G_NAME
            image = Constants.GONZO
        case 7:
            name = Constants.A_NAME
            image = Constants.AQUA
        default:
            name = Constants.LD_NAME
            image = Constants.LIGHT_DEFAULT
        }
        cell.contentView.backgroundColor = Constants.CELL_0()
        cell.scheme_name_label.textColor = Constants.TEXT()
        cell.scheme_name_label?.text = name
        cell.color_image.image = image
        return cell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            Constants.MODE = ColorMode.Light
        case 1:
            Constants.MODE = ColorMode.Dark
        case 2:
            Constants.MODE = ColorMode.RLight
        case 3:
            Constants.MODE = ColorMode.RDark
        case 4:
            Constants.MODE = ColorMode.Bee
        case 5:
            Constants.MODE = ColorMode.Shan
        case 6:
            Constants.MODE = ColorMode.Gonzo
        case 7:
            Constants.MODE = ColorMode.Aqua
        default:
            Constants.MODE = ColorMode.Light
        }
        
        color_scheme_table.reloadData()
        routine_delegate?.reload()
        self.viewDidLoad()
        tableView.cellForRow(at: indexPath)?.selectedBackgroundView?.backgroundColor = Constants.CELL_0()
    }
    
    @IBAction func unit_changed(_ sender: Any) {
        routine_delegate?.save_weight_units()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if(unit_switch.isOn){
            Constants.KILOS = true
        }else {
            Constants.KILOS = false
        }
        routine_delegate?.reload()
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

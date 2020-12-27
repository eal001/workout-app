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
    var routine_delegate : RoutinesTableViewControllerDelegate?
    
    @IBOutlet weak var chart_table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.BACKGROUND()
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
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

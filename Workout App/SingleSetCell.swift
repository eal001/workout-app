//
//  SingleSetCell.swift
//  Workout App
//
//  Created by Elliot Lee on 12/16/20.
//

import UIKit

class SingleSetCell: UITableViewCell, UITextViewDelegate {

    var BACKGROUND : UIColor = UIColor.white
    var TEXT : UIColor = UIColor.white
    var SECTION : UIColor = UIColor.white
    var CELL_0 : UIColor = UIColor.white
    var CELL_1 : UIColor = UIColor.white
    
    @IBOutlet weak var rep_field: UITextField!
    @IBOutlet weak var weight_field: UITextField!
    @IBOutlet weak var set_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

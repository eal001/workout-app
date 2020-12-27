//
//  SingleSetCell.swift
//  Workout App
//
//  Created by Elliot Lee on 12/16/20.
//

import UIKit

class SingleSetCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var rep_field: UITextField!
    @IBOutlet weak var weight_field: UITextField!
    @IBOutlet weak var set_label: UILabel!
    @IBOutlet weak var rep_label: UILabel!
    @IBOutlet weak var weight_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // AWOKEN FROM NIB!!!!!
        self.contentView.backgroundColor = Constants.CELL_0()
        set_label.textColor = Constants.TEXT()
        weight_label.textColor = Constants.TEXT()
        rep_label.textColor = Constants.TEXT()
        rep_field.textColor = Constants.TEXT()
        rep_field.backgroundColor = Constants.BACKGROUND()
        weight_field.textColor = Constants.TEXT()
        weight_field.backgroundColor = Constants.BACKGROUND()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

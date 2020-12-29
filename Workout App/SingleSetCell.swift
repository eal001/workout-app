//
//  SingleSetCell.swift
//  Workout App
//
//  Created by Elliot Lee on 12/16/20.
//

import UIKit

class SingleSetCell: UITableViewCell, UITextViewDelegate, UITextFieldDelegate {
    
    var set = Single_Set(0,0)
    
    @IBOutlet weak var rep_field: UITextField!
    @IBOutlet weak var weight_field: UITextField!
    @IBOutlet weak var set_label: UILabel!
    @IBOutlet weak var rep_label: UILabel!
    @IBOutlet weak var weight_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // AWOKEN FROM NIB!!!!!
        weight_field.delegate = self
        rep_field.delegate = self
        
        self.contentView.backgroundColor = Constants.CELL_0()
        set_label.textColor = Constants.TEXT()
        weight_label.textColor = Constants.TEXT()
        weight_label.text = Constants.WEIGHT_UNIT()
        rep_label.textColor = Constants.TEXT()
        rep_field.textColor = Constants.TEXT()
        rep_field.backgroundColor = Constants.BACKGROUND()
        weight_field.textColor = Constants.TEXT()
        weight_field.backgroundColor = Constants.BACKGROUND()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        set.weight = ((Double(weight_field.text ?? "0") ?? 0 ) * (Constants.KILOS ? 1 : 1/Constants.K_TO_LB) ).round(places: 2)
        set.reps = Int(rep_field.text ?? "0") ?? 0
        self.contentView.endEditing(true)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

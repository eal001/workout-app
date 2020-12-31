//
//  ExerciseCell.swift
//  Workout App
//
//  Created by Elliot Lee on 12/30/20.
//

import UIKit

class ExerciseCell: UITableViewCell {

    var exercise : Exercise?
    
    @IBOutlet weak var progress_bar: UIProgressView!
    @IBOutlet weak var name_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = Constants.CELL_0()
        progress_bar.backgroundColor = Constants.BACKGROUND()
        progress_bar.tintColor = Constants.BACKGROUND()
        progress_bar.progressTintColor = Constants.TINT()
        name_label.textColor = Constants.TEXT()
        name_label.text = exercise?.name
        
        progress_bar.progress = 0.5
        
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = Constants.CELL_0()
        progress_bar.backgroundColor = Constants.BACKGROUND()
        progress_bar.tintColor = Constants.BACKGROUND()
        progress_bar.progressTintColor = Constants.TINT()
        name_label.textColor = Constants.TEXT()
        name_label.text = exercise?.name
        
        reload_progress()
        
    }

    func reload_progress(){
        //print("progress reloaded")
        var complete = 0.0
        for set in exercise?.sets ?? [Single_Set]() {
            if(set.is_complete){
                complete += 1
            }
        }
        progress_bar.progress = Float(complete / Double((exercise!.sets.count) ))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

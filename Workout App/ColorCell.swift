//
//  ColorCell.swift
//  Workout App
//
//  Created by Elliot Lee on 12/27/20.
//

import UIKit

class ColorCell: UITableViewCell {

    @IBOutlet weak var color_image: UIImageView!
    @IBOutlet weak var scheme_name_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = Constants.CELL_0()
        scheme_name_label.textColor = Constants.TEXT()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  DoneTableViewCell.swift
//  MyApp2
//
//  Created by 남보경 on 2023/08/31.
//

import UIKit

class DoneTableViewCell: UITableViewCell {

    @IBOutlet var checkedBox: UIButton!
    @IBOutlet var doneField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

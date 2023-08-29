//
//  SegmentedControllerTableViewCell.swift
//  MyApp2
//
//  Created by 보경 on 2023/08/10.
//

import UIKit

class TodoViewControllerCell: UITableViewCell {


    @IBOutlet weak var todo: UILabel!
    @IBOutlet weak var checkBox: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

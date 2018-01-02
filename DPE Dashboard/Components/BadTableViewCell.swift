//
//  BadTableViewCell.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 1/2/18.
//  Copyright © 2018 Department Power Plant & Energy. All rights reserved.
//

import UIKit

class BadTableViewCell: UITableViewCell {

    @IBOutlet weak var projectName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  OkDetailsTableViewCell.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 3/17/18.
//  Copyright © 2018 Department Power Plant & Energy. All rights reserved.
//

import UIKit

class OkDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var projectNameLabel: UILabel!

    @IBOutlet weak var rkapLabel: UILabel!
    @IBOutlet weak var riLabel: UILabel!
    @IBOutlet weak var progLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

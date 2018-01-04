//
//  UmurPiutangTableViewCell.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 1/4/18.
//  Copyright © 2018 Department Power Plant & Energy. All rights reserved.
//

import UIKit

class UmurPiutangTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

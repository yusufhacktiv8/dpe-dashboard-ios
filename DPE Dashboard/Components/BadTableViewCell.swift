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
    @IBOutlet weak var piutangUsahaLabel: UILabel!
    @IBOutlet weak var tagihanBrutoLabel: UILabel!
    @IBOutlet weak var piutangRetensiLabel: UILabel!
    @IBOutlet weak var pdpLabel: UILabel!
    @IBOutlet weak var badLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

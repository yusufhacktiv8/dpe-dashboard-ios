//
//  CashFlowTableViewCell.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 1/5/18.
//  Copyright © 2018 Department Power Plant & Energy. All rights reserved.
//

import UIKit

class CashFlowTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rkapLabel: UILabel!
    @IBOutlet weak var rencanaLabel: UILabel!
    @IBOutlet weak var prognosaLabel: UILabel!
    @IBOutlet weak var realisasiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

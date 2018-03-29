//
//  SecondTableViewCell.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 12/30/17.
//  Copyright © 2017 Department Power Plant & Energy. All rights reserved.
//

import UIKit

class SecondTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var okLabel: UILabel!
    @IBOutlet weak var opLabel: UILabel!
    @IBOutlet weak var lkLabel: UILabel!
    @IBOutlet weak var lspLabel: UILabel!
    
    var onOkButtonTapped : ((_ tag: Int) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func okButtonDidTouch(_ sender: Any) {
        if let onOkButtonTapped = self.onOkButtonTapped {
            onOkButtonTapped((sender as! UIButton).tag)
        }
    }
}

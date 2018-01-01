//
//  FirstTableViewCell.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 12/30/17.
//  Copyright © 2017 Department Power Plant & Energy. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    @IBOutlet weak var rkapOkLabel: UILabel!
    @IBOutlet weak var rkapOpLabel: UILabel!
    @IBOutlet weak var rkapLspLabel: UILabel!
    
    @IBOutlet weak var riOkLabel: UILabel!
    @IBOutlet weak var riOpLabel: UILabel!
    @IBOutlet weak var riLspLabel: UILabel!
    
    @IBOutlet weak var progOkLabel: UILabel!
    @IBOutlet weak var progOpLabel: UILabel!
    @IBOutlet weak var progLspLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

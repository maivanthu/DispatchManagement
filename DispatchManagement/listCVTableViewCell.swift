//
//  listCVTableViewCell.swift
//  MasterDocs
//
//  Created by VanThu on 05/03/2017.
//  Copyright © 2017 VanThu. All rights reserved.
//

import UIKit

class listCVTableViewCell: UITableViewCell {
    @IBOutlet weak var sovanbanLabel: UILabel!
    @IBOutlet weak var loaivanbanLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  ForbsSpecificCellTableViewCell.swift
//  LuminousID
//
//  Created by Brian Larson on 4/22/17.
//  Copyright © 2017 Garden Club. All rights reserved.
//

import UIKit

class ForbsSpecificCellTableViewCell: UITableViewCell {

    @IBOutlet weak var AttributeImage: UIImageView!
    @IBOutlet weak var AttributeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

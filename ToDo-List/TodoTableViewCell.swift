//
//  TodoTableViewCell.swift
//  ToDo-List
//
//  Created by William Huang on 8/26/17.
//  Copyright © 2017 William Huang. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  XMLTableViewCell.swift
//  ZhangReader
//
//  Created by Jingzhi Zhang on 9/26/17.
//  Copyright © 2017 NIU CS Department. All rights reserved.
//  Purpse: create a table view cell to hold client's name and profession data

import UIKit

class XMLTableViewCell: UITableViewCell {

    //Markup: Outlets for tableviewcell
    
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var clientProfession: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

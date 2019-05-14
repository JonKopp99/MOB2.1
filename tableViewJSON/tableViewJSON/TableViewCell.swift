//
//  TableViewCell.swift
//  tableViewJSON
//
//  Created by Jonathan Kopp on 2/7/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
var label1 = UILabel()
var label2 = UILabel()
var label3 = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        label1.frame = CGRect(x: 0, y: 0, width: frame.width / 2, height: frame.height)
        label2.frame = CGRect(x: 0, y: frame.height / 2 , width: frame.width / 2, height: frame.height)
        label3.frame = CGRect(x: frame.width / 2, y: 0, width: frame.width / 2, height: frame.height)
        addSubview(label1)
        addSubview(label2)
        addSubview(label3)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

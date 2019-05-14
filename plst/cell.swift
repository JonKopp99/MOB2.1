//
//  cell.swift
//  penist
//
//  Created by Jonathan Kopp on 4/3/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit
import Foundation
class cell: UITableViewCell{
    let nameLabel = UILabel()
    let scoreLabel = UILabel()
    override func layoutSubviews() {
        nameLabel.frame = CGRect(x: 5, y: 0, width: frame.width / 2 , height: frame.height)
        nameLabel.textColor = .black
        addSubview(nameLabel)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

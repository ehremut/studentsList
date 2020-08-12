//
//  TableViewCell.swift
//  tApp
//
//  Created by macOS developer on 11.08.2020.
//  Copyright © 2020 macOS developer. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var sum: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

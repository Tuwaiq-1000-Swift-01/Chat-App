//
//  TableViewCell.swift
//  chatApp01
//
//  Created by Osama folta on 12/06/1443 AH.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var logo2: UIButton!
    @IBOutlet weak var logo: UIButton!
    @IBOutlet weak var moveLeft: NSLayoutConstraint!
    @IBOutlet weak var moveRight: NSLayoutConstraint!
    @IBOutlet weak var msg: UILabel!
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

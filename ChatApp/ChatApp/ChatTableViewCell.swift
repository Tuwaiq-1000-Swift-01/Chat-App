//
//  ChatTableViewCell.swift
//  ChatApp
//
//  Created by Nada Alansari on 11/06/1443 AH.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var chatCell: UIView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var msg: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

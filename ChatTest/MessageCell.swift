//
//  MassegeCell.swift
//  ChatTest
//
//  Created by Afnan Theb on 12/06/1443 AH.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

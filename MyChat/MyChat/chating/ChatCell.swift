//
//  ChatCell.swift
//  MyChat
//
//  Created by Anas Hamad on 11/06/1443 AH.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet var time: UILabel!
    @IBOutlet var sender: UILabel!
    @IBOutlet var chatLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

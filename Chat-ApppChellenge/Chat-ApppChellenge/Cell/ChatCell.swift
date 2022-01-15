//
//  ChatCell.swift
//  Chat-ApppChellenge
//
//  Created by Noura Alahmadi on 12/06/1443 AH.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var userNameinChat: UILabel!
    @IBOutlet weak var userMessages: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  Users.swift
//  Chat-Firebase
//
//  Created by Aisha Ali on 1/15/22.
//

import UIKit


class Users: UITableViewCell {
  
  @IBOutlet weak var userImage: UIImageView!
  
  @IBOutlet weak var userNameLabel: UILabel!
  
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

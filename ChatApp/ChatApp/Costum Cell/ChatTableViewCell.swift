//
//  ChatTableViewCell.swift
//  ChatApp
//
//  Created by Njoud Alrshidi on 11/06/1443 AH.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var backgrond: UIView!
    @IBOutlet weak var messageBodyLbl: UILabel!
    @IBOutlet weak var iimageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

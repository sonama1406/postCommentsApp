//
//  PostTableViewCell.swift
//  PostAndCommentsApp
//
//  Created by Sonam Mittal on 06/08/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet var lblBody: UILabel!
    @IBOutlet var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

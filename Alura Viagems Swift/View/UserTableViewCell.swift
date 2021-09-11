//
//  UserTableViewCell.swift
//  Alura Viagems Swift
//
//  Created by Curitiba01 on 10/09/21.
//

import UIKit
import SDWebImage

class UserTableViewCell: UITableViewCell {
    static let identifier = "userCell"
    var user: User? {
        didSet {
            setData()
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!

    private func setData() {
        guard let user = user else { return }
        nameLabel.text = "\(user.firstName) \(user.lastName)"
        
        if let url = URL(string: user.avatarURL) {
            avatarImageView.sd_setImage(with: url, completed: nil)
        }
        
    }
}

//
//  IGFeedPostTableViewCell.swift
//  Instagram
//
//  Created by Lộc Xuân  on 26/09/2022.
//

import UIKit

class IGFeedPostTableViewCell: UITableViewCell {

    static let identifier: String = "IGFeedPostTableViewCell"
    // Dont understand
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

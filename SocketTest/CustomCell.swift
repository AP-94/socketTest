//
//  CustomCell.swift
//  SocketTest
//
//  Created by Alessandro Pace on 24/10/2020.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!

    var message: Message? {
        didSet {
            if let message = message?.text {
                messageLabel.text = message
            }
            
            if let user = message?.author {
                userLabel.text = user + ":"
            }
        }
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

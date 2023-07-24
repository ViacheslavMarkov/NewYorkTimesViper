//
//  MessageTableViewCell.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 24.07.2023.
//

import UIKit

final class MessageTableViewCell: UITableViewCell, NibCapable {

    @IBOutlet private weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(message text: String = "Category list is empty yet!") {
        messageLabel.text = text
    }

    func showHideMessage(isHidden: Bool) {
        messageLabel.isHidden = !isHidden
    }
}

//MARK: - MessageTableViewCell
private extension MessageTableViewCell {
}

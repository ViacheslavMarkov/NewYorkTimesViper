//
//  CategoryTableViewCell.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 24.07.2023.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell, NibCapable {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configure(at model: CategoryModel) {
        titleLabel.text = model.category.displayName
        dateLabel.text = model.date
    }
}

private extension CategoryTableViewCell {
    func configureUI() {
        containerView.backgroundColor = .systemGray6
        containerView.set(cornerRadius: 8)
        
        titleLabel.numberOfLines = 0
        dateLabel.textColor = .black.withAlphaComponent(0.8)
    }
}

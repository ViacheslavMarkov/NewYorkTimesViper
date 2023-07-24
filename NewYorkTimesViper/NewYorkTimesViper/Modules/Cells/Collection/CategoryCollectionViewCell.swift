//
//  CategoryCollectionViewCell.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 21.07.2023.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell, NibCapable {
    
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

private extension CategoryCollectionViewCell {
    func configureUI() {
        containerView.backgroundColor = .systemGray6
        containerView.set(cornerRadius: 8)
        
        titleLabel.numberOfLines = 0
    }
}

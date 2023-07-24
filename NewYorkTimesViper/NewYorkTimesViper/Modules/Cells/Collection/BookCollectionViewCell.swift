//
//  CategoryCollectionViewCell.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 21.07.2023.
//

import UIKit

protocol BookCollectionViewCellDelegation: AnyObject {
    func didTapLink(_ sender: BookCollectionViewCell, at link: String)
}

final class BookCollectionViewCell: UICollectionViewCell, NibCapable {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var rankInfoLabel: UILabel!
    @IBOutlet private weak var publishedInfoLabel: UILabel!
    @IBOutlet private weak var descriptionInfoLabel: UILabel!
    
    @IBOutlet private weak var authorInfoLabel: UILabel!
    @IBOutlet private weak var linksStackView: UIStackView!
    @IBOutlet private weak var containerLinksView: UIView!
    
    @IBOutlet private weak var linksLabel: UILabel!
    @IBOutlet private weak var mainContainerView: LinksView!
    @IBOutlet private weak var imageView: UIImageView!
    
    weak var delegate: BookCollectionViewCellDelegation?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configure(at model: BookData) {
        titleLabel.text = model.publisher
        descriptionInfoLabel.text = model.description
        publishedInfoLabel.text = model.publisher
        
        authorInfoLabel.text = model.author
        rankInfoLabel.text = "\(model.rank)"
        imageView.imageFromServerURLWithCompletion(urlString: model.imageUrlString)
        
        let links = model.buyLinks
        
        mainContainerView.isHidden = links.isEmpty
        linksLabel.isHidden = links.isEmpty
        
        if linksStackView.arrangedSubviews.isEmpty {
            addViews(items: links)
        } else {
            if linksStackView.arrangedSubviews.count == links.count {
                for (value, view) in zip(links, linksStackView.arrangedSubviews) {
                    (view as? DictionaryView)?.keyLabel.text = value.name
                    (view as? DictionaryView)?.valueLabel.text = value.url
                }
            } else {
                linksStackView.removeArrangedSubviews()
                addViews(items: links)
            }
        }
    }
}

private extension BookCollectionViewCell {
    func configureUI() {
        containerLinksView.backgroundColor = .white
        containerLinksView.set(cornerRadius: 8)
        containerLinksView.set(borderColor: .blue, borderWidth: 1)
        
        titleLabel.numberOfLines = 0
        
        mainContainerView.set(cornerRadius: 8)
        mainContainerView.backgroundColor = .systemGray6
    }
    
     func makeView(name: String, link: String, tag: Int) -> DictionaryView {
        let dictionaryView = DictionaryView()
         dictionaryView.configureUI(key: name, value: link)
         dictionaryView.keyLabel.numberOfLines = 1
         dictionaryView.valueLabel.numberOfLines = 1
         dictionaryView.valueLabel.isUserInteractionEnabled = true
         dictionaryView.valueLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
         dictionaryView.tag = tag
        return dictionaryView
    }
    
    @objc
     func labelTapped(sender: UITapGestureRecognizer) {
        guard
            let label = sender.view as? UILabel,
            var link = label.text
        else { return }
        let _ = link.removeFirst()
        let trimmedString = link.trimmingCharacters(in: .whitespaces)
        delegate?.didTapLink(self, at: trimmedString)
    }
    
     func addViews(items: [BuyLinksData]) {
        for (index, value) in items.enumerated() {
            let stackView = makeView(name: value.name, link: value.url, tag: index)
            linksStackView.addArrangedSubview(stackView)
        }
    }
}

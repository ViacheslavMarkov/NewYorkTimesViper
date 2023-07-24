//
//  LinksView.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 24.07.2023.
//

import UIKit

protocol LinksViewDelegating: AnyObject {
    func didTapLink(_ sender: LinksView, at link: String)
}

 final class LinksView: UIView {
    public weak var delegate: LinksViewDelegating?
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [],
            axis: .vertical
        )
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
    }()
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        add([
            vStack
        ])
        
        NSLayoutConstraint.activate([
            vStack.top.constraint(equalTo: top, constant: 8),
            vStack.leading.constraint(equalTo: leading, constant: 8),
            vStack.trailing.constraint(equalTo: trailing, constant: -8),
            vStack.bottom.constraint(equalTo: bottom, constant: -8),
        ])
    }
    
    public func configureUI(items: [BuyLinksData]) {
        if vStack.arrangedSubviews.isEmpty {
            addViews(items: items)
        } else {
            if vStack.arrangedSubviews.count == items.count {
                for (value, view) in zip(items, vStack.arrangedSubviews) {
                    (view as? DictionaryView)?.keyLabel.text = value.name
                    (view as? DictionaryView)?.valueLabel.text = value.url
                }
            } else {
                vStack.removeArrangedSubviews()
                addViews(items: items)
            }
        }
    }
    
    private func makeView(name: String, link: String, tag: Int) -> DictionaryView {
        let linkView = DictionaryView()
        linkView.configureUI(key: name, value: link)
        linkView.keyLabel.numberOfLines = 1
        linkView.valueLabel.numberOfLines = 1
        linkView.valueLabel.isUserInteractionEnabled = true
        linkView.valueLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
        linkView.tag = tag
        return linkView
    }
    
    @objc
    private func labelTapped(sender: UITapGestureRecognizer) {
        guard
            let label = sender.view as? UILabel,
            var link = label.text
        else { return }
        let _ = link.removeFirst()
        let trimmedString = link.trimmingCharacters(in: .whitespaces)
        delegate?.didTapLink(self, at: trimmedString)
    }
    
    private func addViews(items: [BuyLinksData]) {
        for (index, value) in items.enumerated() {
            let linkView = makeView(name: value.name, link: value.url, tag: index)
            vStack.addArrangedSubview(linkView)
        }
    }
}

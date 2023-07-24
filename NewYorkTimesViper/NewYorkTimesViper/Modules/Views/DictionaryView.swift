//
//  DictionaryView.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 24.07.2023.
//

import UIKit

final class DictionaryView: UIView {
     lazy var keyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.8
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
     lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
     init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        add([
            keyLabel,
            valueLabel
        ])
        
        NSLayoutConstraint.activate([
            keyLabel.top.constraint(equalTo: top),
            keyLabel.leading.constraint(equalTo: leading),
            keyLabel.bottom.constraint(lessThanOrEqualTo: bottom),
            keyLabel.width.constraint(equalToConstant: 80),
            
            valueLabel.top.constraint(equalTo: keyLabel.top),
            valueLabel.leading.constraint(equalTo: keyLabel.trailing, constant: 4),
            valueLabel.trailing.constraint(equalTo: trailing, constant: -12),
            valueLabel.bottom.constraint(equalTo: bottom),
        ])
    }
    
     func configureUI(key: String, value: String) {
        keyLabel.text = key
        valueLabel.text = ": \(value)"
    }
}

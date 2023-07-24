//
//  NibCapable+Extension.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 21.07.2023.
//

import UIKit

protocol NibCapable: AnyObject {
    static var identifier: String { get }
    static func nib() -> UINib
}

extension NibCapable {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

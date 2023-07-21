//
//  StoryboardIdentifiable.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 18.07.2023.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

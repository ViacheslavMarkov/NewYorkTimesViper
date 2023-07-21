//
//  ViewController+Extension.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 18.07.2023.
//

import UIKit

extension UIViewController: AlertDisplayable, StoryboardIdentifiable {
    func showAlert(with error: Error) {
        present(self, animated: true) {
            print("")
        }
    }
}

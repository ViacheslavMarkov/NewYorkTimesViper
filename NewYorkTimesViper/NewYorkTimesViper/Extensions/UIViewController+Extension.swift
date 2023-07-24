//
//  UIViewController+Extension.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 18.07.2023.
//

import UIKit
import SafariServices

extension UIViewController: AlertDisplayable, StoryboardIdentifiable {
    func showAlert(with error: Error) {
        present(self, animated: true) {
            print("")
        }
    }
    
    func presentSafariVC(
        url: URL?,
        entersReaderIfAvailable: Bool = true
    ) {
        guard let url = url else {
            presentBasicAlert(message: "Sorry, we can't show this right now. Please try again later.")
            return
        }

        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = entersReaderIfAvailable

        let vc = SFSafariViewController(url: url, configuration: config)
        vc.preferredControlTintColor = .white
        vc.modalPresentationStyle = .popover
        present(vc, animated: true)
    }
}

//
//  AlertDisplayable.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 18.07.2023.
//

import UIKit

protocol AlertDisplayable {
    func showAlert(with error: Error)
}

extension AlertDisplayable where Self: UIViewController {
    func showCustomAlert(
        isNeedToShow: Bool = true,
        image: UIImage,
        text: String?,
        isAutomaticallyDismissed: Bool = true,
        completion: (() -> ())?
    ) {
        if isNeedToShow {
//            let customAlert: AlertViewController = UIStoryboard.getStoryboard(by: .alert).instantiateViewController()
//            customAlert.controllerDidDismiss = {
//                completion?()
//            }
//            customAlert.isAutomaticallyDismissed = isAutomaticallyDismissed
//            customAlert.dataSource = (image, text)
//            customAlert.providesPresentationContextTransitionStyle = true
//            customAlert.definesPresentationContext = true
//            customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//            customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//            
//            self.present(customAlert, animated: true, completion: nil)
        }
    }
}

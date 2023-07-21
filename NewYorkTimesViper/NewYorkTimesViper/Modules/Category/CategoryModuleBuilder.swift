//
//  CategoryModuleBuilder.swift
//  Super easy dev
//
//  Created by Viacheslav Markov on 18.07.2023
//

import UIKit

final class CategoryModuleBuilder {
    static func build() -> CategoryViewController {
        let interactor = CategoryInteractor()
        let router = CategoryRouter()
        let presenter = CategoryPresenter(interactor: interactor, router: router)
        let storyboard = UIStoryboard(name: "Category", bundle: nil)
        guard
            let viewController = storyboard.instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController
        else { return CategoryViewController() } 
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}

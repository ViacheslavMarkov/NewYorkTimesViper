//
//  BookModuleBuilder.swift
//  Super easy dev
//
//  Created by Viacheslav Markov on 24.07.2023
//

import UIKit

class BookModuleBuilder {
    static func build(books: [BookData]) -> BookViewController {
        let interactor = BookInteractor(books: books)
        let router = BookRouter()
        let presenter = BookPresenter(interactor: interactor, router: router)
        let storyboard = UIStoryboard(name: "Book", bundle: nil)
        guard
            let viewController = storyboard.instantiateViewController(withIdentifier: "BookViewController") as? BookViewController
        else { return BookViewController() }
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}

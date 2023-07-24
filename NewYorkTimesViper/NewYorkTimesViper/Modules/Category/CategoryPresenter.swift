//
//  CategoryPresenter.swift
//  Super easy dev
//
//  Created by Viacheslav Markov on 18.07.2023
//

protocol CategoryPresenterProtocol: AnyObject {
    func viewDidLoaded() async
    func didFetchCategories(categories: [CategoryModel])
    func presentAlert(message: String)
}

final class CategoryPresenter {
    weak var view: CategoryViewProtocol?
    var router: CategoryRouterProtocol
    var interactor: CategoryInteractorProtocol

    init(
        interactor: CategoryInteractorProtocol,
        router: CategoryRouterProtocol
    ) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - CategoryPresenterProtocol
extension CategoryPresenter: CategoryPresenterProtocol {
    func presentAlert(message: String) {
        view?.presentAlert(with: message)
    }
    
    func didFetchCategories(categories: [CategoryModel]) {
        print(categories.count)
        view?.updateDynamicBooksDataSource(items: categories)
    }
    
    func viewDidLoaded() async {
        await interactor.fetchData()
    }
}

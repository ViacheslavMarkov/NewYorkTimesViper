//
//  CategoryPresenter.swift
//  Super easy dev
//
//  Created by Viacheslav Markov on 18.07.2023
//

protocol CategoryPresenterProtocol: AnyObject {
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

//MARK: - CategoryPresenterProtocol
extension CategoryPresenter: CategoryPresenterProtocol {
}
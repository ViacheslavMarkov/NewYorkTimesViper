//
//  BookPresenter.swift
//  Super easy dev
//
//  Created by Viacheslav Markov on 24.07.2023
//

protocol BookPresenterProtocol: AnyObject {
    func updateCollection()
}

class BookPresenter {
    //MARK: - Properties
    weak var view: BookViewProtocol?
    var router: BookRouterProtocol
    var interactor: BookInteractorProtocol

    //MARK: - Initializer
    init(interactor: BookInteractorProtocol, router: BookRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - BookPresenter
extension BookPresenter: BookPresenterProtocol {
    func updateCollection() {
        let books = interactor.getBooks()
        view?.updateDynamicBooksDataSource(books: books)
    }
}

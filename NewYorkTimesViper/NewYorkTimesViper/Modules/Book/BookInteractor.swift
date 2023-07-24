//
//  BookInteractor.swift
//  Super easy dev
//
//  Created by Viacheslav Markov on 24.07.2023
//

protocol BookInteractorProtocol: AnyObject {
    func getBooks() -> [BookData]
}

class BookInteractor: BookInteractorProtocol {
    weak var presenter: BookPresenterProtocol?
    private let books: [BookData]
    
    init(books: [BookData]) {
        self.books = books
    }
    
    func getBooks() -> [BookData] {
        return books
    }
}

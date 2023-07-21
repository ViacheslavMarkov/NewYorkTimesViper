//
//  CategoryInteractor.swift
//  Super easy dev
//
//  Created by Viacheslav Markov on 18.07.2023
//

protocol CategoryInteractorProtocol: AnyObject {
}

final class CategoryInteractor: CategoryInteractorProtocol {
    weak var presenter: CategoryPresenterProtocol?
}

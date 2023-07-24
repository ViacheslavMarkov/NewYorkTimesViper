//
//  CategoryRouter.swift
//  Super easy dev
//
//  Created by Viacheslav Markov on 18.07.2023
//

protocol CategoryRouterProtocol {
    func didShowBookVC(with books: [BookData])
}

final class CategoryRouter: CategoryRouterProtocol {
    func didShowBookVC(with books: [BookData]) {
//        let bookVC = Book
//        viewController?.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
    
    weak var viewController: CategoryViewController?
}

//
//  CategoryInteractor.swift
//  Super easy dev
//
//  Created by Viacheslav Markov on 18.07.2023
//

protocol CategoryInteractorProtocol: AnyObject {
    func fetchData() async
}

final class CategoryInteractor: CategoryInteractorProtocol {
    weak var presenter: CategoryPresenterProtocol?
    
    func fetchData() async {
        let categoryAPI = CategoryAPI(requestObject: EmptyRequest())
        await NetworkRequestManager.shared.call(categoryAPI) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error.message)
                self.presenter?.presentAlert(message: error.message)
            case .success(let response):
                self.createModels(response: response.results)
            }
        }
    }
}

private extension CategoryInteractor {
    func createModels(response: OverviewData?) {
        guard
            let response = response
        else {
            presenter?.presentAlert(message: "Error fetching categories")
            return
        }
              
        var list: [CategoryModel] = []
        response.lists.forEach({ (category) in
            let model = CategoryModel(date: response.publishedDate, category: category)
            list.append(model)
        })
        self.presenter?.didFetchCategories(categories: list)
    }
}

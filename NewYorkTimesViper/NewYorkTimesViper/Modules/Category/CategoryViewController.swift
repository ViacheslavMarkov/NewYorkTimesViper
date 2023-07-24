//
//  CategoryViewController.swift
//  Super easy dev
//
//  Created by Viacheslav Markov on 18.07.2023
//

import UIKit

protocol CategoryViewProtocol: AnyObject {
    func updateDynamicBooksDataSource(items: [CategoryModel])
    func presentAlert(with message: String)
}

final class CategoryViewController: UIViewController {
    
    private typealias Snapshot = NSDiffableDataSourceSnapshot<CategorySections, CategorySections.Item>
    private typealias DataSource = UITableViewDiffableDataSource<CategorySections, CategorySections.Item>
    
    // MARK: - Public
    var presenter: CategoryPresenterProtocol?
    
    private var data = [CategorySections: [CategorySections.Item]]()
    private var dataSource: DataSource?
    private var snapshot = Snapshot()
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: - Private functions
private extension CategoryViewController {
    func initialize() {
        Task.init {
            await presenter?.viewDidLoaded()
        }
        prepareDataSource()
        setupTableView()
        updateDynamicBooksDataSource()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.register(CategoryTableViewCell.nib(), forCellReuseIdentifier: CategoryTableViewCell.identifier)
        tableView.register(MessageTableViewCell.nib(), forCellReuseIdentifier: MessageTableViewCell.identifier)
    }
    
    private func prepareDataSource() {
        dataSource?.defaultRowAnimation = .fade
        dataSource = UITableViewDiffableDataSource(
            tableView: tableView
        ) { (tableView, indexPath, item) -> UITableViewCell? in
            switch item {
            case .list(item: let model):
                return self.cellForRowAt(indexPath, with: model)
            case .emptyMessage(item: let message):
                return self.messageCellForRowAt(indexPath, with: message)
            }
        }
    }
    
     func cellForRowAt(
        _ indexPath: IndexPath,
        with model: CategoryModel
    ) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier) as? CategoryTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configure(at: model)
        return cell
    }
    
    func messageCellForRowAt(
       _ indexPath: IndexPath,
       with text: String
   ) -> UITableViewCell {
       guard
           let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.identifier) as? MessageTableViewCell
       else {
           return UITableViewCell()
       }
       let key = data.keys.first(where: { $0 == .category }) ?? .category
       let list = data[key] ?? []
       cell.showHideMessage(isHidden: list.isEmpty)
       cell.configure(message: text)
       return cell
   }
    
    func applySnapshot(
        _ animatingDifferences: Bool = false,
        items: [CategoryModel] = []
    ) {
        if snapshot.numberOfSections == .zero {
            snapshot.appendSections(CategorySections.allCases)
        }
        
        for (key, value) in data {
            snapshot.appendItems(value, toSection: key)
        }
        
        dataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

// MARK: - UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        if tableView.isLastCellVisible(indexPath) {
//            Download new data
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let section = dataSource?.snapshot().sectionIdentifiers[indexPath.section],
            let item = dataSource?.snapshot().itemIdentifiers(inSection: section)[indexPath.row]
        else { return }
        print(item)
//        delegate?.didTapItem(self, index: indexPath.row, item: item)
    }
}

// MARK: - CategoryViewProtocol
extension CategoryViewController: CategoryViewProtocol {
    func presentAlert(with message: String) {
        presentBasicAlert(message: message)
    }
    
    func updateDynamicBooksDataSource(items: [CategoryModel] = []) {
        
        var listItems: [CategorySections.Item] = []
        items.forEach { category in
            let item = CategorySections.Item.list(item: category)
            listItems.append(item)
        }
        let emptyMessItem = CategorySections.Item.emptyMessage(item: "No categories!")
        
        data = [
            .category: listItems,
            .message: [emptyMessItem]
        ]
        
        applySnapshot()
    }
}

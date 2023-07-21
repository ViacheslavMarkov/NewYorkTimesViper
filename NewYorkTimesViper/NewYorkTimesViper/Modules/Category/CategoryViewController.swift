//
//  CategoryViewController.swift
//  Super easy dev
//
//  Created by Viacheslav Markov on 18.07.2023
//

import UIKit

protocol CategoryViewProtocol: AnyObject {
}

final class CategoryViewController: UIViewController {
    // MARK: - Public
    var presenter: CategoryPresenterProtocol?

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
    }
}

// MARK: - CategoryViewProtocol
extension CategoryViewController: CategoryViewProtocol {
}

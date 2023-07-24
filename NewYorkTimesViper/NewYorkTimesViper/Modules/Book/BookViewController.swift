//
//  BookViewController.swift
//  Super easy dev
//
//  Created by Viacheslav Markov on 24.07.2023
//

import UIKit

protocol BookViewProtocol: AnyObject {
    func updateDynamicBooksDataSource(books: [BookData])
}

class BookViewController: UIViewController {
    // MARK: - Public
    var presenter: BookPresenterProtocol?
    
    private typealias Snapshot = NSDiffableDataSourceSnapshot<BookSections, BookSections.Item>
    private typealias DataSource = UICollectionViewDiffableDataSource<BookSections, BookSections.Item>
    
    private var data = [BookSections: [BookSections.Item]]()
    private var dataSource: DataSource?
    private var snapshot = Snapshot()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: - Private functions
private extension BookViewController {
    func initialize() {
        setupCollectionView()
        prepareDataSource()
        presenter?.updateCollection()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.collectionViewLayout = makeLayout()
        collectionView.register(BookCollectionViewCell.nib(), forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        if snapshot.numberOfSections == .zero {
            snapshot.appendSections(BookSections.allCases)
        }
        
        for (key, value) in data {
            snapshot.appendItems(value, toSection: key)
        }
        
        dataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, layoutEnvironment in
            guard
                let self = self
//                let section = self.sectionFrom(section: sectionIndex)
            else {
                return nil
            }
            
//            switch section {
//            case .first:
                return CellLayoutFactory.makeFullWidthAndHeightWithoutHeaderCellLayout(
                    itemWidth: .fractionalWidth(1),
                    itemHeight: .estimated(60)
                )
//            }
        }, configuration: config)
    }
    
//    func sectionFrom(section: Int) -> BookSections? {
//        dataSource?.snapshot().sectionIdentifiers[section]
//    }
    
    func prepareDataSource() {
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView
        ) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item {
            case .list(item: let item):
                return self.cellForRowAt(indexPath, with: item)
            }
        }
    }
    
    func cellForRowAt(
       _ indexPath: IndexPath,
       with model: BookData
   ) -> UICollectionViewCell {
       guard
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell
       else {
           return UICollectionViewCell()
       }
       cell.configure(at: model)
       cell.delegate = self
       return cell
   }
    
    func showSafari(link: String) {
        let url = URL(string: link)
        presentSafariVC(url: url)
    }
}

// MARK: - UICollectionViewDelegate
extension BookViewController: UICollectionViewDelegate {
}

// MARK: - BookCollectionViewCellDelegation
extension BookViewController: BookCollectionViewCellDelegation {
    func didTapLink(_ sender: BookCollectionViewCell, at link: String) {
        showSafari(link: link)
    }
}

// MARK: - BookViewProtocol
extension BookViewController: BookViewProtocol {
    func updateDynamicBooksDataSource(books: [BookData]) {
        var listItems: [BookSections.Item] = []
        books.forEach { book in
            let item = BookSections.Item.list(item: book)
            listItems.append(item)
        }
        
        data = [
            .book: listItems
        ]
        
        applySnapshot()
    }
}

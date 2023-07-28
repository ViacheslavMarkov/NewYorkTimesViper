//
//  CoreDataService.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 28.07.2023.
//

import CoreData

class CoreDataService {
    
    private init() {}
    private static let managedContext = CoreDataStack.shared.managedContext
    
    static func retrieveDataFromDB() -> OverviewEntity? {
        var model: OverviewEntity?
        let request: NSFetchRequest<OverviewEntity> = OverviewEntity.fetchRequest()
        if let data = try? CoreDataStack.shared.managedContext.fetch(request) {
            model = data.first
        }
        return model
    }
    
    static func retrieveOverviewDescriptionDBModel() -> [DescriptionEntity]? {
        var models: [DescriptionEntity]?
        let request: NSFetchRequest<DescriptionEntity> = DescriptionEntity.fetchRequest()
        if let data = try? CoreDataStack.shared.managedContext.fetch(request) {
            models = data
        }
        return models
    }
    
    static func retrieveBookDBModel() -> [BookEntity]? {
        var models: [BookEntity]?
        let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        if let data = try? CoreDataStack.shared.managedContext.fetch(request) {
            models = data
        }
        return models
    }
    
    static func retrieveBuyLinksDBModel() -> [BuyLinksEntity]? {
        var models: [BuyLinksEntity]?
        let request: NSFetchRequest<BuyLinksEntity> = BuyLinksEntity.fetchRequest()
        if let data = try? CoreDataStack.shared.managedContext.fetch(request) {
            models = data
        }
        return models
    }
    
    static func save(new model: OverviewData) {
        
        CoreDataStack.shared.clearAllBD()
        
        let modelDB: OverviewEntity
        if let alreadyExistModelDB = retrieveDataFromDB() {
            modelDB = alreadyExistModelDB
        } else {
            modelDB = OverviewEntity(context: managedContext)
        }
        
        modelDB.publishedDate = model.publishedDate
        
        let list = createListOverviewDescriptionDBModel(list: model.lists)
        var nsSet: Set<DescriptionEntity> = []
        list.forEach({ item in
            nsSet.insert(item)
        })
        
        modelDB.addToList(nsSet as NSSet)
        
        CoreDataStack.shared.saveContext()
    }
    
    
    private static func createListOverviewDescriptionDBModel(list: [OverviewDescriptionData]) -> [DescriptionEntity] {
        var listDB: [DescriptionEntity]
        if let alreadyExistModelDB = retrieveOverviewDescriptionDBModel() {
            listDB = alreadyExistModelDB
        } else {
            listDB = [DescriptionEntity(context: managedContext)]
        }
        
        list.forEach { model in
            let item = DescriptionEntity(context: managedContext)
            item.listId = Int16(model.listId)
            item.displayName = model.displayName
            
            let books = createListBookDBModel(books: model.books, with: String(model.listId))
            var nsSet: Set<BookEntity> = []
            books.forEach({ item in
                nsSet.insert(item)
            })
            item.addToBooks(nsSet as NSSet)
            
            listDB.append(item)
        }
        
        return listDB
    }
    
    private static func createListBookDBModel(books: [BookData], with parentId: String) -> [BookEntity] {
        var listDB: [BookEntity]
        if let alreadyExistModelDB = retrieveBookDBModel() {
            listDB = alreadyExistModelDB
        } else {
            listDB = [BookEntity(context: managedContext)]
        }
        
        books.forEach { book in
            let item = BookEntity(context: managedContext)
            item.author = book.author
            item.descriptions = book.description
            item.imageUrlString = book.imageUrlString
            item.publisher = book.publisher
            
            let bookId = UUID().uuidString
            item.bookId = bookId
            
            let links = createListBuyLinksDBModel(links: book.buyLinks, with: bookId)
            var nsSet: Set<BuyLinksEntity> = []
            links.forEach({ item in
                nsSet.insert(item)
            })
            
            item.addToLinks(nsSet as NSSet)
            
            listDB.append(item)
        }
        
        return listDB
    }
    
    private static func createListBuyLinksDBModel(links: [BuyLinksData], with parentId: String) -> [BuyLinksEntity] {
        var listDB: [BuyLinksEntity]
        if let alreadyExistModelDB = retrieveBuyLinksDBModel() {
            listDB = alreadyExistModelDB
        } else {
            listDB = [BuyLinksEntity(context: managedContext)]
        }
        
        links.forEach { link in
            let item = BuyLinksEntity(context: managedContext)
            item.name = link.name
            item.url = link.url
            item.parentId = parentId
            
            let linkId = UUID().uuidString
            item.linkId = linkId
            
            listDB.append(item)
        }
        
        return listDB
    }
    
    static func getModelsFromDB() -> OverviewData {
        CoreDataStack.shared.clearAllBD()
        let model = retrieveDataFromDB()
        
        guard
            let listsDB = model?.list?.allObjects as? [DescriptionEntity]
        else {
            let mockData = createMockData()
            return mockData
        }
        let list = createOverviewDescriptionData(listDB: listsDB)
        
        let overview = OverviewData(
            publishedDate: model?.publishedDate ?? "",
            lists: list
        )
        
        return overview
    }
    
    private static func createOverviewDescriptionData(listDB: [DescriptionEntity]) -> [OverviewDescriptionData] {
        var list = [OverviewDescriptionData]()
        listDB.forEach({ model in
            guard
                let booksDB = model.books!.allObjects as? [BookEntity]
            else {
                return
            }
            let books = createBooksData(booksDB: booksDB)
            let item = OverviewDescriptionData(
                listId: Int(model.listId),
                displayName: model.displayName ?? "",
                books: books)
            list.append(item)
        })
        return list
    }
    
    private static func createBooksData(booksDB: [BookEntity]) -> [BookData] {
        var list = [BookData]()
        booksDB.forEach({ model in
            guard
                let linksDB = model.links?.allObjects as? [BuyLinksEntity]
            else {
                return
            }
            let links = createLinksData(linksDB: linksDB)
            let item = BookData(
                imageUrlString: model.imageUrlString ?? "",
                author: model.author ?? "",
                description: model.descriptions ?? "",
                rank: Int(model.rank),
                publisher: model.publisher ?? "",
                buyLinks: links
            )
            list.append(item)
        })
        return list
    }
    
    private static func createLinksData(linksDB: [BuyLinksEntity]) -> [BuyLinksData] {
        var list = [BuyLinksData]()
        linksDB.forEach({ model in
            let item = BuyLinksData(
                name: model.name ?? "",
                url: model.url ?? ""
            )
            list.append(item)
        })
        return list
    }
    
    private static func createMockData() -> OverviewData {
        let buyLinks: [BuyLinksData] = [
            .init(name: "Amazon",
                  url: "https://www.amazon.com/dp/1538756595?tag=NYTBSREV-20"),
            .init(name: "Apple Books",
                  url: "https://goto.applebooks.apple/9781538756591?at=10lIEQ"),
            .init(name: "Barnes and Noble",
                  url: "https://www.anrdoezrs.net/click-7990613-11819508?url=https%3A%2F%2Fwww.barnesandnoble.com%2Fw%2F%3Fean%3D9781538756591"),
            .init(name: "Books-A-Million",
                  url: "https://du-gae-books-dot-nyt-du-prd.appspot.com/redirect?url1=https%3A%2F%2Fwww.anrdoezrs.net%2Fclick-7990613-35140%3Furl%3Dhttps%253A%252F%252Fwww.booksamillion.com%252Fp%252FTOO%252BLATE%252FColleen%252BHoover%252F9781538756591&url2=https%3A%2F%2Fwww.anrdoezrs.net%2Fclick-7990613-35140%3Furl%3Dhttps%253A%252F%252Fwww.booksamillion.com%252Fsearch%253Fquery%253DTOO%252BLATE%252BColleen%252BHoover"),
            .init(name: "Bookshop",
                  url: "https://du-gae-books-dot-nyt-du-prd.appspot.com/redirect?url1=https%3A%2F%2Fbookshop.org%2Fa%2F3546%2F9781538756591&url2=https%3A%2F%2Fbookshop.org%2Fbooks%3Faffiliate%3D3546%26keywords%3DTOO%2BLATE"),
            .init(name: "IndieBound",
                  url: "https://du-gae-books-dot-nyt-du-prd.appspot.com/redirect?url1=https%3A%2F%2Fwww.indiebound.org%2Fbook%2F9781538756591%3Faff%3DNYT&url2=https%3A%2F%2Fwww.indiebound.org%2Fsearch%2Fbook%3Fkeys%3DTOO%2BLATE%2BColleen%2BHoover%26aff%3DNYT")
        ]
        let books: [BookData] = [
            .init(imageUrlString: "https://storage.googleapis.com/du-prd/books/images/9781538756591.jpg",
                  author: "Colleen Hoover",
                  description: "Dangers develop when a drug trafficker becomes obsessed with a woman who has a mutual attraction to a D.E.A. agent.",
                  rank: 1,
                  publisher: "Grand Central",
                  buyLinks: buyLinks)
        ]
        let list: [OverviewDescriptionData] = [
            .init(listId: 704,
                  displayName: "Combined Print & E-Book Fiction",
                  books: books)
        ]
        let overview = OverviewData(
            publishedDate: "2023-07-16",
            lists: list
        )
        return overview
    }
}

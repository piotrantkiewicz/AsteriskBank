import Foundation

@MainActor
protocol ProductsViewModelDelegate: AnyObject {
    func didLoadCategories()
}

class ProductsViewModel {
    
    weak var delegate: ProductsViewModelDelegate?
    
    var categories: [ProductCategoryViewModel] = []
    
    var currentCategory: ProductCategoryViewModel? {
        guard currentCategoryIndex < categories.count else { return nil }
        return categories[currentCategoryIndex]
    }
    
    private var currentCategoryIndex: Int = 0

    private let loader: ProductsLoading
    
    init(loader: ProductsLoading = ProductsRepository()) {
        self.loader = loader
        
        Task {
            categories = await provideCategories()
            await delegate?.didLoadCategories()
        }
    }
    
    func didChangeSelectedIndex(_ index: Int) {
        currentCategoryIndex = index
    }
    
    private func provideCategories() async -> [ProductCategoryViewModel] {
        guard let products = await loader.load()?
            .mapToView() else { return [] }
        
        let productCategories: [String] = ["Debit", "Deposit", "Credit", "Loan"]
        
        var categories: [String: [ProductViewModel]] = [:]
        
        for category in productCategories {
            categories[category] = []
        }
        
        for product in products {
            categories[product.categoryTitle]?.append(product)
        }
        
        return productCategories.compactMap {
            guard let products = categories[$0] else { return nil }
            return ProductCategoryViewModel(title: $0, products: products)
        }
    }
}

extension Array where Element == Product {
    func mapToView() -> [ProductViewModel] {
        self.map {
            ProductViewModel(title: $0.title, description: $0.description, imageUrl: $0.imageUrl, category: $0.category)
        }
    }
}

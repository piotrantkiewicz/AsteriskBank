import Foundation

protocol ProductsLoading {
    func load() async -> [Product]?
}

class ProductLoader: ProductsLoading {
    func load() async -> [Product]? {
        guard
            let path = Bundle.main.path(forResource: "products", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
            let products = try? JSONDecoder().decode([Product].self, from: data)
        else { return nil }
        
        return products
    }
}

import Foundation

class ProductLoader {
    func load() -> [ProductViewModel] {
        guard
            let path = Bundle.main.path(forResource: "products", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
            let products = try? JSONDecoder().decode([ProductViewModel].self, from: data)
        else { return [] }
        
        return products
    }
}

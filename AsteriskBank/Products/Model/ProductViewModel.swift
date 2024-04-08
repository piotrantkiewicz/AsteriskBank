import Foundation

struct ProductViewModel {
    let title: String
    let description: String
    let imageUrl: String
    let category: String
    
    init(title: String, description: String, imageUrl: String, category: String) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        self.category = category
    }
}

extension ProductViewModel {
    var categoryTitle: String {
        category.capitalized
    }
}

import Foundation

struct ProductViewModel: Codable {
    let title: String
    let description: String
    let imageName: String
    let category: String
    
    init(title: String, description: String, imageName: String, category: String) {
        self.title = title
        self.description = description
        self.imageName = imageName
        self.category = category
    }
}

extension ProductViewModel {
    var categoryTitle: String {
        category.capitalized
    }
}

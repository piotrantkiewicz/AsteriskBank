import Foundation
import Alamofire

struct Product: Codable {
    let title: String
    let description: String
    let imageUrl: String
    let category: String
}

class ProductsRepository: ProductsLoading {
    
    private let url = "https://asterisk-a2eec-default-rtdb.europe-west1.firebasedatabase.app/products.json"
    
    func load() async -> [Product]? {
        // Automatic String to URL conversion, Swift concurrency support, and automatic retry.
        let response = await AF.request(url, interceptor: .retryPolicy)
                               // Automatic Decodable support with background parsing.
                               .serializingDecodable([Product?].self)
                               // Await the full response with metrics and a parsed body.
                               .response
        
        return response.value?.compactMap {
            $0
        }
    }
}

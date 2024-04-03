import UIKit

class ProductsVC: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    private var categories: [ProductCategoryViewModel] = []
    private var currentCategoryIndex: Int = 0
    
    private var currentCategory: ProductCategoryViewModel {
        categories[currentCategoryIndex]
    }
    
    private var loader = ProductLoader()

    override func viewDidLoad() {
        super.viewDidLoad()
        categories = provideCategories()

        configureTableView()
        configureSegmentedControl()
    }

    func configureSegmentedControl() {
        segmentedControl.removeAllSegments()

        for (index, category) in categories.enumerated() {
            segmentedControl.insertSegment(
                withTitle: category.title,
                at: index,
                animated: false
            )
        }

        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(onSegmentControlIndexChanged), for: .valueChanged)
    }
    
    @objc
    private func onSegmentControlIndexChanged() {
        currentCategoryIndex = segmentedControl.selectedSegmentIndex
        tableView.reloadData()
    }

    func configureTableView() {
        tableView.separatorColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    private func provideCategories() -> [ProductCategoryViewModel] {
        let products = loader.load()
        
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

extension ProductsVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCategory.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell {

            let product = currentCategory.products[indexPath.row]

            cell.configure(viewModel: product)
            
            if indexPath.row == 0 {
                cell.setFirst()
            }
            
            if indexPath.row == currentCategory.products.count - 1 {
                cell.setLast()
            }

            return cell
        }

        return UITableViewCell()
    }
}

extension ProductsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentDetails()
    }
    
    private func presentDetails() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailsVC = storyboard.instantiateViewController(identifier: "ProductDetailsVC")

            show(detailsVC, sender: self)
    }
}

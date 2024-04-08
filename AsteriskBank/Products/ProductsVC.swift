import UIKit

class ProductsVC: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = ProductsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self

        configureTableView()
        configureSegmentedControl()
    }

    func configureSegmentedControl() {
        segmentedControl.removeAllSegments()

        loadSegments()
        
        segmentedControl.addTarget(self, action: #selector(onSegmentControlIndexChanged), for: .valueChanged)
    }
    
    private func loadSegments() {
        for (index, category) in viewModel.categories.enumerated() {
            segmentedControl.insertSegment(
                withTitle: category.title,
                at: index,
                animated: false
            )
        }
        
        segmentedControl.selectedSegmentIndex = 0
    }
    
    @objc
    private func onSegmentControlIndexChanged() {
        viewModel.didChangeSelectedIndex(segmentedControl.selectedSegmentIndex)
        tableView.reloadData()
    }

    func configureTableView() {
        tableView.separatorColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
    }
}

extension ProductsVC: ProductsViewModelDelegate {
    func didLoadCategories() {
        loadSegments()
        tableView.reloadData()
    }
}

extension ProductsVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.currentCategory?.products.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell, let products = viewModel.currentCategory?.products {
            
            let product = products[indexPath.row]

            cell.configure(viewModel: product)
            
            if indexPath.row == 0 {
                cell.setFirst()
            }
            
            if indexPath.row == products.count - 1 {
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

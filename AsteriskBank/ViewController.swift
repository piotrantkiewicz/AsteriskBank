import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    let productCategories = ["Debit", "Deposit", "Credit", "Loan"]
    var debitProducts: [ProductViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        debitProducts = provideProducts()

        configureTableView()
        configureSegmentedControl()
    }

    func configureSegmentedControl() {
        segmentedControl.removeAllSegments()

        for (index, category) in productCategories.enumerated() {
            segmentedControl.insertSegment(withTitle: category, at: index, animated: false)
        }

        segmentedControl.selectedSegmentIndex = 0
    }

    func configureTableView() {
        tableView.separatorColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
    }

    func provideProducts() -> [ProductViewModel] {
        var debitProducts: [ProductViewModel] = []
        let debitCategory = "Debit"

        debitProducts.append(
            ProductViewModel(
                title: "Digital Debit Card",
                description: "Description",
                imageName: "blackCard",
                category: debitCategory
            )
        )

        debitProducts.append(
            ProductViewModel(
                title: "Card name Airlines",
                description: "Debit card for travelers. Pay with miles for flights and train tickets",
                imageName: "blueCard",
                category: debitCategory
            )
        )

        debitProducts.append(
            ProductViewModel(
                title: "Card name WWF",
                description: "A debit card for those who care about nature. Interest on purchases is transferred to the WWF",
                imageName: "wwfCard",
                category: debitCategory
            )
        )

        debitProducts.append(
            ProductViewModel(
                title: "Card name Games",
                description: "Get free games and gadgets from using the card",
                imageName: "kidsCard",
                category: debitCategory
            )
        )

        debitProducts.append(
            ProductViewModel(
                title: "Card name Junior",
                description: "A card for a child linked to a parent's account",
                imageName: "petCard",
                category: debitCategory
            )
        )

        return debitProducts
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return debitProducts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell {

            let product = debitProducts[indexPath.row]

            cell.configure(viewModel: product)

            return cell
        }

        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
}

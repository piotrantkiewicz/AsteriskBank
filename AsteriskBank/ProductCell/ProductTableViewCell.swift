import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(
        viewModel: ProductViewModel
    ) {
        productImageView.image = UIImage(named: viewModel.imageName)
        titleLbl.text = viewModel.title
        descriptionLbl.text = viewModel.description
    }
}

import UIKit
import SDWebImage

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var separatorView: UIView!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    private func commonInit() {
        selectionStyle = .none
    }

    func configure(
        viewModel: ProductViewModel
    ) {
        productImageView.sd_setImage(
            with: URL(string: viewModel.imageUrl)
        )
        titleLbl.text = viewModel.title
        descriptionLbl.text = viewModel.description
    }
    
    func setFirst() {
        setCellCornerRadius([.layerMaxXMinYCorner, .layerMinXMinYCorner])
    }
    
    func setLast() {
        setCellCornerRadius([.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        separatorView.isHidden = true
    }
    
    override func prepareForReuse() {
        separatorView.isHidden = false
        background.clipsToBounds = false
    }
    
    private func setCellCornerRadius(_ corners: CACornerMask) {
        background.clipsToBounds = true
        background.layer.cornerRadius = 8
        background.layer.maskedCorners = corners
    }
}

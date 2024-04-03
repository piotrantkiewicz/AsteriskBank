import UIKit

class ProductDetailsVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let font = UIFont(name: "SpaceGrotesk-Bold", size: 34) else {
            fatalError("""
                Failed to load the "CustomFont-Light" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        titleLbl.font = font
    }
}

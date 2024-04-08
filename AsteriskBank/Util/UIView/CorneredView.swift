import UIKit

class CorneredView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        self.layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}

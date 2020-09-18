
import Foundation
import UIKit

class DetailTitleView: UIView {

    var title: String?

    init(frame: CGRect, title: String) {
        self.title = title
        super.init(frame: frame)
        setUpTitleView()
    }

    private func setUpTitleView() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height) )

        titleLabel.text = self.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        titleLabel.textColor = .white

        self.addSubview(titleLabel)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

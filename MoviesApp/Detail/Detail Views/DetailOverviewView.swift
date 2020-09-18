import Foundation
import UIKit

class DetailOverviewView: UIView {

    var overview: String?
    let overviewLabel = UILabel()

    init(frame: CGRect, overview: String) {
        self.overview = overview
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        setUpFavoriteView()
    }

    private func setUpFavoriteView() {
//        let overviewText = UITextView(frame: CGRect(x: 0, y: 0, width: self.bounds.width - 5, height: 500) )
        overviewLabel.text = self.overview
        overviewLabel.numberOfLines = 0
        overviewLabel.font = UIFont.boldSystemFont(ofSize:12)
        overviewLabel.textColor = .white
        overviewLabel.backgroundColor = .clear
        self.addSubview(overviewLabel)
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            overviewLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            overviewLabel.topAnchor.constraint(equalTo: self.topAnchor),
            overviewLabel.widthAnchor.constraint(equalToConstant: 500),
            overviewLabel.heightAnchor.constraint(equalToConstant: 500)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

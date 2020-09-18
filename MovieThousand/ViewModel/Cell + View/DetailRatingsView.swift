

import Foundation
import UIKit

class DetailRatingsView: UIView {

    var voteAverage: Double?

    init(frame: CGRect, voteAverage: Double) {
        self.voteAverage = voteAverage
        super.init(frame: frame)
        setUpRatingsView()
    }

    private func setUpRatingsView() {
        let voteAverage = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 25) )
        if let average = self.voteAverage {
            voteAverage.text = "\(average * 10)%"
        }
        voteAverage.font = UIFont.boldSystemFont(ofSize:11)
        voteAverage.textColor = .white
        voteAverage.textAlignment = .right
        self.addSubview(voteAverage)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

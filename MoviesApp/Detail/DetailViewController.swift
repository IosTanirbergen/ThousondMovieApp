import Foundation
import UIKit

class DetailViewController: UIViewController {

    var headerView: DetailHeaderView
    var titleView: DetailTitleView
    var dateView: DetailYearView
    var ratingsView: DetailRatingsView
    var overviewView: DetailOverviewView

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(headerView)
        self.view.addSubview(titleView)
        self.view.addSubview(dateView)
        self.view.addSubview(ratingsView)
        self.view.addSubview(overviewView)
    }

    init(movie: Movie) {
        let screenWidth = UIScreen.main.bounds.width
        let padding: CGFloat = 5
        let size = CGSize(width: screenWidth/2 - padding * 2, height: 25)

        self.headerView = DetailHeaderView(backDropPath: movie.backdropPath)
        self.titleView = DetailTitleView(frame: CGRect(x: padding, y: self.headerView.bounds.height, width: screenWidth, height: 50), title: movie.title)

        let titleHeight = self.titleView.frame.origin.y + self.titleView.bounds.height

        self.dateView = DetailYearView(frame: CGRect(origin: CGPoint(x: padding, y: titleHeight), size: size), date: movie.releaseDate)

        let dateViewEndPoint = self.dateView.frame.origin.x + self.dateView.bounds.width + padding

        self.ratingsView = DetailRatingsView(frame: CGRect(origin: CGPoint(x: dateViewEndPoint, y: titleHeight), size: size), voteAverage: movie.voteAverage)

        let overviewPoint = self.dateView.frame.origin.y + self.dateView.bounds.height
        self.overviewView = DetailOverviewView(frame: CGRect(x: padding, y: overviewPoint, width: screenWidth, height: 500), overview: movie.overview ?? "")

        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

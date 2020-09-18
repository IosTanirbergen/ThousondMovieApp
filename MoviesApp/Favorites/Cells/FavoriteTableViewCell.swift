import Foundation
import UIKit

class FavoriteTableViewCell: UITableViewCell, ReusableCell {

    static var reuseIdentifier: String {
        return String(describing: FavoriteTableViewCell.self)
    }

    let movieImageView = UIImageView()
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let favoriteButton = UIButton()
    var currentMovie: Movie?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieImageView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        contentView.addSubview(titleLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = .white
        dateLabel.font = UIFont.systemFont(ofSize: 10)
        contentView.addSubview(dateLabel)

        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.addTarget(self, action: #selector(removeFavorite), for: .touchUpInside)
        contentView.addSubview(favoriteButton)

        addConstraints()
    }

    private func addConstraints() {
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            self.movieImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.movieImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.movieImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.movieImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: padding),
            titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor)
        ])
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: padding),
            dateLabel.centerYAnchor.constraint(equalTo: movieImageView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            self.favoriteButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding),
            self.favoriteButton.centerYAnchor.constraint(equalTo: self.movieImageView.centerYAnchor)
        ])
    }

    func setup(movie: Movie) {
        self.titleLabel.text = movie.title
        self.dateLabel.text = "\(movie.releaseDate)"
        self.movieImageView.downloadImage(with: movie.posterPath)
        self.backgroundColor = .black
        self.selectionStyle = .none
        self.currentMovie = movie
        self.favoriteButton.setImage(UIImage(named: "isFavorite.png"), for: .normal)
    }

    @objc func removeFavorite() {
        self.currentMovie?.editFavorite()
        NotificationCenter.default.post(name: .didDeleteFavorite, object: self)
        NotificationCenter.default.post(name: .didUpdateContent, object: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

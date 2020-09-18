//
//  MovieCell.swift
//  MovieThousand
//
//  Created by Devnull on 9/18/20.
//  Copyright © 2020 Devnull. All rights reserved.
//

import Foundation
import UIKit

class DiscoverCell: UICollectionViewCell, Resuble {

    static var reuseIdentifier: String {
        return String(describing: DiscoverCell.self)
    }

    let dateLabel = UILabel()
    let movieImageView = UIImageView()
    let favoriteButton = UIButton()
    var currentMovie: Movie?

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.movieImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieImageView)

        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabel.textColor = .white
        self.dateLabel.font = UIFont.boldSystemFont(ofSize: 11)
        contentView.addSubview(self.dateLabel)

        self.favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        self.favoriteButton.addTarget(self, action: #selector(addRemoveFavorites), for: .touchUpInside)
        contentView.addSubview(self.favoriteButton)
        addConstraints()
    }

    private func addConstraints() {
        let padding: CGFloat = 5
        NSLayoutConstraint.activate([
            self.favoriteButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: padding),
            self.favoriteButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -padding)
        ])
        NSLayoutConstraint.activate([
            self.dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: padding),
            self.dateLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: padding)
        ])
        NSLayoutConstraint.activate([
            self.movieImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.movieImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.movieImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.movieImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        ])
    }

    private func extractYear(date: Date) -> String? {
        return "\(Calendar.current.component(.year, from: date))"
    }

    func setup(movie: Movie) {
        self.currentMovie = movie
        self.dateLabel.text = extractYear(date: movie.releaseDate)
        self.movieImageView.downloadImage(with: movie.posterPath)
        setFavoriteImage()
    }

    @objc func addRemoveFavorites() {
        self.favoriteButton.setImage(UIImage(named: "isFavorite.png"), for: .normal)
        self.currentMovie?.editFavorite()
        setFavoriteImage()
    }

    private func setFavoriteImage() {
        if let movie = self.currentMovie {
            self.favoriteButton.setImage(UIImage(named: movie.isFavorite() ? "isFavorite.png" : "notFavorite.png"), for: .normal)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImageView {

    func getImgUrl(imagePath: String?) -> URL{
        if let path = imagePath {
            let basePosterURL = URL(string: "https://image.tmdb.org/t/p")!
            return basePosterURL
                .appendingPathComponent("w300")
                .appendingPathComponent(path)
        }
        return URL(string: "https://www.themoviedb.org/assets/2/v4/logos/primary-green-d70eebe18a5eb5b166d5c1ef0796715b8d1a2cbc698f96d311d62f894ae87085.svg")!
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(with path: String?) {
        getData(from: getImgUrl(imagePath: path)) {
            data, response, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
            }
        }
    }
}

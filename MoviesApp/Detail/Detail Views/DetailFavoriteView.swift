import Foundation
import UIKit

class DetailFavoriteView: UIView {
    
    let favoriteButton = UIButton()
    
    private func setUpFavoriteButton() {
        self.favoriteButton.addTarget(self, action: #selector(addRemoveFavorites), for: .touchUpInside)
        self.addSubview(favoriteButton)
    }
    
    @objc func addRemoveFavorites() {
        self.favoriteButton.setImage(UIImage(named: "isFavorite.png"), for: .normal)
//        self.currentMovie?.editFavorite()
//        setFavoriteImage()
    }

//    private func setFavoriteImage() {
//        if let movie = self.currentMovie {
//            self.favoriteButton.setImage(UIImage(named: movie.isFavorite() ? "isFavorite.png" : "notFavorite.png"), for: .normal)
//        }
//    }
}

//
//  ViewController.swift
//  MovieThousand
//
//  Created by Devnull on 9/18/20.
//  Copyright © 2020 Devnull. All rights reserved.
//

import UIKit

class MovieViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
//        let search = UISearchController(se)
        
        
        //navigation setting
let viewFavoritesButton = UIBarButtonItem(title: "Favorites", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.viewFavorites(sender:)))
              viewFavoritesButton.image =  UIImage(named: "isFavorite.png")
self.navigationItem.leftBarButtonItem = viewFavoritesButton

let rightButton = UIBarButtonItem(title: "List", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.chooseListStyle(sender:)))
self.navigationItem.rightBarButtonItem = rightButton

let search = UISearchController(searchResultsController: nil)
search.searchResultsUpdater = self
search.obscuresBackgroundDuringPresentation = false
search.searchBar.placeholder = "Search Movies"
navigationItem.searchController = search
    }

    
    // Collection View
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: 400)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: IndexPath)
        return cell
    }
    
 
    // Search
    func updateSearchResults(for searchController : UISearchController) {
        guard let text = searchController.searchBar.text else { return }
    }
    
    
    
    // setting navItems for action
    @objc func chooseListStyle(sender: UIBarButtonItem) {
           let alert = UIAlertController(title: "List Style", message: "Please Select an Option", preferredStyle: .actionSheet)
           alert.addAction(UIAlertAction(title: "Now Playing", style: .default, handler: { (_) in
               self.vm.getMovies(endpoint: .nowPlaying)
           }))
           alert.addAction(UIAlertAction(title: "Upcoming", style: .default, handler: { (_) in
               self.vm.getMovies(endpoint: .upcoming)
           }))
           alert.addAction(UIAlertAction(title: "Popular", style: .default, handler: { (_) in
               self.vm.getMovies(endpoint: .popular)
           }))
           alert.addAction(UIAlertAction(title: "Top Rated", style: .default, handler: { (_) in
               self.vm.getMovies(endpoint: .topRated)
           }))
           alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
           }))
           self.present(alert, animated: true, completion: {
           })
       }
}


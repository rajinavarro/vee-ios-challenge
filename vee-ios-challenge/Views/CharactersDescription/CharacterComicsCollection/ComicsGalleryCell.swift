//
//  CharacterComicsCollectionViewController.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 13/12/20.
//

import UIKit

private let comicCollectionCell = "comicCollectionCell"

class ComicsGalleryCell: UITableViewCell {
    
    @IBOutlet var comicsGalleryCollectionView: UICollectionView!
    
    var comics: [Comic]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerCustomCell()
        comicsGalleryCollectionView.delegate = self
        comicsGalleryCollectionView.dataSource = self
    }
    
    /// Registra celulas customizadas utizadas na ComicsGalleryCell
    func registerCustomCell(){
        comicsGalleryCollectionView.register(UINib(nibName: "ComicCollectionCell", bundle: nil), forCellWithReuseIdentifier: comicCollectionCell)
    }
}


// MARK: UICollectionViewDelegate & UICollectionViewDataSource
extension ComicsGalleryCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: comicCollectionCell, for: indexPath) as? ComicCollectionCell,
           let comic = comics?[indexPath.row]{
            
            cell.setupCell(comic: comic)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ComicsGalleryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width * 0.45, height: self.frame.height * 0.7)
    }
}



//
//  CharacterComicsCollectionViewController.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 13/12/20.
//

import UIKit

class ComicsGalleryCell: UITableViewCell {

    static let IDENTIFIER = "comicsGalleryCell"
    static let NIB_NAME = "ComicsGalleryCell"

    @IBOutlet var comicsGalleryCollectionView: UICollectionView!

    var viewModel: ComicsGalleryViewModel? {
        didSet{
            DispatchQueue.main.async {
                self.comicsGalleryCollectionView.reloadData()
            }
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()

        registerCustomCell()
        comicsGalleryCollectionView.delegate = self
        comicsGalleryCollectionView.dataSource = self
    }

    /// Registra celulas customizadas utizadas na ComicsGalleryCell
    func registerCustomCell() {
        comicsGalleryCollectionView.register(UINib(nibName: ComicCollectionCell.NIB_NAME, bundle: nil), forCellWithReuseIdentifier: ComicCollectionCell.IDENTIFIER)
    }
}

// MARK: UICollectionViewDelegate & UICollectionViewDataSource
extension ComicsGalleryCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.viewModel?.numberOfItemsInSection() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return self.viewModel?.cellForItemAt(collectionView: collectionView, indexPath: indexPath) ?? UICollectionViewCell()
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ComicsGalleryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return self.viewModel?.collectionViewLayout(view: self) ?? CGSize()
    }
}

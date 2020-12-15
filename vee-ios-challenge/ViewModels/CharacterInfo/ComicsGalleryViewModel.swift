//
//  CharacterDescriptionViewModel.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 13/12/20.
//

import Foundation
import UIKit

protocol ComicsGalleryViewModelDelegate: class {
    func comicsUpdated()
}

class ComicsGalleryViewModel {

    var delegate: ComicsGalleryViewModelDelegate?
    
    var comics: [Comic]? {
        didSet{
            self.delegate?.comicsUpdated()
        }
    }
    
    init(comics: [Comic]) {
        self.comics = comics
    }
    
    /// Retorna numero de celulas na collection view de quadrinhos.
    func numberOfItemsInSection() -> Int {
        return comics?.count ?? 0
    }
    
    /// Configura celula da collection view dos quadrinhos.
    func cellForItemAt(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCollectionCell.IDENTIFIER, for: indexPath) as? ComicCollectionCell,
           let comic = comics?[indexPath.row] {

            cell.viewModel = ComicCollectionCellViewModel(comic: comic)
            
            cell.setupCell()

            return cell
        }

        return UICollectionViewCell()
    }
    
    /// Configura view layout da collection view dos quadrinhos.
    func collectionViewLayout(view: UITableViewCell) -> CGSize{
        return CGSize(width: view.frame.width * 0.45, height: view.frame.height * 0.7)
    }
}

//
//  ComicCollectionCellViewModel.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 15/12/20.
//

import Foundation
import UIKit

class ComicCollectionCellViewModel{
    
    var comic: Comic?
    
    init(comic: Comic) {
        self.comic = comic
    }
    
    /// Configura imagem do quadrinho.
    func setupComicIV(comicIV: UIImageView) -> () {
        if let comicImageURL = self.comic?.thumbnail {
            return comicIV.downloadImage(from: comicImageURL)
        }
    }

    /// Configura titulo do quadrinho.
    func setupComicLB() -> String{
        if let comicTitle = self.comic?.title {
            return comicTitle
        }
        return ""
    }

}

//
//  CharacterComicsCollectionViewController.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 13/12/20.
//

import UIKit

class ComicCollectionCell: UICollectionViewCell {

    static let IDENTIFIER = "comicCollectionCell"
    static let NIB_NAME = "ComicCollectionCell"

    @IBOutlet weak var comicIV: UIImageView!
    @IBOutlet weak var comicLB: UILabel!

    var viewModel: ComicCollectionCellViewModel? {
        didSet{
            setupCell()
        }
    }

    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    /// Configura dados da ComicCollectionCell
    func setupCell() {

        setupComicIV()
        setupComicLB()
    }

    
    /// Configura imagem do quadrinho.
    func setupComicIV() {
        viewModel?.setupComicIV(comicIV: self.comicIV)
    }

    /// Configura titulo do quadrinho.
    func setupComicLB() {
        self.comicLB.text = viewModel?.setupComicLB()
    }
}

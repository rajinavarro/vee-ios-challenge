//
//  CharacterComicsCollectionViewController.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 13/12/20.
//

import UIKit

class ComicCollectionCell: UICollectionViewCell{
    
    static let IDENTIFIER = "comicCollectionCell"
    static let NIB_NAME = "ComicCollectionCell"
    
    @IBOutlet weak var comicIV: UIImageView!
    @IBOutlet weak var comicLB: UILabel!

    var comic: Comic?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Configura dados da ComicCollectionCell
    func setupCell(comic: Comic){
        
        self.comic = comic
        
        setupComicIV()
        setupComicLB()
    }
    
    func setupComicIV(){
        if let comicImageURL = self.comic?.thumbnail{
            self.comicIV.downloadImage(from: comicImageURL)
        }
    }
    
    func setupComicLB(){
        if let comicTitle = self.comic?.title{
            self.comicLB.text = comicTitle
        }
    }
}

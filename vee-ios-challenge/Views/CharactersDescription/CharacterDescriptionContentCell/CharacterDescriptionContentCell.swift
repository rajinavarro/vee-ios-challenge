//
//  CharacterDescriptionContentCell.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 13/12/20.
//

import UIKit

class CharacterDescriptionContentCell: UITableViewCell {

    static let IDENTIFIER = "characterDescriptionContentCell"
    static let NIB_NAME = "CharacterDescriptionContentCell"
    
    
    var character: Character?
    
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var lastModificationLB: UILabel!
    @IBOutlet weak var descriptionLB: UILabel!
    @IBOutlet weak var characterImageIV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    /// Configura dados da CharacterDescriptionContentCell
    func setupCell(character: Character){
        
        self.character = character
        
        setupImageCharacterIV()
        setupNameLB()
        setupLastModificationLB()
        setupDescriptionLB()
    }
    
    func setupNameLB(){
        if let name = self.character?.name, !name.isEmpty{
            self.nameLB?.text = name
        }else{
            self.nameLB?.text = EmptyStateString.emptyName.rawValue
        }
    }
    
    func setupLastModificationLB(){
        if let lastModification = self.character?.modifiedDate?.dateFormattedToString, !lastModification.isEmpty{
            self.lastModificationLB?.text = "Last modification: \(lastModification)"
        }
    }
    
    func setupDescriptionLB(){
        if let description = self.character?.description, !description.isEmpty{
            self.descriptionLB.text = description
        }else{
            self.descriptionLB.text = EmptyStateString.emptyDescription.rawValue
        }
    }
    
    func setupImageCharacterIV(){
        if let imageCharacterLink = self.character?.thumbnail{
            self.characterImageIV?.downloadImage(from: imageCharacterLink)
        }
    }

}

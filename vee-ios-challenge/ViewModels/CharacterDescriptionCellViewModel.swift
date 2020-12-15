//
//  CharacterDescriptionTableViewCellViewModel.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 15/12/20.
//

import Foundation
import UIKit

class CharacterDescriptionCellViewModel{
    
    var character: Character?
    
    init(character: Character) {
        self.character = character
    }
    
    /// Configura nome do personagem.
    func setupNameLB() -> String {
        if let name = self.character?.name, !name.isEmpty {
            return name
        } else {
            return EmptyStateString.emptyName.rawValue
        }
    }
    
    /// Configura data da ultima modificação do personagem.
    func setupLastModificationLB() -> String {
        if let lastModification = self.character?.modifiedDate?.dateFormattedToString, !lastModification.isEmpty {
            return "Last modification: \(lastModification)"
        } else {
            return ""
        }
    }
    
    /// Configura descrição do personagem.
    func setupDescriptionLB() -> String {
        if let description = self.character?.description, !description.isEmpty {
            return description
        } else {
            return EmptyStateString.emptyDescription.rawValue
        }
    }
    
    /// Configura imagem do personagem.
    func setupCharacterImageIV(characterImageIV: UIImageView) -> () {
        if let characterImageURL = self.character?.thumbnail {
            return characterImageIV.downloadImage(from: characterImageURL)
        }
    }
}

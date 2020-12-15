//
//  HomeTableViewCellViewModel.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 15/12/20.
//

import Foundation
import UIKit

class HomeCellViewModel{
    
    var character: Character?
    
    init(character: Character) {
        self.character = character
    }
    
    /// Desempacota variavel character.
    func getCharacter(completion: @escaping(_ character: Character) -> ()) {
        if let character = self.character{
            completion( character )
        }
    }
    
    /// Configura celula de fundo da tela Home.
    func setupCellView(cellView: UIView) -> UIView {
        
        cellView.layer.cornerRadius = 12
        cellView.addShadow(color: .black, opacity: 0.4, radius: 12)
        
        return cellView
    }
    
    /// Configura botão de mais informações do personagem na celula Home.
    func setupMoreInfoButton(moreInfoBT: UIButton) -> UIButton {
        
        moreInfoBT.layer.cornerRadius = moreInfoBT.frame.height / 2
        moreInfoBT.addShadow(color: .black, opacity: 0.4, radius: 2)
        
        return moreInfoBT
    }
    
    /// Configura imagem do personagem na celula Home.
    func setupCharacterImage(characterImageIV: UIImageView) -> UIImageView {
        
        characterImageIV.roundCorners(.topLeft, radius: 12)
        characterImageIV.downloadImage(from: self.character?.thumbnail)
        
        return characterImageIV
    }
    
    /// Configura descrição do personagem na celula Home.
    func setupCharacterDescriptionLB() -> String {
        
        if let characterDescription = self.character?.description, !characterDescription.isEmpty {
            return characterDescription
        } else {
            return EmptyStateString.emptyDescription.rawValue
        }
    }
    
    /// Configura nome do personagem na celula Home.
    func setupCharacterNameLB() -> String {
        
        if let characterName = self.character?.name, !characterName.isEmpty {
            return characterName
        } else {
            return EmptyStateString.emptyName.rawValue
        }
    }
    
    /// Configura ultima modificação do personagem na celula Home.
    func setupLastModificationLB() -> String {
        
        if let lastModification = self.character?.modifiedDate?.dateFormattedToString {
            return "Last modification: \(lastModification)"
        }
        return ""
    }
}

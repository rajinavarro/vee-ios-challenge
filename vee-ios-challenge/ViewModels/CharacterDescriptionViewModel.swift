//
//  CharacterDescriptionViewModel.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 14/12/20.
//

import Foundation
import UIKit

protocol CharacterDescriptionViewModelDelegate: class{
    func comicsUpdated()
    func characterUpdated()
}

class CharacterDescriptionViewModel{
    
    weak var delegate: CharacterDescriptionViewModelDelegate?
    
    private var comicsService: ComicsService = ComicsService()
    
    var character: Character?{
        didSet{
            self.delegate?.characterUpdated()
        }
    }
    
    var comics: [Comic] = [Comic]() {
        didSet {
            self.delegate?.comicsUpdated()
        }
    }
    
    init(character: Character) {
        setCharacter(character: character)
    }
    
    func setCharacter(character: Character){
        self.character = character
    }
    
    /// Carrega quadrinhos de um personagem.
    func getComics(){
        if let characterId = self.character?.id {
            comicsService.requestComics(characterId: characterId, completion: { comics in
                self.comics = comics
            })
        }
    }
    
    /// Retorna o número de celulas da tela de informaçoes do personagem.
    func getNumberOfRowsInSection() -> Int{
        return 2
    }
    
    /// Configura celulas da tela de informações do personagem.
    func setupCustomCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell{
        
        switch indexPath.row {
        case 0:
            return setupDescriptionContentCell(tableView: tableView)
        case 1:
            return setupComicsGalleryCell(tableView: tableView)
        default:
            return UITableViewCell()
        }
    }
    
    /// Configura celula de descrição do personagem.
    func setupDescriptionContentCell(tableView: UITableView) -> UITableViewCell {
        
        if let contentCell = tableView.dequeueReusableCell(withIdentifier: CharacterDescriptionCell.IDENTIFIER) as? CharacterDescriptionCell{
            
            if let character = self.character{
                contentCell.viewModel = CharacterDescriptionCellViewModel(character: character)
                contentCell.setupCell()
            }
                        
            return contentCell
        }
        return UITableViewCell()
    }
    
    /// Configura celula dos quadrinhos que o personagem aparece.
    func setupComicsGalleryCell(tableView: UITableView) -> UITableViewCell {
        if let comicsCell = tableView.dequeueReusableCell(withIdentifier: ComicsGalleryCell.IDENTIFIER) as? ComicsGalleryCell,
           !comics.isEmpty {
            
            comicsCell.viewModel = ComicsGalleryViewModel(comics: self.comics)
            
            return comicsCell
        }
        
        return UITableViewCell()
    }
    
}

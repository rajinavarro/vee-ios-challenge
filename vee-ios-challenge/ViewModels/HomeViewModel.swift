//
//  HomeViewModel.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 10/12/20.
//

import Foundation
import UIKit

protocol HomeViewModelDelegate: class {
    func charactersUpdated()
    func signTableViewCellDelegateMethod(tableViewCell: UITableViewCell)
}

class HomeViewModel {
    
    private var homeTableViewCellViewModels: [HomeCellViewModel] = []
    
    var delegate: HomeViewModelDelegate?
    
    var offset: Int = 0
    
    var characterService: CharactersService = {
        let obj = CharactersService()
        return obj
    }()
    
    var characters: [Character] = [Character]() {
        didSet {
            self.delegate?.charactersUpdated()
        }
    }
    
    /// Carrega personagens.
    func requestCharacters(){
        
        self.characterService.requestCharacters(offset: self.offset){ (characters, offset) in
            
            self.offset = offset
            self.characters.append(contentsOf: characters)
            self.setupHomeTableViewCellViewModels(characters: characters)
        }
    }
    
    /// Configura viewModel de cada celula da tela Home.
    func setupHomeTableViewCellViewModels(characters: [Character]){
        characters.forEach({
            self.homeTableViewCellViewModels.append(HomeCellViewModel(character: $0))
        })
    }
    
    /// Ação de abrir informações de um personagem.
    func moreInfoAboutCharacter(from viewController: UIViewController, character: Character){
        
        let storyboard = UIStoryboard.init(name: CharacterDescriptionViewController.STORYBOARD_NAME,
                                           bundle: nil)
        
        let characterDescriptionVC = storyboard.instantiateViewController(withIdentifier: CharacterDescriptionViewController.IDENTIFIER) as? CharacterDescriptionViewController

        if let characterDescriptionVC = characterDescriptionVC {

            characterDescriptionVC.modalPresentationStyle = .formSheet
            
            let characterDescriptionViewModel = CharacterDescriptionViewModel(character: character)
            characterDescriptionVC.viewModel = characterDescriptionViewModel
            
            viewController.present(characterDescriptionVC, animated: true, completion: nil)
        }
    }
    
    
    /// Retorna altura de cada celula da tela Home.
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        
        if ( indexPath.row == characters.count ) && !characters.isEmpty {
            return 150
        }
        return 260
    }
    
    /// Retona o número de celular da tela Home.
    func numberOfRowsInSection() -> Int {
        
        return self.characters.count + 1
    }
    
    /// Configura celuals customizadas da tela Home.
    func setupCustomCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell{
        if (indexPath.row == characters.count) && !characters.isEmpty {
            
            return setupLoadMoreCharactersTableViewCell(tableView: tableView, indexPath: indexPath)
            
        } else if !characters.isEmpty {
            
            return setupHomeTableViewCell(tableView: tableView, indexPath: indexPath)
            
        }
        
        return UITableViewCell()
    }
    
    /// Configura reutilização da celula de carregar novos personagens
    func setupLoadMoreCharactersTableViewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        if let loadMoreCell = tableView.dequeueReusableCell(withIdentifier: LoadMoreCharactersTableViewCell.IDENTIFIER,
                                                            for: indexPath) as? LoadMoreCharactersTableViewCell {

            self.delegate?.signTableViewCellDelegateMethod(tableViewCell: loadMoreCell)
            loadMoreCell.setupCell()

            return loadMoreCell
        }

        return UITableViewCell()
    }

    /// Configura reutilização da celula dos personagens.
    func setupHomeTableViewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.IDENTIFIER, for: indexPath) as? HomeCell {
            
            cell.viewModel = homeTableViewCellViewModels[indexPath.row]
            self.delegate?.signTableViewCellDelegateMethod(tableViewCell: cell)
            cell.setupCell()
            
            return cell
        }

        return UITableViewCell()
    }

}



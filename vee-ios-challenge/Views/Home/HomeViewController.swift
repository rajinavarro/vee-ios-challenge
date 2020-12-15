//
//  HomeViewController.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 10/12/20.
//

import UIKit

class HomeViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var offset: Int = 0
    
    lazy var viewModel: HomeViewModel = {
        let obj = HomeViewModel()
        obj.delegate = self
        return obj
    }()
    
    var characters: [Character] = [Character]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCustomTableViewCell()
        viewModel.getCharacters(offset: offset)
    }
    
    
    /// Registra celulas cutomizadas utilizadas na tableView
    func registerCustomTableViewCell(){
        tableView.register(UINib(nibName: HomeTableViewCell.NIB_NAME, bundle: nil), forCellReuseIdentifier: HomeTableViewCell.IDENTIFIER)
        tableView.register(UINib(nibName: LoadMoreCharactersTableViewCell.NIB_NAME, bundle: nil), forCellReuseIdentifier: LoadMoreCharactersTableViewCell.IDENTIFIER)
    }
    
    
    /// Configura reutilização da celula de carregar novos personagens
    func setupLoadMoreCharactersTableViewCell(indexPath: IndexPath) -> UITableViewCell{
        if let loadMoreCell = tableView.dequeueReusableCell(withIdentifier: LoadMoreCharactersTableViewCell.IDENTIFIER, for: indexPath) as? LoadMoreCharactersTableViewCell{
            
            loadMoreCell.setupLoadMoreTableViewCell()
            loadMoreCell.delegate = self
            
            return loadMoreCell
        }
        
        return UITableViewCell()
    }
    
    
    /// Configura reutilização da celula dos personagens.
    func setupHomeTableViewCell(indexPath: IndexPath) -> UITableViewCell{
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.IDENTIFIER, for: indexPath) as? HomeTableViewCell{
            
            cell.setupCell(character: characters[indexPath.row])
            cell.delegate = self
            
            return cell
        }
        
        return UITableViewCell()
    }

}


// MARK: UITableViewDelegate & UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == ( characters.count ) && !characters.isEmpty{
            return 150
        }
        return 260
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == ( characters.count ) && !characters.isEmpty{
            
            return setupLoadMoreCharactersTableViewCell(indexPath: indexPath)
            
        } else if !characters.isEmpty{
         
            return setupHomeTableViewCell(indexPath: indexPath)
            
        }
        
        return UITableViewCell()
    }
}


// MARK: HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate{
    
    /// Ação chamada quando carregamento de personagens termina.
    func finishFetchCharacters(characters: [Character], offset: Int) {
        self.characters.append(contentsOf: characters)
        self.offset += offset
    }
    
    func failFetchingCharacters(errorMessage: String) {
        print("erro")
    }
}


// MARK: HomeTableViewCellDelegate
extension HomeViewController: HomeTableViewCellDelegate{
    
    /// Ação de ver mais informações de um personagem
    func moreInfoAction(character: Character) {
        
        let storyboard = UIStoryboard.init(name: CharacterDescriptionViewController.STORYBOARD_NAME, bundle: nil)
        let characterDescriptionVC = storyboard.instantiateViewController(withIdentifier: CharacterDescriptionViewController.IDENTIFIER) as? CharacterDescriptionViewController
        
        if let characterDescriptionVC = characterDescriptionVC{
            
            characterDescriptionVC.modalPresentationStyle = .formSheet
            characterDescriptionVC.character = character
            
            self.present(characterDescriptionVC, animated: true, completion: nil)
        }
    }
}


// MARK: LoadMoreCharactersTableViewCellDelegate
extension HomeViewController: LoadMoreCharactersTableViewCellDelegate{
    
    /// Carrega novos personagens quando botão de "Carregar mais" for clicado.
    func loadMoreCharacters() {
        
        self.viewModel.getCharacters(offset: self.offset + 50)
    }
}



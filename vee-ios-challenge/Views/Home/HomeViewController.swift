//
//  HomeViewController.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 10/12/20.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        viewModel.requestCharacters()
        registerCustomTableViewCell()
    }
    
    
    /// Registra celulas cutomizadas utilizadas na tableView
    func registerCustomTableViewCell() {
        
        tableView.register(UINib(nibName: HomeCell.NIB_NAME, bundle: nil), forCellReuseIdentifier: HomeCell.IDENTIFIER)
        
        tableView.register(UINib(nibName: LoadMoreCharactersTableViewCell.NIB_NAME, bundle: nil), forCellReuseIdentifier: LoadMoreCharactersTableViewCell.IDENTIFIER)
        
    }
}

// MARK: UITableViewDelegate & UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return self.viewModel.setupCustomCell(tableView: tableView, indexPath: indexPath)
    }
}

// MARK: HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    
    /// Define delegate das celulas customizadas da tela Home.
    func signTableViewCellDelegateMethod(tableViewCell: UITableViewCell) {
        if let tableViewCell = tableViewCell as? HomeCell {
            tableViewCell.delegate = self
            
        } else if let tableViewCell = tableViewCell as? LoadMoreCharactersTableViewCell {
            tableViewCell.delegate = self
        }
    }
    
    /// Personagens foi atualizado.
    func charactersUpdated() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: HomeTableViewCellDelegate
extension HomeViewController: HomeCellDelegate {
    
    /// Ação de ver mais informações de um personagem
    func moreInfoAction(character: Character) {
        self.viewModel.moreInfoAboutCharacter(from: self, character: character)
    }
}

// MARK: LoadMoreCharactersTableViewCellDelegate
extension HomeViewController: LoadMoreCharactersTableViewCellDelegate {
    
    /// Carrega novos personagens quando botão de "Carregar mais" for clicado.
    func loadMoreCharacters() {
        self.viewModel.requestCharacters()
    }
}

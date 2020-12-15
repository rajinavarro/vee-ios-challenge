//
//  CharacterDescriptionViewController.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 12/12/20.
//

import UIKit

class CharacterDescriptionViewController: UIViewController {

    static let IDENTIFIER = "characterDescriptionVC"
    static let STORYBOARD_NAME = "CharacterDescription"

    @IBOutlet weak var characterDescriptionTableView: UITableView!

    var viewModel: CharacterDescriptionViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.delegate = self
        registerCustomTableViewCell()
        getCharacterComics()
    }

    /// Carrega todos quadrinhos de um personagem.
    func getCharacterComics() {
        
        self.viewModel?.getComics()
    }

    /// Registra XIB das custom cell utilizadas
    func registerCustomTableViewCell() {

        characterDescriptionTableView.register(UINib(nibName: CharacterDescriptionCell.NIB_NAME, bundle: nil), forCellReuseIdentifier: CharacterDescriptionCell.IDENTIFIER)

        characterDescriptionTableView.register(UINib(nibName: ComicsGalleryCell.NIB_NAME, bundle: nil), forCellReuseIdentifier: ComicsGalleryCell.IDENTIFIER)
    }

    }

// MARK: UITableViewDelegate & UITableViewDataSource
extension CharacterDescriptionViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.getNumberOfRowsInSection() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return self.viewModel?.setupCustomCell(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
    }

}

// MARK: CharacterComicDelegate
extension CharacterDescriptionViewController: CharacterDescriptionViewModelDelegate {
    
    /// Quadrinhos foram atualizados.
    func comicsUpdated() {
        DispatchQueue.main.async {
            self.characterDescriptionTableView.reloadData()
        }
    }
    
    /// Personagens foram atualizados.
    func characterUpdated(){
        DispatchQueue.main.async {
            self.characterDescriptionTableView.reloadData()
        }
    }
}

//
//  HomeViewController.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 10/12/20.
//

import UIKit

class HomeViewController: UIViewController{
    
    
    lazy var viewModel: HomeViewModel = {
        let obj = HomeViewModel()
        obj.delegate = self
        return obj
    }()
    
    var heroes = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getHeroes()
    }
}

extension HomeViewController: HomeViewModelDelegate{
    func finishFetchCharacters(characters: [Result]) {
        self.heroes.append(contentsOf: characters)
    }
    
    func failFetchingCharacters(errorMessage: String) {
        print("erro")
    }
    
    
}

//
//  PokedexViewController.swift
//  PokemonApp
//
//  Created by Hugo Regadas on 16/11/2022.
//

import Foundation
import UIKit

class PokedexViewController: UIViewController{
    //MARK: - Iboutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    //MARK: - Private properties
    private let viewModel = PokedexViewModel(serviceAPI: ServiceManager.shared)
    
    //MARK: - Cicle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        fecthPokemonData()
        initUI()
    }
}

//MARK: - Private methods
private extension PokedexViewController {
    //MARK: initialize User Interface
    func initUI(){
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "PokedexCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        
    }
    
    func fecthPokemonData(){
        viewModel.fetchPokemonList { [self] in
            reloadCollectionView()
        }
    }
    
    func fetchPokemonWith(name : String) {
        viewModel.isFilter = true
        viewModel.fetchPokemon(with: name) { [self] in
           reloadCollectionView()
        }
    }
    
    func reloadCollectionView(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

//MARK: - CollectionViewDelegate and DataSource
extension PokedexViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfPokemons()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PokedexCollectionViewCell
        cell.configureViewModel(viewModel: viewModel.getPokemonViewModel(with: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 40)/2, height: 100)
    }
    
    //Use for interspacing
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

//MARK: - Search Bar delegate
extension PokedexViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let name = textField.text {
            if (name.count != 0) {
                fetchPokemonWith(name: name)
            }else{
                viewModel.isFilter = false
                reloadCollectionView()
            }
        }
        textField.resignFirstResponder()
        return true
    }
}



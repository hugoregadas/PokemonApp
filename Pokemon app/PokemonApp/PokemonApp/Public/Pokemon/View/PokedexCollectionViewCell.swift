//
//  PokedexCollectionViewCell.swift
//  PokemonApp
//
//  Created by Hugo Regadas on 16/11/2022.
//

import UIKit

class PokedexCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ordeView: UIView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var ordelLabel: UILabel!
    
    private var viewModel: PokemonCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 10
        layer.borderColor =  UIColor.gray.cgColor
        layer.borderWidth = 0.5
        ordeView.layer.borderColor =  UIColor.gray.cgColor
        ordeView.layer.borderWidth = 0.5
        ordelLabel.layer.borderWidth = 0.5
        ordelLabel.layer.borderColor =  UIColor.gray.cgColor
        ordelLabel.layer.cornerRadius = ordelLabel.frame.height/2
    }
    
    //MARK: - configureViewModel
    func configureViewModel(viewModel: PokemonCellViewModel){
        self.viewModel = viewModel
        viewModel.delegate = self
        
        if viewModel.updatedData {
            updateCollectionView()
        }else {
            loading.startAnimating()
        }
    }

}

//MARK: - PokemonCellViewModelDelegate
extension PokedexCollectionViewCell : PokemonCellViewModelDelegate {
    func updateCollectionView() {
        DispatchQueue.main.async {
            guard let viewModel = self.viewModel else {
                return
            }
            
            self.pokemonImage.image = viewModel.getPokemonImage()
            self.titleLabel.text = viewModel.getPokemonName()
            self.ordeView.backgroundColor =  viewModel.getBackgroundColor()
            self.ordelLabel.text = viewModel.getPokemonNumber()
            self.loading.stopAnimating()
            self.loading.isHidden = true
        }
    }
}

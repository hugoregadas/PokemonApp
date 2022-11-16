//
//  PokedexCollectionViewCell.swift
//  PokemonApp
//
//  Created by Hugo Regadas on 16/11/2022.
//

import UIKit

class PokedexCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var typeOneLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeTwoLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 10
        typeOneLabel.layer.cornerRadius = 10
        typeOneLabel.layer.masksToBounds = true
        typeTwoLabel.layer.cornerRadius = 10
        typeTwoLabel.layer.masksToBounds = true
    }

}

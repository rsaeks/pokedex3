//
//  PokeCell.swift
//  pokedex3
//
//  Created by Randy Saeks on 4/16/17.
//  Copyright © 2017 Randy Saeks. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbimage: UIImageView!
    @IBOutlet weak var nameLebel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        nameLebel.text = self.pokemon.name.capitalized
        thumbimage.image = UIImage(named: String(self.pokemon.id))
    }
    
}

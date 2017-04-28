//
//  ViewController.swift
//  pokedex3
//
//  Created by Randy Saeks on 4/16/17.
//  Copyright © 2017 Randy Saeks. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonArray = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
            collection.dataSource = self
            collection.delegate = self
        parsePokemonCSV()
        initAudio()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    func initAudio() {
        let musicPath = Bundle.main.path(forResource: "music", ofType: "mp3")
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: musicPath!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            //musicPlayer.play()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            for i in rows {
                let pokeID = Int(i["id"]!)!
                let pokeName = i["identifier"]!
                let poke = Pokemon(name: pokeName, id: pokeID)
                pokemonArray.append(poke)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let pokemon: Pokemon!
            
            if inSearchMode {
                pokemon = filteredPokemon[indexPath.row]
                cell.configureCell(pokemon: pokemon)
            }
            else {
                pokemon = pokemonArray[indexPath.row]
                cell.configureCell(pokemon: pokemon)
            }
                return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokemonArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    @IBAction func musicButtonPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.35
        }
        else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
        }
        else {
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemonArray.filter( { $0.name.range(of: lower) != nil } )
            collection.reloadData()
        }
    }
}

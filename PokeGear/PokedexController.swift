//
//  PokedexViewController.swift
//  PokeGear
//
//  Created by Viraj Shah on 7/17/16.
//  Copyright © 2016 Vetek Systems. All rights reserved.
//

import UIKit

class PokedexController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pokedexEntryContainer: UIView = {
        let pokedexContainer = UIView()
        pokedexContainer.translatesAutoresizingMaskIntoConstraints = false
        //pokedexContainer.backgroundColor = UIColor.blueColor()
        return pokedexContainer
    }()
    
    var pokedex: [PokedexEntry]?
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.hidesBackButton = true
    let backButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(back))
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.title = "National Pokédex"
        
    let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(showSearchBar))
    self.navigationItem.rightBarButtonItem = searchButton
            
    collectionView?.backgroundColor = UIColor.white
    collectionView?.register(PokedexEntryCell.self, forCellWithReuseIdentifier: "cellId")
    fetchPokemon()

    }
    
    
    func fetchPokemon(){
        
        self.pokedex = [PokedexEntry]()

        
        if let path = Bundle.main.path(forResource: "pokemon", ofType: "json") {
            
            do {
                
                let data = try(Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe))
                
                let json = try(JSONSerialization.jsonObject(with: data, options: .mutableContainers))
                
                for dictionary in json as! [[String: AnyObject]] {
                    
                    
                    print(dictionary["Name"])
                    let pokedexs = PokedexEntry()
                    //
                                        pokedexs.pokemonName = dictionary["Name"] as? String
                                        pokedexs.pokemonNumber = dictionary["PkMn"] as? String
                    pokedexs.pokemonSprite = dictionary["PkMn"] as? String
                    //                    pokedexs.pokemonNumber = dictionary["PkMn"] as? String
                    //                    pokedexs.pokemonSprite = dictionary["PkMn"] as? String
                                        self.pokedex?.append(pokedexs)
                    }
                
            } catch let err {
                print(err)
            }
            collectionView?.reloadData()

            
        }

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokedex?.count ?? 0
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.cellForItem(at: indexPath)?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 1.0,
                                   delay: 0,
                                   usingSpringWithDamping: 0.4,
                                   initialSpringVelocity: 4.0,
                                   options: UIViewAnimationOptions.allowUserInteraction,
                                   animations: {
                                    self.collectionView?.cellForItem(at: indexPath)!.transform = CGAffineTransform.identity
            }, completion:{
                (value: Bool) in
                self.back()
        })

    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PokedexEntryCell
        
        cell.pokeEntry = pokedex?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func showSearchBar(){
        //Prompt users for Pokemon Name
        
        
//        //Remove
//        pokedex?.removeAll()
//        let pokedexs = PokedexEntry()
//        pokedexs.pokemonName = "Abra"
//        pokedexs.pokemonNumber = "63"
//        pokedexs.pokemonSprite = "63"
//        self.pokedex?.append(pokedexs)

    }

    func back() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: nil)
    }
    
    
}

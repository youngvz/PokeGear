//
//  PokedexEntryCell.swift
//  PokeGear
//
//  Created by Viraj Shah on 7/18/16.
//  Copyright © 2016 Vetek Systems. All rights reserved.
//

import UIKit



class PokedexEntryCell: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    var pokeEntry: PokedexEntry?{
        didSet {
            
            
            setupSpriteImage()
            
        }
    }
    
    func setupSpriteImage(){
        
            DispatchQueue.main.async(execute: {
                
                if let pokeName = self.pokeEntry?.pokemonName{
                    self.pokemonName.text = pokeName
                }
                
                if let pokeNumber = self.pokeEntry?.pokemonNumber{
                    self.pokemonNumber.text = "#" + pokeNumber
                }

                if let pokeSprite = self.pokeEntry?.pokemonSprite{
                    self.pokemonSprite.image = UIImage(named: pokeSprite)
                }
        })
    }
    
    let pokemonBall: UIImageView = {
        let imageView = UIImageView()
        //            imageView.backgroundColor = UIColor.blueColor()
        imageView.image = UIImage(named: "Pokeball")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let pokemonSprite: UIImageView = {
        let imageView = UIImageView()
        //            imageView.backgroundColor = UIColor.blueColor()
        imageView.image = UIImage(named: "1")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let pokemonNumber: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "#001"
        textLabel.font = UIFont.systemFont(ofSize: 22)
        textLabel.textColor = UIColor.black
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
        
    }()
    
    let pokemonName: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "Bulbasaur"
        textLabel.font = UIFont.systemFont(ofSize: 22)
        textLabel.textColor = UIColor.black
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
        
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews(){
        backgroundColor = UIColor.white
        
        addSubview(pokemonBall)
        addSubview(pokemonNumber)
        addSubview(pokemonName)
        addSubview(pokemonSprite)
        addSubview(seperatorView)
        
        
        pokemonBall.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6).isActive = true
        pokemonBall.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        pokemonBall.widthAnchor.constraint(equalToConstant: 40).isActive = true
        pokemonBall.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        pokemonNumber.leftAnchor.constraint(equalTo: pokemonBall.rightAnchor, constant: 6).isActive = true
        pokemonNumber.centerYAnchor.constraint(equalTo: pokemonBall.centerYAnchor).isActive = true
        pokemonNumber.widthAnchor.constraint(equalToConstant: 80).isActive = true
        pokemonNumber.heightAnchor.constraint(equalTo: pokemonBall.heightAnchor).isActive = true
        
        pokemonName.leftAnchor.constraint(equalTo: pokemonNumber.rightAnchor, constant: -12).isActive = true
        pokemonName.centerYAnchor.constraint(equalTo: pokemonNumber.centerYAnchor).isActive = true
        pokemonName.widthAnchor.constraint(equalToConstant: 140).isActive = true
        pokemonName.heightAnchor.constraint(equalTo: pokemonSprite.heightAnchor).isActive = true
        
        pokemonSprite.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6).isActive = true
        pokemonSprite.centerYAnchor.constraint(equalTo: pokemonBall.centerYAnchor).isActive = true
        pokemonSprite.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pokemonSprite.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        seperatorView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        seperatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        seperatorView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

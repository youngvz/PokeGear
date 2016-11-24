//
//  CustomTabBarController.swift
//  PokeGear
//
//  Created by Viraj Shah on 7/17/16.
//  Copyright © 2016 Vetek Systems. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup Custom View Controllers
        //let layout = UICollectionViewFlowLayout
        
        let mapViewController = MapViewController()
        mapViewController.tabBarItem = UITabBarItem(title: "Pokédex", image: UIImage(named: "pokedex"), selectedImage: UIImage(named: "pokedex_filled"))
        
        let pokemonController = PokemonViewController()
        let navPokemonController = UINavigationController(rootViewController: pokemonController)
        navPokemonController.tabBarItem = UITabBarItem(title: "Poké Checker", image: UIImage(named: "pokeball"), selectedImage: UIImage(named: "pokeball_filled"))
        
        
    
        viewControllers = [mapViewController, navPokemonController, createDummyNavControllerWithTitle("Poké Chat", imageName: "chat", filled: "chat_filled"), createDummyNavControllerWithTitle("Trainer", imageName: "Profile",filled: "Profile_filled")]
        
    }
    
    fileprivate func createDummyNavControllerWithTitle(_ title: String, imageName: String, filled: String) -> UINavigationController {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        
        navController.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: filled))
        
        UITabBar.appearance().tintColor = UIColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)

        return navController
    }
    
    }

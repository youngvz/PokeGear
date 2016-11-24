//
//  PokedexViewController.swift
//  PokeGear
//
//  Created by Viraj Shah on 7/17/16.
//  Copyright © 2016 Vetek Systems. All rights reserved.
//

import UIKit

class PokedexController: UINavigationController {
    
    
    let searchBarContainer: UIView = {
        let searchContainer = UIView()
        searchContainer.translatesAutoresizingMaskIntoConstraints = false
        searchContainer.backgroundColor = UIColor.blackColor()
        return searchContainer
    }()
    
        override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true

        let backButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem = backButton;
        navigationItem.title = "Kanto Region"
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: #selector(handleSearch))
        navigationItem.rightBarButtonItem = searchButton
        setupSearchBarContainer()
        navigationBar.barTintColor = UIColor.redColor()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationBar.tintColor = UIColor.whiteColor()
        view.backgroundColor = UIColor.redColor()

        self.navigationController?.navigationItem.title = "POOP"
        setupSearchBarContainer()

    }
    override func viewDidAppear(animated: Bool) {
        //navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationItem.title = "POOP"

       // navigationController!.navigationBar.barTintColor = UIColor.redColor()

    }
    
    
    func setupSearchBarContainer(){
        
        view.addSubview(searchBarContainer)
        
        searchBarContainer.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        searchBarContainer.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 60).active = true
        searchBarContainer.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true
        searchBarContainer.heightAnchor.constraintEqualToConstant(60).active = true
        
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func handleSearch(){
        

    }
    
    func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

//
//  PokemonViewController.swift
//  PokeGear
//
//  Created by Viraj Shah on 7/17/16.
//  Copyright © 2016 Vetek Systems. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, UITextFieldDelegate{
    
    
    //UI Containers
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let imagesContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let addScreenshotContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let addScreenshotSubContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cameraButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "camera"), for: UIControlState())
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    lazy var submitButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Catch Pokemon!!", for: UIControlState())
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(handleSubmit), for: .touchDown)
        return btn
    }()
    func handleSubmit(){
        submitButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 2.0,
                                   delay: 0,
                                   usingSpringWithDamping: 0.2,
                                   initialSpringVelocity: 6.0,
                                   options: UIViewAnimationOptions.allowUserInteraction,
                                   animations: {
                                    self.submitButton.transform = CGAffineTransform.identity
            }, completion: nil)
        print(1234)
    }
    func  handleRelease(){
        submitButton.backgroundColor = UIColor.red
    }
    
    let addScreenshotLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Screenshot"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let button: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "search_filled"), for: UIControlState())
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    var pokemonEntries: [String:String]?
    
    func populatePokemonEntries(){
        var pokemons = [String]()
        
        //Creates an array of dictionaries with the key = Name for Value = PkMN
        //Sets autoCompleteStrings to an array of pokemon
        if let path = Bundle.main.path(forResource: "pokemon", ofType: "json") {
            
            do {
                
                let data = try(Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe))
                
                let json = try(JSONSerialization.jsonObject(with: data, options: .mutableContainers))
                
                for dictionary in json as! [[String: AnyObject]] {
                    
                    if let pokemon = dictionary["Name"] as? String, let pokemonNumber = dictionary["PkMn"] as? String{
                        //self.pokemonEntries![pokemon] = pokemonNumber
                        //dict["email"] = "john.doe@email.com"

                        print(pokemon)
                        pokemonEntries?[pokemon] = pokemonNumber
                        
                        
                        pokemons.append(pokemon)
                    }

                }
                
            } catch let err {
                print(err)
            }
            
            
        }

        
        
    }
    
    
    var attributes = [String:AnyObject]()
    
    lazy var autocompleteTextfield: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.white
        tf.placeholder = "Pokemon Name"
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textAlignment = NSTextAlignment.left
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = UITextBorderStyle.roundedRect
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.keyboardType = UIKeyboardType.default
        tf.returnKeyType = UIReturnKeyType.done
        tf.clearButtonMode = UITextFieldViewMode.whileEditing;
        tf.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        tf.delegate = self
        return tf
    }()
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true;
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("TextField should snd editing method called")
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called")
        
        if let textInputed = textField.text{
            
            print(pokemonEntries?[textInputed])

            if let spriteName = pokemonEntries?[textInputed]{
            
                print(spriteName)
            pokemonSpriteImage.image = UIImage(named: spriteName)
            
            }
   
        }
        if textField.text?.isEmpty == true {
            pokemonSpriteImage.image = UIImage(named: "?")
            autocompleteTextfield.text = "Pokemon not found"
            autocompleteTextfield.textAlignment = .center
        }
        
        textField.resignFirstResponder();
        return true;
    }
    
    let pokemonSpriteImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = "Poké Catcher"
        
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(catchPokemon), for: .touchUpInside)
        let infoBarButtonItem = UIBarButtonItem(customView: infoButton)
        navigationItem.rightBarButtonItem = infoBarButtonItem
        
        view.backgroundColor = UIColor.lightGray
        populatePokemonEntries()
        setupInputsContainerView()
        
    }
    
    func setupInputsContainerView(){
        
        view.addSubview(inputsContainerView)
        inputsContainerView.addSubview(autocompleteTextfield)
        view.addSubview(imagesContainerView)
        imagesContainerView.addSubview(pokemonSpriteImage)
        view.addSubview(addScreenshotContainerView)
        addScreenshotContainerView.addSubview(addScreenshotSubContainerView)
        addScreenshotSubContainerView.addSubview(addScreenshotLabel)
        addScreenshotSubContainerView.addSubview(cameraButton)
        view.addSubview(submitButton)

        
        
        //x,y,w,h constraints
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 68).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        autocompleteTextfield.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 6 ).isActive = true
        autocompleteTextfield.topAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: 5).isActive = true
        autocompleteTextfield.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -10).isActive = true
        autocompleteTextfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        imagesContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imagesContainerView.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 3).isActive = true
        imagesContainerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imagesContainerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        pokemonSpriteImage.centerXAnchor.constraint(equalTo: imagesContainerView.centerXAnchor).isActive = true
        pokemonSpriteImage.centerYAnchor.constraint(equalTo: imagesContainerView.centerYAnchor).isActive = true
        pokemonSpriteImage.widthAnchor.constraint(equalToConstant: 64).isActive = true
        pokemonSpriteImage.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        addScreenshotContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addScreenshotContainerView.topAnchor.constraint(equalTo: imagesContainerView.bottomAnchor, constant: 5).isActive = true
        addScreenshotContainerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        addScreenshotContainerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addScreenshotSubContainerView.centerYAnchor.constraint(equalTo: addScreenshotContainerView.centerYAnchor).isActive = true
        addScreenshotSubContainerView.centerXAnchor.constraint(equalTo: addScreenshotContainerView.centerXAnchor).isActive = true
        addScreenshotSubContainerView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        addScreenshotSubContainerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
        
        addScreenshotLabel.topAnchor.constraint(equalTo: addScreenshotSubContainerView.topAnchor).isActive = true
        addScreenshotLabel.rightAnchor.constraint(equalTo: addScreenshotSubContainerView.rightAnchor).isActive = true
        addScreenshotLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        addScreenshotLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        cameraButton.leftAnchor.constraint(equalTo: addScreenshotSubContainerView.leftAnchor).isActive = true
        cameraButton.centerYAnchor.constraint(equalTo: addScreenshotLabel.centerYAnchor).isActive = true
        cameraButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cameraButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        submitButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        submitButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        
    }

    func catchPokemon() {
    
        print(321)
    }
}

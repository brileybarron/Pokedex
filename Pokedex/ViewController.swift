//
//  ViewController.swift
//  Pokedex
//
//  Created by Briley Barron on 11/12/18.
//  Copyright © 2018 Briley Barron. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var outputTextView: UITextView!
    var pokedexAPIbaseURL = "https://pokeapi.co/api/v2/pokemon/"
    var spriteURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
    var pokeIndex = "1"
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        //checking to see if the values are there
        guard let pokemonIndex = input.text else {
                return
        }
        
        //clear out the text field
        input.text = ""

        
        //Replacing all spaces with a "+" for the URL
        let pokemonURLComponent = pokemonIndex.replacingOccurrences(of: " ", with: "+")

        //building the complete request URL
        let requestURL = pokedexAPIbaseURL + pokemonURLComponent
        
        Alamofire.request(requestURL).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                self.outputTextView.text = String(describing: json)
                self.pokeIndex = json["game_indices"]["game_index"].stringValue
            case .failure(let error):
                self.outputTextView.text = "Invalid selection entered or an error occured.  Please try Again!"
                print(error.localizedDescription)
            }
        }
        let pokeIndexComponent = pokeIndex + ".png"
        let spriteRequestURL = spriteURL + pokeIndexComponent
        Alamofire.request(spriteRequestURL).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                self.outputTextView.text = String(describing: json)
                self.pokeIndex = json["game_indices"]["game_index"].stringValue
            case .failure(let error):
                self.outputTextView.text = "Invalid selection entered or an error occured.  Please try Again!"
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}


//
//  ViewController.swift
//  who is that pokemon
//
//  Created by Alex Camacho on 01/08/22.
//

import UIKit
import Kingfisher

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    
    lazy var pokemonManager = PokemonManager()
    lazy var imageManager = ImageManager()
    lazy var gameModel = GameModel()
    
    var ramdom4Pokemons : [PokemonModel] = [] {
        //Ejecuta una funcion cuando la variable es llenada
        didSet {
            setButtonsTitles()
        }
    }
    var correctAnswer : String = ""
    var correctAnswerImage : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        pokemonManager.delegate = self
        imageManager.delegate = self
        
        createButtons()
        pokemonManager.fetchPokemonApi()
        lblMessage.text = ""
    }
    
    func createButtons(){
        for button in answerButtons{
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
            button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 0
            button.layer.masksToBounds = false
            button.layer.cornerRadius = 10.0
            
        }
    }
    
    func setButtonsTitles(){
        for  (index, button) in  answerButtons.enumerated() {
            DispatchQueue.main.async { [self] in
                button.setTitle(ramdom4Pokemons[safe:index]?.name.capitalized, for: .normal)
            }
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let userAnswer = (sender.title(for: .normal) ?? "")
        
        if self.gameModel.checkAnswer(userAnswer, correctAnswer) {
            self.lblMessage.text = "Sí, es un \(userAnswer.capitalized)"
            lblScore.text = "Puntaje \(gameModel.getScore())"
            
            sender.layer.borderColor = UIColor.systemGreen.cgColor
            sender.layer.borderWidth = 2
    
            let url = URL(string: correctAnswerImage)
            pokemonImg.kf.setImage(with: url)
            
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false){ timer in
                self.pokemonManager.fetchPokemonApi()
                self.lblMessage.text = ""
                sender.layer.borderWidth = 0
            }
            
        } else {
            self.lblMessage.text = "No, es un \(userAnswer.capitalized)"
            
            sender.layer.borderColor = UIColor.systemRed.cgColor
            sender.layer.borderWidth = 2
            
            let url = URL(string: correctAnswerImage)
            pokemonImg.kf.setImage(with: url)
            gameModel.setScore(score: 0)
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false){ timer in
                self.resetGame()
                sender.layer.borderWidth = 0
            }
            
        }
    }
    
    func resetGame() {
        self.pokemonManager.fetchPokemonApi()
        gameModel.setScore(score: 0)
        lblScore.text = "Puntaje: \(gameModel.getScore())"
        
        self.lblMessage.text = ""
        
    }
}

extension PokemonViewController: PokemonManagerDelegate {
    func didUpdatePokemon(pokemons: [PokemonModel]) {
        ramdom4Pokemons = pokemons.choose(4)
        let index = Int.random(in: 0...3)
        let imageData = ramdom4Pokemons[index].imageUrl
        correctAnswer = ramdom4Pokemons[index].name
        
        imageManager.fetchImage(url:imageData)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension PokemonViewController : ImageManagerDelegate {
    func didUpdateImage(image: ImageModel) {
        correctAnswerImage = image.imageUR
        
        DispatchQueue.main.async {
            let url = URL(string: image.imageUR)
            let effect = ColorControlsProcessor(brightness: -1, contrast: 1, saturation: 1, inputEV: 0)
            self.pokemonImg.kf.setImage(with: url, options: [.processor(effect)])
        }
        
        
        print(image.imageUR)
    }
    
    func didFailWithErrorImage(error: Error) {
        print(error)
    }
    
    
}


extension Collection where Indices.Iterator.Element == Index {
    /// Accede de manera segura a un elemento de la colección mediante un índice dado.
        ///
        /// - Parameter index: El índice del elemento que se quiere acceder.
        /// - Returns: El elemento correspondiente al índice dado, o `nil` si el índice está fuera de los límites de la colección.
    subscript(safe index: Index) -> Element? {
            guard indices.contains(index) else {
                return nil
            }
            
            return self[index]
        }
}

extension Collection {
    /// Obtiene un conjunto aleatorio de elementos de la colección.
        ///
        /// - Parameter n: El número de elementos que se desean obtener.
        /// - Returns: Un array que contiene `n` elementos seleccionados al azar de la colección.
    func choose(_ n:Int) -> Array<Element> {
        // Mezcla los elementos de la colección y toma los primeros `n` elementos
        Array(shuffled().prefix(n))
    }
}

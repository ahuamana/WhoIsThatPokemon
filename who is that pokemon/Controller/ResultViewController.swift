//
//  ResultViewController.swift
//  who is that pokemon
//
//  Created by Antony Huaman Alikhan on 15/12/23.
//

import UIKit
import Kingfisher

class ResultViewController: UIViewController {

    @IBOutlet weak var lblTopMessage: UILabel!
    @IBOutlet weak var pokemonLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    var pokemonName:String = ""
    var pokemonImageUrl = ""
    var finalScore:Int = 0
    
    
    @IBAction func btnPlayAgain(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text = "Perdiste, tu puntaje fue de \(finalScore)."
        pokemonLabel.text = "No, es un \(pokemonName)"
        
        pokemonImage.kf.setImage(with: URL(string: pokemonImageUrl))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

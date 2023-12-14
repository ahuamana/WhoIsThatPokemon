//
//  GameModel.swift
//  who is that pokemon
//
//  Created by Antony Huaman Alikhan on 8/12/23.
//

import Foundation

struct GameModel{
    private var score:Int = 0
    
    //revisar respuesta correcta
    mutating func checkAnswer(_ userAnswer:String, _ correctAnswer:String) -> Bool {
        if userAnswer.lowercased() == correctAnswer.lowercased() {
            score += 1
            return true
        }
        return false
    }
    
    //Obtener score
    func getScore() -> Int {
        return score
    }
    
    //reiniciar score
    mutating func setScore(score:Int) {
        self.score = score
    }
}

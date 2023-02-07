//
//  Utils.swift
//  PokemonApp
//
//  Created by Hugo Regadas on 09/01/2023.
//

import Foundation
import UIKit


class Utils {
    func pokemonColor(color : String) -> UIColor{
        switch color {
        case "black":
            return UIColor.black
        case "blue":
            return UIColor.blue
        case "brown":
            return UIColor.brown
        case "gray":
            return UIColor.gray
        case "green":
            return UIColor.green
        case "pink":
            return UIColor.systemPink
        case "purple":
            return UIColor.purple
        case "red":
            return UIColor.red
        case "white":
            return UIColor.white
        case "yellow":
            return UIColor.yellow
        default:
            return UIColor.white
        }
    }
}

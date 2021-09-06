//
//  Viagem.swift
//  Alura Viagems Swift
//
//  Created by Curitiba01 on 06/09/21.
//

import UIKit

struct Viagem {
    var destiny: String
    var duration: String
    var price: Double
    var image: UIImage?
    
    static func getViagens() -> [Viagem] {
        let image = UIImage(named: "rio-de-janeiro")
        return [
            Viagem(destiny: "Rio de Janeiro", duration: "5 dias", price: 689.90, image: image),
            Viagem(destiny: "São Paulo", duration: "7 dias", price: 549.70, image: image),
            Viagem(destiny: "Salvador", duration: "2 semanas", price: 1450.89, image: image),
            Viagem(destiny: "Curitiba", duration: "3 dias", price: 459.70, image: image)
        ]
    }
}

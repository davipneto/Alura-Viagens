//
//  PacoteCollectionViewCell.swift
//  Alura Viagems Swift
//
//  Created by Curitiba01 on 08/09/21.
//

import UIKit

class PacoteCollectionViewCell: UICollectionViewCell {
    lazy var numberFormatter: NumberFormatter = {
        return setupNumberFormatter()
    }()
    var viagem: Viagem? {
        didSet {
            setData()
        }
    }
    
    @IBOutlet weak var pacoteImage: UIImageView!
    @IBOutlet weak var destinyLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private func setData() {
        guard let viagem = viagem else { return }
        pacoteImage.image = viagem.image
        destinyLabel.text = viagem.destiny
        durationLabel.text = viagem.duration
        priceLabel.text = numberFormatter.string(from: viagem.price as NSNumber)
    }
    
    private func setupNumberFormatter() -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }
}

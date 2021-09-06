//
//  ViagemTableViewCell.swift
//  Alura Viagems Swift
//
//  Created by Davi Pereira on 04/09/21.
//

import UIKit

class ViagemTableViewCell: UITableViewCell {
    static let identifier = "viagemCell"
    lazy var numberFormatter: NumberFormatter = {
        return setupNumberFormatter()
    }()
    
    var viagem: Viagem? {
        didSet {
            setData()
        }
    }

    @IBOutlet weak var destinyLabel: UILabel!
    @IBOutlet weak var tripImageView: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private func setupNumberFormatter() -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }
    
    private func setData() {
        guard let viagem = viagem else { return }
        
        destinyLabel.text = viagem.destiny
        durationLabel.text = viagem.duration
        
        tripImageView.image = viagem.image
        priceLabel.text = numberFormatter.string(from: viagem.price as NSNumber)
    }
}

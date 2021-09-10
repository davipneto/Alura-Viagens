//
//  CityTableViewCell.swift
//  Alura Viagems Swift
//
//  Created by Curitiba01 on 06/09/21.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    static let identifier = "cityCell"
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var packageNumberLabel: UILabel!
    
    func setData(city: String, packNumber: Int) {
        cityNameLabel.text = city
        packageNumberLabel.text = "\(packNumber) pacotes"
    }
    
}

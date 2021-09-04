//
//  AluraviagensHomeViewController.swift
//  Alura Viagems Swift
//
//  Created by Davi Pereira on 04/09/21.
//

import UIKit

class AluraviagensHomeViewController: UIViewController {

    @IBOutlet weak var pacotesView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        pacotesView.layer.cornerRadius = 10
    }

}


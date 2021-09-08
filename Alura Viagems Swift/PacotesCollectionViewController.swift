//
//  PacotesCollectionViewController.swift
//  Alura Viagems Swift
//
//  Created by Curitiba01 on 08/09/21.
//

import UIKit

private let reuseIdentifier = "pacoteCell"

class PacotesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pacotes = Viagem.getPacotes()
    var pacotesFiltered = [Viagem]()
    var city: String? {
        didSet {
            filterCity()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        pacotesFiltered = pacotes
    }
    
    private func setupHeader() {
        title = "Pacotes"
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func filterCity() {
        guard let city = city else { return }
        pacotesFiltered = pacotes.filter { $0.destiny == city }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pacotesFiltered.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PacoteCollectionViewCell else { return UICollectionViewCell() }
        cell.viagem = pacotesFiltered[indexPath.item]
        cell.layer.cornerRadius = 8
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemGray.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .phone {
            let width = (collectionView.frame.width - 30) / 2
            return CGSize(width: width, height: width)
        } else {
            let width = (collectionView.frame.width - 40) / 3
            return CGSize(width: width, height: width)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }

}

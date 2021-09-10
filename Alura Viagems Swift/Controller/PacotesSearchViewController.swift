//
//  PacotesSearchViewController.swift
//  Alura Viagems Swift
//
//  Created by Curitiba01 on 08/09/21.
//

import UIKit

class PacotesSearchViewController: UIViewController {
    private let reuseIdentifier = "pacoteCell"
    let pacotes = Viagem.getPacotes()
    var pacotesFiltered = [Viagem]()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        pacotesFiltered = pacotes
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
    }

}

extension PacotesSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            pacotesFiltered = pacotes
        } else {
            pacotesFiltered = pacotes.filter {
                $0.destiny.lowercased().contains(searchText.lowercased())
            }
        }
        collectionView.reloadData()
    }
}

extension PacotesSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pacotesFiltered.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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

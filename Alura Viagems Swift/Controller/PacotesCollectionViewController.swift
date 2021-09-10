//
//  PacotesCollectionViewController.swift
//  Alura Viagems Swift
//
//  Created by Curitiba01 on 08/09/21.
//

import UIKit

private let reuseIdentifier = "pacoteCell"

enum PriceRange: String, CaseIterable {
    case lessThan100 = "< 100"
    case between100and600 = "> 100 & < 600"
    case moreThan600 = "> 600"
}

class PacotesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating {
    
    let pacotes = Viagem.getPacotes()
    var pacotesFiltered = [Viagem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        pacotesFiltered = pacotes
    }
    
    private func setupHeader() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Filtrar Pacotes"
        searchController.searchBar.scopeButtonTitles = PriceRange.allCases.map { $0.rawValue }
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pacotesFiltered.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PacoteCollectionViewCell else { return UICollectionViewCell() }
        
        let index = indexPath.item
        let viagem = pacotesFiltered[index]
        
        cell.viagem = viagem
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

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        let index = searchController.searchBar.selectedScopeButtonIndex
        let priceRange = PriceRange.allCases[index]
        
        var pacotesPriceRange = pacotes
        
        switch priceRange {
        case .lessThan100:
            pacotesPriceRange = pacotes.filter { $0.price < 100 }
        case .between100and600:
            pacotesPriceRange = pacotes.filter { $0.price >= 100 && $0.price <= 600 }
        case .moreThan600:
            pacotesPriceRange = pacotes.filter { $0.price > 600 }
        }
        
        if text.isEmpty {
            self.pacotesFiltered = pacotesPriceRange
            collectionView.reloadData()
            return
        }
    
//        self.pacotesFiltered = pacotes
//            .filter { $0.destiny.range(of: text, options: .init([.caseInsensitive, .diacriticInsensitive])) != nil }
//        collectionView.reloadData()
        
        let predicate = NSPredicate(format: "destiny CONTAINS[cd] %@", text)
        if let pacotesFiltered = (pacotesPriceRange as NSArray).filtered(using: predicate) as? [Viagem] {
            self.pacotesFiltered = pacotesFiltered
            collectionView.reloadData()
        }
    }
}

//
//  AluraviagensHomeViewController.swift
//  Alura Viagems Swift
//
//  Created by Davi Pereira on 04/09/21.
//

import UIKit

class AluraviagensHomeViewController: UIViewController {

    @IBOutlet weak var pacotesView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    let viagens = Viagem.getViagens()
    lazy var cities: [String] = {
        return viagens.map { $0.destiny }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }

    private func setupView() {
        pacotesView.layer.cornerRadius = 10
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 208
        tableView.rowHeight = UITableView.automaticDimension
        
        let cityNib = UINib(nibName: "CityTableViewCell", bundle: nil)
        tableView.register(cityNib, forCellReuseIdentifier: CityTableViewCell.identifier)
    }
}

extension AluraviagensHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viagens.count
        }
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        if section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ViagemTableViewCell.identifier, for: indexPath) as? ViagemTableViewCell else { return UITableViewCell() }
            cell.tripImageView.layer.cornerRadius = 10
            cell.tripImageView.clipsToBounds = true
            cell.viagem = viagens[indexPath.row]
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else { return UITableViewCell() }
        cell.setData(city: cities[indexPath.row], packNumber: 5)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerSectionView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        headerSectionView.backgroundColor = .lightGray
        
        let label = UILabel()
        label.font = label.font.withSize(22)
        label.textColor = .systemPurple
        label.text = section == 0 ? "Pacotes de viagem" : "Cidades disponíveis"
        
        headerSectionView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: headerSectionView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: headerSectionView.centerYAnchor)
        ])
        
        return headerSectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

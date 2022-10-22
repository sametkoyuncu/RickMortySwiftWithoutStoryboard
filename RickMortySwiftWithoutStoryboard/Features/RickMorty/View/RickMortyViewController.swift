//
//  RickMortyViewController.swift
//  RickMortySwiftWithoutStoryboard
//
//  Created by Samet Koyuncu on 20.10.2022.
//

import UIKit
import SnapKit

protocol RickMortyOutput {
    func changeLoading(isLoad: Bool)
    func saveData(values: [Result])
}

final class RickMortyViewController: UIViewController {
    private let labelTitle: UILabel = UILabel()
    private let tableView: UITableView = UITableView()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private var results: [Result] = []
    
    lazy var viewModel: IRickMortyViewModel = RickMortyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
    }
    
    private func configure() {
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)
   
        drawDesign()
        
        makeTableView()
        makeLabel()
        makeIndicator()
    }
    
    private func drawDesign() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RickMortyTableViewCell.self, forCellReuseIdentifier: RickMortyTableViewCell.Identifier.custom.rawValue)
        tableView.rowHeight = 200
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view.backgroundColor = .white
            
            self.labelTitle.font = .boldSystemFont(ofSize: 25)
            self.labelTitle.text = "Rick and Morty"
            
            self.indicator.color = .purple
        }
    }
}

// MARK: - constraints
extension RickMortyViewController {
    private func makeTableView() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
            make.left.right.equalTo(labelTitle)
        }
    }
    
    private func makeLabel() {
         labelTitle.snp.makeConstraints { (make) in
             make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
             make.left.equalTo(view).offset(10)
             make.right.equalTo(view).offset(-10)
             make.height.greaterThanOrEqualTo(20)
         }
    }
    
    private func makeIndicator() {
        indicator.snp.makeConstraints { make in
            make.height.equalTo(labelTitle)
            make.right.equalTo(labelTitle)
            make.top.equalTo(labelTitle)
        }
    }
}

// MARK: - output protocol
extension RickMortyViewController: RickMortyOutput {
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveData(values: [Result]) {
        results = values
        tableView.reloadData()
    }
}

// MARK: - table view delegate methods
extension RickMortyViewController: UITableViewDelegate {
    
}

// MARK: - table view datasource methods
extension RickMortyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RickMortyTableViewCell = tableView.dequeueReusableCell(withIdentifier: RickMortyTableViewCell.Identifier.custom.rawValue) as? RickMortyTableViewCell else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Custom cell not avaible now, please try again later!"
            return cell
        }
        
        cell.saveModel(model: results[indexPath.row])
        
        return cell
    }
}

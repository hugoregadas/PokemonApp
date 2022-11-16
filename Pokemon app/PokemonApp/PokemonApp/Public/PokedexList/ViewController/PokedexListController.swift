//
//  PokedexListController.swift
//  PokemonApp
//
//  Created by Hugo Regadas on 10/11/2022.
//

import UIKit

class PokedexListController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet var tableView : UITableView!
    @IBOutlet var titleLabel: UILabel!
    
    //MARK: - Private properties
    private let viewModel = PokedexListViewModel(serviceAPi: ServiceManager.shared)
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
}

//MARK: - private methods
private extension PokedexListController {
    func initUI(){
        tableView.dataSource = self
        tableView.delegate = self
        titleLabel.text = viewModel.pokedexTitle
        fetchAllPokedex()
    }
    
    func fetchAllPokedex(){
        viewModel.fetchAllPokedex(completion:{ [weak self] isCompletion, error in
            if isCompletion {
                guard let self = self else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }else {
                print("Error")
            }
        })
    }
}

//MARK: - TableView Data Source e Delegate
extension PokedexListController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.fetchPokedexName(with: indexPath.row)
        cell.textLabel?.textColor = UIColor(named: "TextTable")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPokedex
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PokedexSegue", sender: self)
    }
}


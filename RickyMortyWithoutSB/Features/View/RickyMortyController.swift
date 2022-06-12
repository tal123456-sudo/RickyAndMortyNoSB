//
//  RickyMortyController.swift
//  RickyMortyWithoutSB
//
//  Created by Muhammet  on 12.06.2022.
//

import UIKit
import SnapKit

protocol RickyMortyOutput {
    func changeLoading(isLoad: Bool)
    func saveDatas(values: [Result])
    
}

final class RickyMortyController: UIViewController {
    private  let labelTitle: UILabel = UILabel()
    private  let tableView: UITableView  = UITableView()
    private  let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private lazy var results: [Result] = []
    
    lazy var viewModel: IRickyMortyViewModel = RickyMortyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
    }
    
   private func configure(){
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)
        drawDesing()
        makeTableView()
        makeLabel()
        makeIndicator()
        
    }
    
    private func drawDesing(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RickyMortyCell.self, forCellReuseIdentifier: RickyMortyCell.Identifier.custom.rawValue)
        
        tableView.rowHeight = 200
        DispatchQueue.main.async {
            
            self.view.backgroundColor = .white
            self.labelTitle.font = .boldSystemFont(ofSize: 25)
            self.labelTitle.text = "Ricky Morty"
            self.indicator.color = .red
           
        }
        indicator.startAnimating()
    }
    
}
extension RickyMortyController: RickyMortyOutput {
    func saveDatas(values: [Result]) {
        results = values
        tableView.reloadData()
    }
    
    
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    
}

extension RickyMortyController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RickyMortyCell = tableView.dequeueReusableCell(withIdentifier: RickyMortyCell.Identifier.custom.rawValue) as? RickyMortyCell else {
            return UITableViewCell()
        }
        cell.saveModel(model: results[indexPath.row])
        return cell
    }
     
}
extension RickyMortyController{
    
    private  func makeTableView(){
        tableView.snp.makeConstraints { make in
          make.top.equalTo(labelTitle.snp.bottom).offset(5)
          make.bottom.equalToSuperview()
          make.left.right.equalTo(labelTitle)
      }
    }
    
    private func makeLabel(){
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
     }
    
    private func makeIndicator(){
        indicator.snp.makeConstraints { make in
            make.height.equalTo(labelTitle)
            make.right.equalTo(labelTitle).offset(-5)
            make.top.equalTo(labelTitle)
        }
    }
}

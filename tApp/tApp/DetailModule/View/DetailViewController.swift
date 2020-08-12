//
//  DetailViewController.swift
//  tApp
//
//  Created by macOS developer on 09.08.2020.
//  Copyright © 2020 macOS developer. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }
}


extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.students?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell",for: indexPath) as! TableViewCell
        cell.name.text = self.presenter.students?[indexPath.row].name ?? "None"
        cell.score.text =  self.presenter.students?[indexPath.row].score ?? "0"
        cell.sum.text = self.presenter.students?[indexPath.row].sum ?? "0"
        cell.number.text = String(indexPath.row + 1)
        return cell
    }
    
}

extension DetailViewController: DetailViewProtocol{
    func success() {
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}


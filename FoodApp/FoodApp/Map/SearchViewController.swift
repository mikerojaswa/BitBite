//
//  SearchViewController.swift
//  FoodApp
//
//  Created by Michael Rojas on 11/12/18.
//  Copyright © 2018 Michael Rojas. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "LabelAndImageTableViewCell", bundle: nil), forCellReuseIdentifier: "LabelAndImageTableViewCell")
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LabelAndImageTableViewCell") as? LabelAndImageTableViewCell else { return UITableViewCell()}
        
        cell.imageView?.backgroundColor = .red
        cell.label.text = "Hello"
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected cell at \(indexPath.row)")
    }
}

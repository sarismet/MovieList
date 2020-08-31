//
//  ActorKnownForViewController.swift
//  MovieList
//
//  Created by ismet sarı on 31.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import UIKit

class ActorKnownForViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView! {
    didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "BasicMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "BasicMovieTableViewCell")
            tableView.keyboardDismissMode = .onDrag
        }
    }
    
    var movies: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BasicMovieTableViewCell", for: indexPath) as? BasicMovieTableViewCell {
            cell.movieNameLabel.text = movies[indexPath.row]
            return cell
        }
        
        return TableViewCell()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

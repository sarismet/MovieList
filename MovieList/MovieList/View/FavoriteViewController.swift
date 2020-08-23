//
//  FavoriteViewController.swift
//  MovieList
//
//  Created by ismet sarı on 22.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            searchBar.delegate = self
            tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
            tableView.register(UINib(nibName: "LoadingTableViewCell", bundle: nil), forCellReuseIdentifier: "LoadingTableViewCell")
            tableView.keyboardDismissMode = .onDrag
        }
    }

    
    private var movies: [Movie] = [] {
        didSet {
            self.selectMovies = movies
            tableView.reloadData()
        }
    }
    
    private var selectMovies: [Movie] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        //cell.configure(data: selectMovies[indexPath.row])
        return cell
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
}

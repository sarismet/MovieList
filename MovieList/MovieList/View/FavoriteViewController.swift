//
//  FavoriteViewController.swift
//  MovieList
//
//  Created by ismet sarı on 10.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriTableView: UITableView!
    
    @IBOutlet weak var favorite: UITableView!{
        didSet {
            favorite.dataSource = self
            favorite.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        }
    }
    
    private var movies: [FavoriteViewController]? {
        didSet {
            favoriTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorite Movies"

        
    }
    



}
extension FavoriteViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        return cell
    }

}

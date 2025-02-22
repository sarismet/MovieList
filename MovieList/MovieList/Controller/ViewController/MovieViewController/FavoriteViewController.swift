//
//  FavoriteViewController.swift
//  MovieList
//
//  Created by ismet sarı on 22.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, TableViewCellDelegate {

    func didPressButton(_ theMovie: Movie, _ indexPath: IndexPath) {
        print("delegate")
        if !FavoriMoviesController.shared.bringTheAction(theMovie) {
            self.movies.remove(at: indexPath.row)
        }
    }

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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectMovies.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell {
            cell.delegate = self
            cell.configure(selectMovies[indexPath.row], indexPath)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: DetailMovieViewController.self)) as? DetailMovieViewController {
            viewC.delegate = self
            viewC.movieID = selectMovies[indexPath.row].id ?? 0
            viewC.indexPath = indexPath
            viewC.configure()
            navigationController?.pushViewController(viewC, animated: true)
        }

    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        self.selectMovies = []

        if searchText == "" {
            self.selectMovies = self.movies
        } else {

            self.selectMovies = self.movies.filter({ $0.title?.range(of: searchText, options: .caseInsensitive, locale: Locale.current) != nil})
        }

        self.tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        self.movies = FavoriMoviesController.shared.getSavedFavoriMovies()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "Favorite Movies"
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.movies = FavoriMoviesController.shared.getSavedFavoriMovies()
        // Do any additional setup after loading the view.
    }

}

//
//  PopularViewController.swift
//  MovieList
//
//  Created by ismet sarı on 10.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import UIKit

class PopularViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
     UISearchBarDelegate, TableViewCellDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            searchBar.delegate = self
            tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
            tableView.register(UINib(nibName: "LoadingTableViewCell", bundle: nil),
                               forCellReuseIdentifier: "LoadingTableViewCell")
            tableView.keyboardDismissMode = .onDrag
        }
    }
    private var loading: Bool = false
    private var searching: Bool = false
    private var pageNo: Int = 1
    private var movies: [Movie] = [] {
        didSet {
            self.selectMovies = movies
            tableView.reloadData()
        }
    }
    private var selectMovies: [Movie] = []
    
    func didPressButton(_ theMovie: Movie, _ indexPath: IndexPath) {
        print("delegate is running")
        _ = FavoriMoviesController.shared.bringTheAction(theMovie)
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.selectMovies.count
        } else if section == 1 && loading {
            return 1
        }
        return 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewC = self.storyboard?.instantiateViewController(withIdentifier:
            String(describing: DetailMovieViewController.self)) as? DetailMovieViewController {
            viewC.delegate = self
            viewC.movieID = selectMovies[indexPath.row].id ?? 0
            viewC.indexPath = indexPath
            navigationController?.pushViewController(viewC, animated: true)
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        self.searching = true
        self.selectMovies = []

        if searchText == "" {
            self.selectMovies = self.movies
        } else {

            self.selectMovies = self.movies.filter({ $0.title?.range(of: searchText, options: .caseInsensitive, locale: Locale.current) != nil })
        }

        self.tableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell {
                cell.delegate = self
                cell.configure(selectMovies[indexPath.row], indexPath)
                return cell
            }
                return UITableViewCell()

        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingTableViewCell", for: indexPath) as? LoadingTableViewCell {
                cell.spinner.startAnimating()
                return cell
            }
            return UITableViewCell()

        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 25.0
        }
        return 250.0
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == (self.movies.count - 3) {
            
            if !searching , !loading{
                 self.pageNo += 1
                self.loadMore()
            }
        }
    }

    func loadMore() {
        self.loading = true
        tableView.reloadSections(IndexSet(integer: 1), with: .none)

        Network.shared.getPopularMovies(self.pageNo, completion: { (result) in

                DispatchQueue.main.async {
                switch result {
                case .success(let popularMoviesResults):

                    MovieController.shared.addPopularMovies(popularMoviesResults.results ?? [])
                    self.movies.append(contentsOf: popularMoviesResults.results ?? [])
                    self.loading = false
                case .failure(let error):
                    let dialogMessage = UIAlertController(title: "Error!!!", message: error.errorMessage, preferredStyle: .alert)
                    let okey = UIAlertAction(title: "OK", style: .default, handler: { (_) -> Void in
                         _ = self.navigationController?.popViewController(animated: true)
                    })
                    let cancel = UIAlertAction(title: "Re-try", style: .cancel) { (_) -> Void in
                        self.loadMore()
                    }
                    dialogMessage.addAction(okey)
                    dialogMessage.addAction(cancel)
                    self.present(dialogMessage, animated: true, completion: nil)
                }

            }
        })

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "Popular Movies"
        self.tableView.reloadData()
    }
    override func loadView() {
        super.loadView()
        self.loadMore()
    }
}

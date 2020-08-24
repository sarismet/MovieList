//
//  PopularViewController.swift
//  MovieList
//
//  Created by ismet sarı on 10.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import UIKit

class PopularViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    private var loading: Bool = false
    private var searching: Bool = false
    
    private var pageNo: Int = 1
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var movies: [Movie] = [] {
        didSet {
            self.selectMovies = movies
            tableView.reloadData()
        }
    }
    
    private var selectMovies: [Movie] = []
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.selectMovies.count
        } else if section == 1 && loading {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: DetailMovieViewController.self)) as! DetailMovieViewController
        if let id = selectMovies[indexPath.row].id {
            vc.configure(id)
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cell.setPopularCellValue(true)
            cell.setLikeButton(FavoriMoviesController.shared.isFavorite(selectMovies[indexPath.row]))
            cell.configure(selectMovies[indexPath.row].id ?? 0)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingTableViewCell", for: indexPath) as! LoadingTableViewCell
            cell.spinner.startAnimating()
            return cell
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
            self.pageNo += 1
            self.searching = true
        }
    }
    
    func loadMore() {
        self.loading = true
        tableView.reloadSections(IndexSet(integer: 1), with: .none)

        
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            Network.shared.getMovies(self.pageNo, completion: { (result) in
                                    switch result {
                                    case .success(let popularMoviesResults):
                                        DispatchQueue.main.async {
                                            
                                            MovieController.shared.addPopularMovies(popularMoviesResults.results ?? [])
                                         self.movies.append(contentsOf: popularMoviesResults.results ?? [])

                                        }
                                    case .failure(let error):
                                        print(error)
                                    }
                                })

             self.loading = false
         })
        
        

        

    }
    
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (offsetY > contentHeight - scrollView.frame.height), searching {
            if !loading {
                self.loadMore()
            }
        }
        
    }
    
    override func loadView() {
        
        super.loadView()
        self.loadMore()
    }
}

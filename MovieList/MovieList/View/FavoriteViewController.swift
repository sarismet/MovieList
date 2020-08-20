//
//  FavoriteViewController.swift
//  MovieList
//
//  Created by ismet sarı on 10.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var favoriTableView: UITableView!
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.dataSource = self
            tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        }
    }
    var favoriMovies: [Details] = []{
        didSet {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 250.0
    }
    @IBOutlet weak var searchBar: UISearchBar!

    
    private var movies: [FavoriteViewController]? {
        didSet {
            favoriTableView.reloadData()
        }
    }
    var ids: [Int] = []
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("XXXXXXXX \(self.favoriMovies.count)")
        
        self.ids = defaults.array(forKey: "favories") as? [Int] ?? []
        for i in ids{
            print(i)
            self.getLoad(i)
        }

    }
    
    deinit {
        print("deinit cagrıldı")
        defaults.set(self.ids, forKey: "favories")
    }

    func getLoad(_ movieID:Int){

        Network.shared.getMovieDetail(movieID , completion: { (result) in
                       switch result {
                       case .success(let details):
                           DispatchQueue.main.async {
                            self.favoriMovies.append(details)

                           }
                       case .failure(let error):
                           print(error)
                       }
        })


    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.isPressed = true
        
        cell.configureDetail(data: self.favoriMovies[indexPath.row])
        cell.likeButton.tag = self.favoriMovies[indexPath.row].id!
        cell.likeButton.addTarget(self, action: #selector(operationOnUserDefaults(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func operationOnUserDefaults(_ sender: UIButton){
        
        var i:Int = 0
        for ix in self.favoriMovies{
            if ix.id == sender.tag{
                self.favoriMovies.remove(at: i)
                break
            }else{
                i = i + 1
            }
        }
        
        i = 0
        
        for id in self.ids {
            if id == sender.tag {
                self.ids.remove(at: i)
            }else{
                i = i + 1
            }
        }
        self.tableView.reloadData()
    }

}


//
//  ActorsHomeViewController.swift
//  MovieList
//
//  Created by ismet sarı on 27.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import UIKit

class ActorsHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
                tableView.dataSource = self
                tableView.delegate = self
                searchBar.delegate = self
                tableView.register(UINib(nibName: "ActorTableViewCell", bundle: nil), forCellReuseIdentifier: "ActorTableViewCell")
                tableView.register(UINib(nibName: "LoadingTableViewCell", bundle: nil),
                               forCellReuseIdentifier: "LoadingTableViewCell")
                tableView.keyboardDismissMode = .onDrag
            }
        }
    private var loading: Bool = false
    private var searching: Bool = false
    private var pageNo: Int = 1

    private var actors: [Actor] = [] {
        didSet {
            self.selectActors = actors
            tableView.reloadData()
        }
    }

    private var selectActors: [Actor] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.selectActors.count
        } else if section == 1 && loading {
            return 1
        }
        return 0
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        self.selectActors = []

        if searchText == "" {
            self.selectActors = self.actors
        } else {

            self.selectActors = self.actors.filter({ $0.name?.range(of: searchText, options: .caseInsensitive, locale: Locale.current) != nil })
        }

        self.tableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ActorTableViewCell", for: indexPath) as? ActorTableViewCell {
                cell.configure(selectActors[indexPath.row])
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

         if indexPath.row == (self.actors.count - 3) {
             self.pageNo += 1
             self.searching = true
         }
     }

     func loadMore() {
         self.loading = true
         tableView.reloadSections(IndexSet(integer: 1), with: .none)

         Network.shared.getPopularActors(self.pageNo, completion: { (result) in

                 DispatchQueue.main.async {
                 switch result {
                 case .success(let popularActorsResults):

                    ActorController.shared.addPopularActors(popularActorsResults.results ?? [])
                     self.actors.append(contentsOf: popularActorsResults.results ?? [])
                     self.loading = false
                 case .failure(let error):
                     // Create new Alert
                     print(error)
                     let dialogMessage = UIAlertController(title: "Error!!!", message: "The system does not response. What do you want to retry?", preferredStyle: .alert)
                     // Create OK button with action handler
                     let okey = UIAlertAction(title: "OK", style: .default, handler: { (_) -> Void in
                          _ = self.navigationController?.popViewController(animated: true)
                     })
                     // Create Cancel button with action handlder
                     let cancel = UIAlertAction(title: "Re-try", style: .cancel) { (_) -> Void in
                         self.loadMore()
                     }
                     //Add OK and Cancel button to an Alert object
                     dialogMessage.addAction(okey)
                     dialogMessage.addAction(cancel)
                     // Present alert message to user
                     self.present(dialogMessage, animated: true, completion: nil)
                 }

             }
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
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.title = "Popular Actors"
     }
     override func loadView() {
         super.loadView()
         self.loadMore()
     }
}

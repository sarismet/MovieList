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
    
    var knownInfos: [KnownFor] = []
    var actorID: Int = 0
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.knownInfos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BasicMovieTableViewCell", for: indexPath) as? BasicMovieTableViewCell {
            cell.knownfor = knownInfos[indexPath.row]
            return cell
        }
        
        return TableViewCell()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.knownInfos = ActorController.shared.getTheActor(self.actorID)?.knownFor as! [KnownFor]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

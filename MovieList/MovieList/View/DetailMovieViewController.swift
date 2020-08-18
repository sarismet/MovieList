//
//  DetailMovieViewController.swift
//  MovieList
//
//  Created by ismet sarı on 16.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import UIKit
import SDWebImage

class DetailMovieViewController: UIViewController {

    var isPressed: Bool = false
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var mainImage: UIImageView!

    
    @IBOutlet weak var genre1: UILabel!
    @IBOutlet weak var genre3: UILabel!
    @IBOutlet weak var genre2: UILabel!
    
    @IBOutlet weak var overview: UILabel!
    
    @IBOutlet weak var netflixButton: UIButton!
    @IBOutlet weak var imdbButton: UIButton!
    
 

    
    private var movieID: Int = 547016
    
    func getMovieId() -> Int {
        return self.movieID
    }
    
    func setMovieId(_ movieId: Int){
        print("movie id was \(self.movieID)")
        self.movieID = movieId
        print("movie id is now \(self.movieID)")
    }
    var netflixURL: URL?
    var imdbURL: URL?
    var imageURLInitial: String = "https://image.tmdb.org/t/p/w500"
    
    var imageURL: String = "/m0ObOaJBerZ3Unc74l471ar8Iiy.jpg"
    var mainImageURL: String = "/fjCezXiQWfGuNf4t7LruKky7kwV.jpg"
    

    @IBAction func like_unlikeButton() {
        if isPressed {
            isPressed = false
            if let image = UIImage(named: "unlike_button.png") {
                likeButton.setImage(image, for: .normal)
            }
        }else{
            isPressed = true
            if let image = UIImage(named: "like_button.png") {
                likeButton.setImage(image, for: .normal)
            }
        }

        
    }
    
    @IBAction func netflixButtonAction(_ sender: Any) {
        UIApplication.shared.open(self.netflixURL ?? URL(string: "https://www.netflix.com/tr-en/")!)
        //burda artık forcelayabilir miyim?
    }
    
    @IBAction func imdbButtonAction(_ sender: Any) {
        UIApplication.shared.open(self.imdbURL ?? URL(string: "https://www.imdb.com/?ref_=nv_home")!)
    }
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!

    @IBOutlet weak var firstProducerLabel: UILabel!
    @IBOutlet weak var firstProducerImage: UIImageView!
    
    @IBOutlet weak var secondProducerLabel: UILabel!
    @IBOutlet weak var secondProducerImage: UIImageView!
    
    
    @IBOutlet weak var thirdProducerLabel: UILabel!
    @IBOutlet weak var thirdProducerImage: UIImageView!
    
    @IBOutlet weak var lastHorizontalStackView: UIStackView!
    

    private func setVariables(_ details: Details){
        
        self.netflixURL = details.netflixURL ?? URL(string: "https://www.netflix.com/tr-en/")!
        self.imdbURL = URL(string: "https://www.imdb.com/title/\(details.imdbID ?? "tt7363104/")")!
        
        self.mainImageURL = "\(self.imageURLInitial)\(details.posterImage ?? "/m0ObOaJBerZ3Unc74l471ar8Iiy.jpg")"
        self.imageURL = "\(self.imageURLInitial)\(details.backgroundImage ?? "/fjCezXiQWfGuNf4t7LruKky7kwV.jpg")"
        print("background image \(self.imageURL)")

        mainImage.sd_setImage(with: URL(string: self.mainImageURL), completed: nil)
              
        backgroundImage.sd_setImage(with: URL(string: self.imageURL), completed: nil)
              
        self.titleLabel.text = details.title
              
        dateLabel.text = details.releaseDate //there is no alert or something???
        runTimeLabel.text = String(details.runtime ?? 0)
        languageLabel.text = details.language
        genre1.text = details.genres?[0].name
              //genre2.text = details.genres?[1].name
              //genre3.text = details.genres?[2].name
              

              
        rateLabel.text = "\(details.rate ?? 0.0)/10"
              
        overview.text = details.overview
              
        
              
          }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: lastHorizontalStackView.bottomAnchor).isActive = true

            Network.shared.getMovieDetail(self.movieID , completion: { (result) in
                           switch result {
                           case .success(let details):
                               DispatchQueue.main.async {
                                self.setVariables(details)
                                
                                print(details.genres?[0].name ?? "sss")

                               }
                           case .failure(let error):
                               print(error)
                           }
            })
        

        
        
    }
   
}

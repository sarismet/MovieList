import Foundation

class MovieDetailController {

    static let sharedMovieDetailController = MovieDetailController()

    private var movieDetails: [Int: MovieDetails]

    init() {
        self.movieDetails = [:]
    }

    func getMovieDetail(_ movieID: Int) -> MovieDetails? {
        //return self.movieDetails[movieID]! // need help

        return self.movieDetails[movieID]

    }

    func isPresent(_ movieID: Int) -> Bool {
        if self.movieDetails[movieID] == nil {
            return false
        } else {
            return true
        }
    }

}

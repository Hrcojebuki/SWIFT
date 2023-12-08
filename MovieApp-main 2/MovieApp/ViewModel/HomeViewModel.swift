//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Raphael Cerqueira on 18/01/21.
//

import SwiftUI

//protocol MovieService {
//    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
//}

class HomeViewModel: ObservableObject {
    @Published var items: [Movie]?
    
    public var placeholders = Array(repeating: Movie(id: Int(UUID().uuidString), overview: nil, title: nil), count: 10)
    @Published var searchResults: [Movie] = []
    
//    func search(query: String) {
//        self.movies = nil
//        self.isLoading = false
//        self.error = nil
//        
//        guard !query.isEmpty else {
//            return
//        }
//        
//        self.isLoading = true
//        self.movieService.searchMovie(query: query) {[weak self] (result) in
//            guard let self = self, self.query == query else { return }
//            
//            self.isLoading = false
//            switch result {
//            case .success(let response):
//                self.movies = response.results
//            case .failure(let error):
//                self.error = error as NSError
//            }
//        }
//    }
    
    func fetchData(sortBy: String) {
        let url = URL(string: "\(Constants.baseURl)/discover/movie?api_key=\(Constants.apiKey)&language=en-US&sort_by=\(sortBy)&include_adult=false&include_video=false&page=1")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                do {
                    let res: ErrorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data!)
                    print("Erro ao recuperar os filmes populares.", res.status_message!)
                    return
                } catch {
                    print(error)
                }
            }
            
            guard let data = data else { return }
            
            do {
                let result: DiscoverResponse = try JSONDecoder().decode(DiscoverResponse.self, from: data)
                DispatchQueue.main.async {
                    self.items = result.results
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
}

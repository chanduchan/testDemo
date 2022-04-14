//
//  MovieViewModel.swift
//  unitTestingDemo
//
//  Created by M_AMBIN05643 on 13/04/22.
//

import Foundation

 
//MARK: - custom enum
enum SocialPlatForm: Equatable {
    case twitter(subscribeCount: Int)
    case facebook(friendCount: Int)
    case linkedln(followers: Int)
}

//MARK: - viewModel class making final BCS of no more changes
final class MovieViewModel {
    
    let manager: ServiceManagerProtocol
    
    init(manager: ServiceManagerProtocol) {
        self.manager = manager
    }
    
    func cellForRow(at row: Int) -> Result? {
        if let res = movieResponse?.feed?.results?[row] {
            return res
        }
        return nil
    }
    
    func getPlatform( index: Int, count:Int) -> SocialPlatForm {
        switch index {
        case 0: return SocialPlatForm.twitter(subscribeCount: count)
        case 1: return SocialPlatForm.facebook(friendCount: count)
        case 2: return SocialPlatForm.linkedln(followers: count)
        default:
            return SocialPlatForm.linkedln(followers: count)
        }
    }
    
    var movieResponse: MovieModel?
    
    func getAPIResponseData(completion: @escaping (()-> Void)) {
        manager.getAPIResponseData {[weak self] result in
            guard let strongSelf = self else {return}
            strongSelf.movieResponse = result
            completion()
        }
//        if let url = URL(string: "https://rss.applemarketingtools.com/api/v2/us/music/most-played/50/albums.json") {
//            let task = URLSession.shared.dataTask(with: url) { data, response, err in
//                if let data = data,let result = self.parseData(jsonData: data) {
//                    self.movieResponse = result
//                    completion()
//                }
//            }
//            task.resume()
//        }
    }
//    
//    func parseData(jsonData: Data) -> MovieModel? {
//        let jsonDecoder = JSONDecoder()
//        do {
//            let result = try jsonDecoder.decode(MovieModel.self, from: jsonData)
//            return result
//        }catch let err{
//            print(err.localizedDescription)
//            return nil
//        }
//    }
    
    func numberOfRows() -> Int {
        return movieResponse?.feed?.results?.count ?? 0
    }
}

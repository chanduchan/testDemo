//
//  ServiceManager.swift
//  unitTestingDemo
//
//  Created by M_AMBIN05643 on 14/04/22.
//

import Foundation



//MARK: - Creating a protocol for API service
protocol ServiceManagerProtocol {
    func getAPIResponseData(completion: @escaping ((MovieModel)-> Void))
    func parseData(jsonData: Data) -> MovieModel?
}

//MARK: - creating a service class and inheriting from serviceManagerProtocol
class ServiceManager: ServiceManagerProtocol {
    func getAPIResponseData(completion: @escaping ((MovieModel) -> Void)) {
        if let url = URL(string: "https://rss.applemarketingtools.com/api/v2/us/music/most-played/50/albums.json") {
            let task = URLSession.shared.dataTask(with: url) { data, response, err in
                if let data = data,let result = self.parseData(jsonData: data) {
                    completion(result)
                }
            }
            task.resume()
        }
    }
    
    func parseData(jsonData: Data) -> MovieModel? {
        let jsonDecoder = JSONDecoder()
        do {
            let result = try jsonDecoder.decode(MovieModel.self, from: jsonData)
            return result
        }catch let err{
            print(err.localizedDescription)
            return nil
        }
    }
}

//MARK: - Craeting a mocked inheritance class for mock testing in unitTesting
class MockServiceManager: ServiceManagerProtocol {
    func getAPIResponseData(completion: @escaping ((MovieModel) -> Void)) {
        if let data = mockeddata.data(using: .utf8) {
            if let result = self.parseData(jsonData: data) {
                completion(result)
            }
        }
    }
    
    func parseData(jsonData: Data) -> MovieModel? {
        let jsonDecoder = JSONDecoder()
        do {
            let result = try jsonDecoder.decode(MovieModel.self, from: jsonData)
            return result
        }catch let err{
            print(err.localizedDescription)
            return nil
        }
    }
}


//MARK: - Ading mocked response for dummy data handling

let mockeddata = """
{
  "feed": {
    "title": "Top Albums",
    "id": "https://rss.applemarketingtools.com/api/v2/us/music/most-played/10/albums.json",
    "author": {
      "name": "Apple",
      "url": "https://www.apple.com/"
    },
    "links": [
      {
        "self": "https://rss.applemarketingtools.com/api/v2/us/music/most-played/10/albums.json"
      }
    ],
    "copyright": "Copyright © 2022 Apple Inc. All rights reserved.",
    "country": "us",
    "icon": "https://www.apple.com/favicon.ico",
    "updated": "Thu, 14 Apr 2022 06:27:50 +0000",
    "results": [
      {
        "artistName": "Lil Durk",
        "id": "1614870185",
        "name": "7220 (Reloaded)",
        "releaseDate": "2022-03-11",
        "kind": "albums",
        "artistId": "541282483",
        "artistUrl": "https://music.apple.com/us/artist/lil-durk/541282483",
        "contentAdvisoryRating": "Explict",
        "artworkUrl100": "https://is3-ssl.mzstatic.com/image/thumb/Music126/v4/29/ba/71/29ba719b-9dfc-3693-ec8e-c80d518063d2/196589019684.jpg/100x100bb.jpg",
        "genres": [
          {
            "genreId": "18",
            "name": "Hip-Hop/Rap",
            "url": "https://itunes.apple.com/us/genre/id18"
          },
          {
            "genreId": "34",
            "name": "Music",
            "url": "https://itunes.apple.com/us/genre/id34"
          }
        ],
        "url": "https://music.apple.com/us/album/7220-reloaded/1614870185"
      },
      {
        "artistName": "42 Dugg  EST Gee",
        "id": "1617332701",
        "name": "Last Ones Left",
        "releaseDate": "2022-04-08",
        "kind": "albums",
        "artistId": "1277595465",
        "artistUrl": "https://music.apple.com/us/artist/42-dugg/1277595465",
        "contentAdvisoryRating": "Explict",
        "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/6c/08/18/6c08184c-61f2-6777-88d4-c08580e09205/22UMGIM33673.rgb.jpg/100x100bb.jpg",
        "genres": [
          {
            "genreId": "18",
            "name": "Hip-Hop/Rap",
            "url": "https://itunes.apple.com/us/genre/id18"
          },
          {
            "genreId": "34",
            "name": "Music",
            "url": "https://itunes.apple.com/us/genre/id34"
          }
        ],
        "url": "https://music.apple.com/us/album/last-ones-left/1617332701"
      },
      {
        "artistName": "YoungBoy Never Broke Again",
        "id": "1617170958",
        "name": "The Last Slimeto",
        "releaseDate": "2022-08-05",
        "kind": "albums",
        "artistId": "1168822104",
        "artistUrl": "https://music.apple.com/us/artist/youngboy-never-broke-again/1168822104",
        "contentAdvisoryRating": "Explict",
        "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Music112/v4/4d/54/ec/4d54eccd-8e71-4217-cb81-445adc77136b/075679750006.jpg/100x100bb.jpg",
        "genres": [
          {
            "genreId": "18",
            "name": "Hip-Hop/Rap",
            "url": "https://itunes.apple.com/us/genre/id18"
          },
          {
            "genreId": "34",
            "name": "Music",
            "url": "https://itunes.apple.com/us/genre/id34"
          }
        ],
        "url": "https://music.apple.com/us/album/the-last-slimeto/1617170958"
      },
      {
        "artistName": "Fivio Foreign",
        "id": "1617161806",
        "name": "B.I.B.L.E.",
        "releaseDate": "2022-04-08",
        "kind": "albums",
        "artistId": "967265914",
        "artistUrl": "https://music.apple.com/us/artist/fivio-foreign/967265914",
        "contentAdvisoryRating": "Explict",
        "artworkUrl100": "https://is4-ssl.mzstatic.com/image/thumb/Music112/v4/66/a0/fd/66a0fdf7-8b80-06cb-06d1-84b2ccee2765/196589062345.jpg/100x100bb.jpg",
        "genres": [
          {
            "genreId": "18",
            "name": "Hip-Hop/Rap",
            "url": "https://itunes.apple.com/us/genre/id18"
          },
          {
            "genreId": "34",
            "name": "Music",
            "url": "https://itunes.apple.com/us/genre/id34"
          }
        ],
        "url": "https://music.apple.com/us/album/b-i-b-l-e/1617161806"
      },
      {
        "artistName": "Lin-Manuel Miranda, Germaine Franco, Stephanie Beatriz, Olga Merediz Jessica Darrow",
        "id": "1594677532",
        "name": "Encanto (Original Motion Picture Soundtrack)",
        "releaseDate": "2021-11-19",
        "kind": "albums",
        "artistId": "329027198",
        "artistUrl": "https://music.apple.com/us/artist/lin-manuel-miranda/329027198",
        "artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Music126/v4/94/4d/9a/944d9a8d-0549-f537-5706-5b083bd84a7d/21UM1IM38949.rgb.jpg/100x100bb.jpg",
        "genres": [
          {
            "genreId": "34",
            "name": "Music",
            "url": "https://itunes.apple.com/us/genre/id34"
          },
          {
            "genreId": "16",
            "name": "Soundtrack",
            "url": "https://itunes.apple.com/us/genre/id16"
          }
        ],
        "url": "https://music.apple.com/us/album/encanto-original-motion-picture-soundtrack/1594677532"
      },
      {
        "artistName": "Vince Staples",
        "id": "1615493782",
        "name": "RAMONA PARK BROKE MY HEART",
        "releaseDate": "2022-04-08",
        "kind": "albums",
        "artistId": "566639154",
        "artistUrl": "https://music.apple.com/us/artist/vince-staples/566639154",
        "contentAdvisoryRating": "Explict",
        "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Music112/v4/a6/63/da/a663dab8-3d6e-1b66-d8ec-a26e8d5800ad/22UMGIM15334.rgb.jpg/100x100bb.jpg",
        "genres": [
          {
            "genreId": "18",
            "name": "Hip-Hop/Rap",
            "url": "https://itunes.apple.com/us/genre/id18"
          },
          {
            "genreId": "34",
            "name": "Music",
            "url": "https://itunes.apple.com/us/genre/id34"
          }
        ],
        "url": "https://music.apple.com/us/album/ramona-park-broke-my-heart/1615493782"
      },
      {
        "artistName": "Drake",
        "id": "1584281467",
        "name": "Certified Lover Boy",
        "releaseDate": "2021-09-03",
        "kind": "albums",
        "artistId": "271256",
        "artistUrl": "https://music.apple.com/us/artist/drake/271256",
        "contentAdvisoryRating": "Explict",
        "artworkUrl100": "https://is4-ssl.mzstatic.com/image/thumb/Music115/v4/11/36/38/1136384a-eebc-697a-c005-d890e41c0854/21UM1IM07518.rgb.jpg/100x100bb.jpg",
        "genres": [
          {
            "genreId": "18",
            "name": "Hip-Hop/Rap",
            "url": "https://itunes.apple.com/us/genre/id18"
          },
          {
            "genreId": "34",
            "name": "Music",
            "url": "https://itunes.apple.com/us/genre/id34"
          }
        ],
        "url": "https://music.apple.com/us/album/certified-lover-boy/1584281467"
      },
      {
        "artistName": "Machine Gun Kelly",
        "id": "1608118564",
        "name": "mainstream sellout",
        "releaseDate": "2022-03-25",
        "kind": "albums",
        "artistId": "465954501",
        "artistUrl": "https://music.apple.com/us/artist/machine-gun-kelly/465954501",
        "contentAdvisoryRating": "Explict",
        "artworkUrl100": "https://is3-ssl.mzstatic.com/image/thumb/Music116/v4/d9/48/6f/d9486f75-e228-26c2-9498-befd009e2a90/22UMGIM11298.rgb.jpg/100x100bb.jpg",
        "genres": [
          {
            "genreId": "20",
            "name": "Alternative",
            "url": "https://itunes.apple.com/us/genre/id20"
          },
          {
            "genreId": "34",
            "name": "Music",
            "url": "https://itunes.apple.com/us/genre/id34"
          }
        ],
        "url": "https://music.apple.com/us/album/mainstream-sellout/1608118564"
      },
      {
        "artistName": "Gunna",
        "id": "1604944424",
        "name": "DRIP SEASON 4EVER",
        "releaseDate": "2022-01-07",
        "kind": "albums",
        "artistId": "1236267297",
        "artistUrl": "https://music.apple.com/us/artist/gunna/1236267297",
        "contentAdvisoryRating": "Explict",
        "artworkUrl100": "https://is5-ssl.mzstatic.com/image/thumb/Music116/v4/e6/52/54/e6525474-f011-257e-04b7-12ecbae264e1/810043689519.jpg/100x100bb.jpg",
        "genres": [
          {
            "genreId": "18",
            "name": "Hip-Hop/Rap",
            "url": "https://itunes.apple.com/us/genre/id18"
          },
          {
            "genreId": "34",
            "name": "Music",
            "url": "https://itunes.apple.com/us/genre/id34"
          }
        ],
        "url": "https://music.apple.com/us/album/drip-season-4ever/1604944424"
      },
      {
        "artistName": "Yeat",
        "id": "1616737518",
        "name": "2 Alivë (Geëk Pack)",
        "releaseDate": "2022-04-01",
        "kind": "albums",
        "artistId": "1318094493",
        "artistUrl": "https://music.apple.com/us/artist/yeat/1318094493",
        "contentAdvisoryRating": "Explict",
        "artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Music126/v4/35/14/ba/3514badc-9226-5994-d1c5-3c37e2cb963c/22UMGIM33359.rgb.jpg/100x100bb.jpg",
        "genres": [
          {
            "genreId": "18",
            "name": "Hip-Hop/Rap",
            "url": "https://itunes.apple.com/us/genre/id18"
          },
          {
            "genreId": "34",
            "name": "Music",
            "url": "https://itunes.apple.com/us/genre/id34"
          }
        ],
        "url": "https://music.apple.com/us/album/2-aliv%C3%AB-ge%C3%ABk-pack/1616737518"
      }
    ]
  }
}
"""

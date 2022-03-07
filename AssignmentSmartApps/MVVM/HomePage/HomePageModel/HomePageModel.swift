//
//  HomePageModel.swift
//  AssignmentSmartApps
//
//  Created by Sanjeev Mehta on 06/03/22.
//

import SwiftyJSON

class HomePageModel {
    
    var adult: Bool?
    var backdropPath = ""
    var genreIds = [Int]()
    var id = ""
    var originalLanguage = ""
    var originalTitle = ""
    var overview = ""
    var popularity = 0.0
    var posterPath = ""
    var releaseDate = ""
    var title = ""
    var video: Bool?
    var voteAverage = 0.0
    var voteCount = 0
    
    init(_ json: JSON) {
        adult = json["adult"].boolValue
        backdropPath = json["backdrop_path"].stringValue
        genreIds = json["genre_ids"].arrayValue.map { $0.intValue }
        id = json["id"].stringValue
        originalLanguage = json["original_language"].stringValue
        originalTitle = json["original_title"].stringValue
        overview = json["overview"].stringValue
        popularity = json["popularity"].doubleValue
        posterPath = json["poster_path"].stringValue
        releaseDate = json["release_date"].stringValue
        title = json["title"].stringValue
        video = json["video"].boolValue
        voteAverage = json["vote_average"].doubleValue
        voteCount = json["vote_count"].intValue
    }
    
}

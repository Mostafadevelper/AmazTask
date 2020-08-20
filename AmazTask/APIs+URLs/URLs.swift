//
//  URLs.swift
//  AmazTask
//
//  Created by Mostafa  on 8/17/20.
//  Copyright © 2020 Mostafa . All rights reserved.
//

import Foundation



struct URLs {
    
    static let main = "https://api.themoviedb.org/3/"
    static let api_key = "e67d90b1888640097d326bb603ec7f54"
    static let base_url = "https://image.tmdb.org/t/p/original"
    /// -Paramter :-
    /// -api_key : String
    /// -page : Int
    static let popular_peaple = main + "person/popular"
    /// api key
    static let details_peaple = main + "person/"
    static let search_name = main + "search/person"
    static let get_popular_image = main + "person/"
    
    
}

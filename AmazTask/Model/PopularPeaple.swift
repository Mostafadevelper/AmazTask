//
//  PopularPeaple.swift
//  AmazTask
//
//  Created by Mostafa  on 8/17/20.
//  Copyright © 2020 Mostafa . All rights reserved.
//

import Foundation

struct  PopularPeaple : Codable {
    
    var page : Int? = 0
    var total_results : Int? = 0
    var total_pages : Int? = 0
    var results : [Results]? = nil
}


struct Results : Codable,Equatable {
    
    var name : String?
    var id : Int?
    var profile_path : String?
    var known_for_department : String?
    var popularity : Double?
    let gender : Int?
    
}


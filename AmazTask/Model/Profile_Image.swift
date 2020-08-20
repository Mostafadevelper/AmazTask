//
//  Profile_Image.swift
//  AmazTask
//
//  Created by Mostafa  on 8/17/20.
//  Copyright © 2020 Mostafa . All rights reserved.
//

import Foundation



struct Profile_Image : Codable {
    
    var profiles : [Profile]? = nil
}


struct Profile : Codable {
    
    var file_path : String?
}

//
//  APIs.swift
//  AmazTask
//
//  Created by Mostafa  on 8/17/20.
//  Copyright © 2020 Mostafa . All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class APIs : NSObject {
    
    // Singletone
    
    static let instance = APIs()
    // Generics Codable to make time easy
    //T type from generic
    func getData<T:Decodable>(method : HTTPMethod = .get,
                              parameter  : [String : Any] ,
                              url: String,
                              header : HTTPHeaders? = [:],
                              encoding : ParameterEncoding = URLEncoding.default ,
                              completion: @escaping (T?, Error?)-> Void) {
        
        Alamofire.request(url,
                          method: method ,
                          parameters: parameter ,
                          encoding: encoding  ,
                          headers: header).responseJSON { (response) in
                            guard let data = response.data else {return}
                            switch response.result {
                            case .success( _):
                                
                                do {
                                    let get =  try JSONDecoder().decode(T.self, from: data)
                                    completion(get,nil)
                                } catch let jsonError {
                                    print(jsonError)
                                }
                                
                            case .failure(let error):
                                
                                completion(nil,error)
                            }
        }
    }
    
}


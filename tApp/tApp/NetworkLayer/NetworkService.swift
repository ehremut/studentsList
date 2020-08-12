//
//  NetworkService.swift
//  tApp
//
//  Created by macOS developer on 16.07.2020.
//  Copyright © 2020 macOS developer. All rights reserved.
//

import Foundation
import SwiftyJSON



protocol NetworkServiceProtocol {
    func getJsonData(completion: @escaping (Result<JSON?, Error>) -> Void)
}



class NetworkService: NetworkServiceProtocol{
    
    func getJsonData(completion: @escaping (Result<JSON?, Error>) -> Void) {
        let urlStr = "http://35.226.204.146:5000/summary"
        
        guard let url = URL(string: urlStr) else {return}
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            do {
                let json = try JSON(data: data!)
                completion(.success(json))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

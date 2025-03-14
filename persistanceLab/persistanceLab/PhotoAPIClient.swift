//
//  PhotoAPIClient.swift
//  persistanceLab
//
//  Created by Sam Roman on 9/30/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation

struct PhotoAPIClient {

static let shared = PhotoAPIClient()



    func getPhotos(str: String, completionHandler: @escaping (Result<Photo,AppError>) -> () ) {
        let key = Secrets.key
    guard let url = URL(string: "https://pixabay.com/api/?key=\(key)&q=\(str)" ) else {
        completionHandler(.failure(.badURL))
        return
    }
    
    NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
        switch result {
        case .failure(let error):
            completionHandler(.failure(error))
        case .success(let data):
            do {
                let response = try JSONDecoder().decode(Photo.self, from: data)
                completionHandler(.success(response))
            } catch {
                completionHandler(.failure(.invalidJSONResponse))
                                   print(error)
            }
        }
    }
    
    
}
}

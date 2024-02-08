//
//  NetworkManager.swift
//  MTWeb
//
//  Created by Gokul A S on 02/06/23.
//

import Foundation

class NetworkManager {
    private let baseURL = "http://run.mocky.io/v3/69ad3ec2-f663-453c-868b-513402e515f0"
    static let shared = NetworkManager()
    
    private init(){}
    
    func fetchData(completion: @escaping (WebData?, Error?) -> ()) {
        let urlString = baseURL
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print(Strings.error, err)
                return
            }
            
            // check response
            
            guard let data = data else { return }
            do {
                let courses = try JSONDecoder().decode(WebData.self, from: data)
                print(courses)
                DispatchQueue.main.async {
                    completion(courses, nil)
                }
            } catch let jsonErr {
                print(Strings.error, jsonErr)
            }
        }.resume()
    }
}

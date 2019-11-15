//
//  PersonController.swift
//  FindACrew
//
//  Created by Marc Jacques on 11/15/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get    =   "GET"
    case post   =   "POST"
    case put    =   "PUT"
    case delete =   "DELETE"
}

class PersonController {
    //#1 What Data are we collecting and what form will we be placing it into

    var people: [Person] = []
    //2 Where will be collecting the data from? What is the API address
    let baseURL = URL(string: "https://swapi.co/api/people")!
    
    //3 Use API Documentation to understand what and how you can manipulate the api data
    func searchForPeople(searchTerm: String, completion: @escaping () -> Void) {
        //4 where exactly is the data your looking to manipulate located? What appending path compnents and query items do you need.
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchQueryItem]
        
        //Hopefully this creates a url like:
        // https://swapi.co/api/people/?search=[searchTerm]
        guard let requestURL = urlComponents?.url else {
            print("request URL is nil")
            completion()
            return
        }
        //5 setup the type of action or URLrequest you will perform while on the website
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue //it's useful to have the compiler help you out. setup an enum
        
        //6 manage all expectations while performing the task of collecting data from the api url including latency, actually accessing data, decoding data, and any errors encountered along the way.
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            guard let data = data else {
                print("No data returned from data task.")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let personSearch = try jsonDecoder.decode(PersonSearch.self, from: data)
                
                self.people.append(contentsOf: personSearch.results)
            } catch {
                print("Unable to decode data into object of type [Person]: \(error)")
            }
            completion()
        }.resume()
    }
}

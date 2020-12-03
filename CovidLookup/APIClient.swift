//
//  APIClient.swift
//  CovidLookup
//
//  Created by Neema on 12/3/20.
//  Copyright © 2020 Neema Philippe. All rights reserved.
//

import Foundation

struct APIClient {
    
    // communicate retrieved data back to the VC that made the call
    // ways in which we can communicate:
    // 1. closure, completion handler
    // 2. notification center
    // 3. delegation
    // 4. combine
    
    // URLSession is an asynchronous API
    // asynchronous code does not block UI, synchronous code blocks UI
    // escaping closure - function returns before
    func fetchCovidData(completion: () -> ()) {
        //1. endpoint URL String
        let endpointURLString = "https://api.covid19api.com/summary"
        
        //2. convert the string to an URL
        guard let url = URL(string: endpointURLString) else {
            print("bad url")
            return
        }
        //3. make the request using URLSession
        // .shared is a singleton
        // need to get top level json - SummaryWrapper
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
//               return completion(.failure(error))
            }
            if let jsonData = data {
                //JSON Decoder is a function that throws, need a do/catch
                // convert data to our swift model
                do {
                    let countries = try JSONDecoder().decode(SummaryWrapper.self, from: jsonData)
                } catch {
//                    completion(.failure(error))
                }
            }
        }
        
        dataTask.resume()
    }
}

//
//  UrlShortener.swift
//  Tarea06
//
//  Created by Cristian Zuniga on 21/3/21.
//

import SwiftUI

struct UrlResult : Codable {
    
    let result_url: String
}

struct UrlPostBody : Codable {
    
    let url: String
}

class UrlShortenerViewModel: ObservableObject {
    
    @Published var Url_Result: String = ""
       
    func getShortenURL(inputUrl: UrlPostBody){
        guard let url = URL(string: "https://cleanuri.com/api/v1/shorten") else {
            print("Your API end point is Invalid")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //let jsonData = try? JSONSerialization.data(withJSONObject: UrlPostBody.self)
        let jsonData  = try? JSONEncoder().encode(inputUrl)
        request.httpBody = jsonData
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // The shared singleton session object.
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                if let response = try? JSONDecoder().decode(UrlResult.self, from: data) {
                    DispatchQueue.main.async {
                        self.Url_Result = response.result_url
                    }
                    return
                }
            }
            
        }.resume()
    }
}

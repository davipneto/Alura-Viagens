//
//  ReqresAPI.swift
//  Alura Viagems Swift
//
//  Created by Curitiba01 on 10/09/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class ReqressAPI {
    static let shared = ReqressAPI()
    
    let baseURL = "https://reqres.in/api"
    
    func getUsers(completion: @escaping (_ users: [User]) -> Void) {
        let getUsersPath = baseURL + "/users"
        guard let url = URL(string: getUsersPath) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        AF.request(urlRequest).responseData { responseData in
            if let error = responseData.error {
                print(error.errorDescription ?? "")
                return
            }
            guard let data = responseData.data,
               let json = try? JSON(data: data)
            else { return }
            
            let users = json["data"].arrayValue.map { User(json: $0) }
            completion(users)
        }
    }
    
    func createUser(name: String, job: String) {
        let createUserPath = baseURL + "/users"
        
        let body: [String: Any] = [
            "name": name,
            "job": job
        ]
        
        AF.request(createUserPath, method: .post, parameters: body).responseData { responseData in
            
            if let error = responseData.error {
                print(error.errorDescription ?? "")
                return
            }
            guard let data = responseData.data,
               let json = try? JSON(data: data)
            else { return }
            
            print(json)
        }
        
    }
}

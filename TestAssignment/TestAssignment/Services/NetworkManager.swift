//
//  NetworkManager.swift
//  TestAssignment
//
//  Created by Дмитрий Куприенко on 27.01.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private var usersResponceArray: [Results] = []
    
    func fetchUserData(page: Int, completionBlock: @escaping(([Results]) -> ())) {
        
        let pageSting = "&page=\(page)"
        
        AF.request(requestUrlString+pageSting).response { [self] usersResponceData in
            
            do {
                
                let emptyData = Data.init()
                var indexForAppend = 0
                let jsonDecoder = JSONDecoder()
                let usersResponceModel = try jsonDecoder.decode(UsersResponce.self, from: usersResponceData.data ?? emptyData)
                for _ in usersResponceModel.results ?? [] {
                    self.usersResponceArray.append(usersResponceModel.results![indexForAppend])
                    indexForAppend += 1
                }
                indexForAppend = 0
                completionBlock(usersResponceArray)
            } catch {
                print(error)
            }
        }
    }
}

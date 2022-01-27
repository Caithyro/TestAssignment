//
//  File.swift
//  TestAssignment
//
//  Created by Дмитрий Куприенко on 27.01.2022.
//

import Foundation

class MainViewModel {
    
    var usersData: [Results] = []
    var page = 1
    
    private let networkManager = NetworkManager.shared
    
    func getUserDataForPage(completionBlock: @escaping(() -> ())) {
        
        networkManager.fetchUserData(page: page, completionBlock: { responce in
            self.usersData = responce
            completionBlock()
        })
    }
}

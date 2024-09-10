//
//  UserViewModel.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//

import Foundation

@Observable class UserViewModel {
    private var users = [User]()
    var searchUsers = [User]()
    var page = 0
    var messageError = ""
    var isLoading: Bool = false
    var keyword: String = ""
    
    private let serviceAPI = ServiceAPI()
    private let perPage = 20
    
    init(){
        getUsers()
    }
    
    func refreshData(){
        page = 0
        users.removeAll()
        getUsers()
    }
    
    func getUsers() {
        page += 1
        
        if(page == 1) { self.isLoading = true }
        
        let urlString = ValuesAPI.USER
        self.serviceAPI.get([User]?.self, url: URL(string: urlString)){ result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.messageError = error.localizedDescription
                case .success(let data):
                    data?.forEach { user in
                        self.users.append(user)
                        self.searchUsers.append(user)
                    }
                }
            }
        }
    }
    
    func searchLocalUser(){
        self.searchUsers = users.filter{ user in
            user.name!.lowercased().contains(self.keyword.lowercased())
        }
    }
}

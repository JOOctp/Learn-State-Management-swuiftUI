//
//  TodoViewModel.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//

import Foundation

enum AlertType {
    case general
    case accept
    case reject
}

@Observable class TodoViewModel {
    var todos = [Todo]()
    var selectedTodo: Todo?
    var page = 0
    var messageError = ""
    var isLoading: Bool = true
    var isLoadingDialog: Bool = false
    var isShowAlert: Bool = false
    var showToast: Toast? = nil
    var alertType: AlertType = AlertType.general
    
    var dropDown = [
        DropDown(label: "Diterima", value: "approved"), DropDown(label: "Menunggu", value: "waiting"),
        DropDown(label: "Dibatalkan", value: "declined")
    ]
    var selectedDropdown: DropDown?
    
    private let serviceAPI = ServiceAPI()
    private let perPage = 20
    
    init(){
        selectedDropdown = dropDown[1]
        getTodos()
    }
    
    func refreshData(){
        page = 0
        todos.removeAll()
        getTodos()
    }
    
    func getTodos() {
        page += 1
        
        if(page == 1) { self.isLoading = true }
        let urlString = ValuesAPI.TODO
        
        self.serviceAPI.get([Todo]?.self, url: URL(string: urlString)){ result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.showToast = Toast(type: .danger, message: error.localizedDescription)
                case .success(let data):
                    data?.forEach { todo in
                        self.todos.append(todo)
                    }
                }
            }
        }
    }
}

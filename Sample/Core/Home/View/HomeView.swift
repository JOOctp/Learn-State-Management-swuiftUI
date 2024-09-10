//
//  HomeView.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//

import SwiftUI

struct HomeView: View {
    @State var homeVM = HomeViewModel()
    
    var body: some View {
        TabView{
            UserView()
                .environment(homeVM)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("User")
                }
                .tag(0)
            
            TodoView()
                .environment(homeVM)
                 .tabItem {
                     Image(systemName: "list.clipboard.fill")
                     Text("Todo")
                 }
                 .tag(1)
        }
    }
}

#Preview {
    HomeView()
}

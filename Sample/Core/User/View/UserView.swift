//
//  UserView.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//

import SwiftUI

struct UserView: View {
    @Environment(HomeViewModel.self) private var homeVM
    @State var userVM = UserViewModel()
    
    var body: some View {
        NavigationStack{
            GeometryReader{ geometry in
                ScrollView{
                    if(userVM.isLoading){
                        VStack(content: {
                            ForEach(0...5, id: \.self) { count in
                                UserItemView(user: User.MockUser())
                                Divider()
                            }
                        })
                        .loadingShimmer(
                            config: .init(
                                tint: .gray,
                                highlight: .white
                            )
                        )
                        .navigationTitle("Mitra Sewasam")
                        .navigationBarTitleDisplayMode(.inline)
                    } else if(userVM.searchUsers.isEmpty){
                        ContentUnavailableView {
                            Label("Data Kosong", systemImage: "magnifyingglass")
                        } description: {
                            Text("Mitra yang kamu cari tidak ada,\ncoba ganti keyword mu")
                        }
                        .frame(width: geometry.size.width)
                        .frame(minHeight: geometry.size.height)
                    } else {
                        LazyVStack(content: {
                            ForEach(userVM.searchUsers) { user in
                                VStack(spacing: 0){
                                    NavigationLink(destination: DetailUserView(user: user)){
                                        UserItemView(user: user).onAppear{
                                            // LOGIC PAGINATION
//                                            if(user.id == userVM.users.last?.id){
//                                                userVM.getUsers()
//                                            }
                                        }
                                    }
                                    Divider()
                                }
                            }
                        })
                    }
                }
                .refreshable {
                    userVM.refreshData()
                }
                .disabled(userVM.isLoading)
            }
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $userVM.keyword, prompt: "Cari Nama Mitra")
        .textInputAutocapitalization(.never)
        .onChange(of: userVM.keyword){
            if(userVM.keyword.isEmpty){
                userVM.refreshData()
            }
        }
        .onSubmit(of: .search){
            userVM.searchLocalUser()
        }
        .toolbar(homeVM.tabbarVisibility, for: .tabBar)
        .animation(.default, value: homeVM.tabbarVisibility)
    }
}

#Preview {
    UserView()
}

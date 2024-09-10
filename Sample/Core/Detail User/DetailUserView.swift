//
//  DetailUserView.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//

import SwiftUI

struct DetailUserView: View {
    let user: User
    @Environment(HomeViewModel.self) private var homeVM
    
    var body: some View {
        VStack {
            ScrollView{
                VStack(alignment: .leading, spacing: 16) {
                    HStack(){
                        VStack(alignment:.leading){
                            Text("Usename")
                                .font(.system(size: 12))
                                .foregroundStyle(.gray)
                            
                            Text("\(user.username ?? "-")")
                                .font(.system(size: 14))
                                .foregroundStyle(Color("GeneralTextColor"))
                        }
                        Spacer()
                        VStack(alignment:.trailing){
                            Text("email")
                                .font(.system(size: 12))
                                .foregroundStyle(.gray)
                            
                            Text("\(user.email ?? "-")")
                                .font(.system(size: 14))
                                .foregroundStyle(Color("GeneralTextColor"))
                        }
                    }
                    HStack(){
                        VStack(alignment:.leading){
                            Text("Webiste")
                                .font(.system(size: 12))
                                .foregroundStyle(.gray)
                                .multilineTextAlignment(.leading)
                            
                            Text(user.website ?? "-")
                                .font(.system(size: 14))
                                .foregroundStyle(Color("GeneralTextColor"))
                        }
                        Spacer()
                        VStack(alignment:.trailing){
                            Text("company")
                                .font(.system(size: 12))
                                .foregroundStyle(.gray)
                            
                            Text("\(user.company?.name ?? "Perusahaan")")
                                .font(.system(size: 14))
                                .foregroundStyle(Color("GeneralTextColor"))
                        }
                    }
                }
            }.padding(16)
            
            Spacer()
            Divider()
            Button {
                let setupPhone = user.phone ?? ""
                if let url = URL(string: "https://api.whatsapp.com/send?phone=62\(setupPhone)&text=" +
                                 "Halo Test"
                ) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:])
                    }
                }
            } label: {
                Text("Hubungi User")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .padding(8)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, 16)
            .padding(.top, 12)
        }
        .onAppear{
            homeVM.tabbarVisibility = .hidden
        }
        .onDisappear{ homeVM.tabbarVisibility = .visible }
        .navigationTitle(user.name?.capitalized ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    DetailUserView(user: User.MockUser())
}

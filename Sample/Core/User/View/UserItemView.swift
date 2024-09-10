//
//  UserItemView.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//

import SwiftUI

struct UserItemView: View {
    let user: User
    
    var body: some View {
        VStack(spacing: 8){
            HStack(){
                Text("\(user.id ?? -1) - \(user.name ?? "")".capitalized)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundStyle(Color("GeneralTextColor"))
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .tint(Color("GeneralTextColor"))
            }
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
        .padding(16)
        .cornerRadius(4.0)
    }
}

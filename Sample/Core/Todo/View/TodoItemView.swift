//
//  TodoItemView.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//

import SwiftUI

struct TodoItemView: View {
    let todo: Todo
    
    var body: some View {
        VStack(spacing: 8){
            HStack(){
                Text(todo.title ?? "-")
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundStyle(Color("GeneralTextColor"))
                Spacer()
                Image(systemName: "chevron.right")
                    .tint(Color("GeneralTextColor"))
            }
            HStack(){
                VStack(alignment:.leading){
                    Text("Id")
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.leading)
                    
                    Text("\(todo.id ?? -1)")
                        .font(.system(size: 14))
                        .foregroundStyle(Color("GeneralTextColor"))
                }
                Spacer()
                VStack(alignment:.trailing){
                    Text("User Id")
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                    
                    Text("\(todo.userId ?? -1)")
                        .font(.system(size: 14))
                        .foregroundStyle(Color("GeneralTextColor"))
                }
            }
            VStack{
                Text("Completed")
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(todo.completed!)".capitalized)
                    .font(.system(size: 14))
                    .foregroundStyle(todo.completed! ? .green : .red)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(16)
    }
}

#Preview {
    TodoItemView(todo: Todo.MockTodo())
}


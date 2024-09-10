//
//  TodoView.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//

import SwiftUI

struct TodoView: View {
    @State var todoVM = TodoViewModel()
    
    var body: some View {
        NavigationStack{
            GeometryReader { geometry in
                VStack {
                    Menu{
                        ForEach(todoVM.dropDown, id: \.value) { dropDown in
                            Button(action: {
                                todoVM.selectedDropdown = dropDown
//                                todoVM.refreshData()
                            }, label: {
                                Text(dropDown.label)
                            })
                        }
                    } label: {
                        Text(todoVM.selectedDropdown?.label ?? "-")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .padding(16)
                            .foregroundStyle(Color("GeneralTextColor"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.gray, lineWidth: 0.3)
                    )
                    .menuStyle(.borderlessButton)
                    .padding(.horizontal, 16)
                    
                    ScrollView {
                        if(todoVM.isLoading){
                            ForEach(0...4, id: \.self) { count in
                                VStack(spacing: 0){
                                    TodoItemView(todo: Todo.MockTodo())
                                    Divider()
                                }.loadingShimmer(
                                    config: .init(
                                    tint: .gray,
                                    highlight: .white)
                                )
                            }
                        } else if(todoVM.todos.isEmpty){
                            ContentUnavailableView {
                                Label("Data Kosong", systemImage: "magnifyingglass")
                            } description: {
                                Text("Data Todo,\ncoba atur filter mu")
                            }
                            .frame(width: geometry.size.width)
                            .frame(minHeight: geometry.size.height)
                        } else {
                            LazyVStack(content: {
                                ForEach(todoVM.todos) { todo in
                                    VStack(spacing: 0){
                                        TodoItemView(todo: todo)
                                            .background(Rectangle().fill(Color(UIColor.systemBackground)))
                                            .onTapGesture{
                                                todoVM.alertType = AlertType.general
                                                todoVM.isShowAlert = true;
                                            }
                                            .onAppear{
                                                // LOGIC PAGINATION
//                                                if(todo.id == todoVM.todo.last?.id){
//                                                    todoVM.getSubscription()
//                                                }
                                            }
                                        Divider()
                                    }
                                }
                            })
                        }

                    }
                    .refreshable {
                        todoVM.refreshData()
                    }
                    .disabled(todoVM.isLoading)
                }
            }
            .alert(isPresented: $todoVM.isShowAlert, content: {
                if(todoVM.alertType == .accept){
                    Alert(
                        title: Text("Tunggu Dulu"),
                        message: Text("Apakah kamu yakin untuk menerima permintaan berlangganan ini ?"),
                        primaryButton: .default(Text("Ya, Yakin"), action: {
                            todoVM.selectedTodo = nil
                        }),
                        secondaryButton: .destructive(Text("Batalkan"), action: {
                            todoVM.selectedTodo = nil
                        })
                    )
                } else if(todoVM.alertType == .reject){
                    Alert(
                        title: Text("Tunggu Dulu"),
                        message: Text("Apakah kamu yakin untuk menolak permintaan berlangganan ini ?"),
                        primaryButton: .default(Text("Ya, Yakin"), action: {
                            todoVM.selectedTodo = nil
                        }),
                        secondaryButton: .destructive(Text("Batalkan"), action: {
                            todoVM.selectedTodo = nil
                        })
                    )
                } else {
                    Alert(
                        title: Text("Update Status"),
                        message: Text("Kamu dapat menerima dan menolak permintaan berlangganan mitra sewasam"),
                        primaryButton: .default(Text("Terima"), action: {
                            todoVM.alertType = AlertType.accept
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                todoVM.isShowAlert = true
                            }
                        }),
                        secondaryButton: .destructive(Text("Tolak"), action: {
                            todoVM.alertType = AlertType.reject
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                todoVM.isShowAlert = true
                            }
                        })
                    )
                }
            })
            .background(Rectangle().fill(Color(UIColor.systemBackground)))
            .onTapGesture {
                todoVM.isShowAlert = false;
            }
            .showCustomToast(toast: $todoVM.showToast)
            .modifier(ActivityIndicatorModifier(isLoading: todoVM.isLoadingDialog))
            .navigationTitle("Todos")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TodoView()
}

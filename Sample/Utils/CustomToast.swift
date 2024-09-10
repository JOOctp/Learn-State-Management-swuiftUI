//
//  CustomToast.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//

import Foundation
import SwiftUI

struct Toast: Equatable {
    var type: ToastType
    var message: String
    var isShort: Bool = true
}

enum ToastType {
    case success
    case danger
    case warning
}

extension ToastType {
    var themeColor: Color {
        switch self {
        case .success: return Color.green
        case .danger: return Color.red
        case .warning: return Color.yellow
        }
    }
    
    var iconFileName: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .danger: return "xmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        }
    }
}

struct CustomToastView: View {
    let toastType: ToastType
    let message: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 16){
            Image(systemName: toastType.iconFileName)
                .foregroundColor(toastType.themeColor)
            
            Text(message)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("ToastBackgroundColor"))
        .cornerRadius(8)
        .overlay{
            RoundedRectangle(cornerRadius: 8)
                .stroke(toastType.themeColor, lineWidth: 2)
        }
        .padding(.horizontal, 16)
    }
}

struct CustomToastModifier: ViewModifier {
    
    @Binding var toast: Toast?
    @State private var workItem: DispatchWorkItem?
      
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                }.animation(.spring(), value: toast)
            )
            .onChange(of: toast) {
                showToast()
            }
    }
      
    @ViewBuilder func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                CustomToastView(toastType: toast.type, message: toast.message)
                Spacer()
            }
        }
    }
      
    private func showToast() {
        guard let toast = toast else { return }
        
        UIImpactFeedbackGenerator(style: .light)
            .impactOccurred()
        
        workItem?.cancel()
        
        let task = DispatchWorkItem {
            dismissToast()
        }
        
        let duration = toast.isShort ? 1.5 : 3
        
        workItem = task
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: task)
    }
      
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
          
        workItem?.cancel()
        workItem = nil
    }
}

extension View {
    func showCustomToast(toast: Binding<Toast?>) -> some View {
        self.modifier(CustomToastModifier(toast: toast))
    }
}


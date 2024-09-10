//
//  ActivityIndicator.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//
import Foundation
import SwiftUI

struct ActivityIndicator : UIViewRepresentable {
    
    typealias UIViewType = UIActivityIndicatorView
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct ActivityIndicatorModifier: AnimatableModifier {
    var isLoading: Bool

    init(isLoading: Bool, color: Color = .primary, lineWidth: CGFloat = 3) {
        self.isLoading = isLoading
    }

    var animatableData: Bool {
        get { isLoading }
        set { isLoading = newValue }
    }

    func body(content: Content) -> some View {
        ZStack {
            if isLoading {
                GeometryReader { geometry in
                    ZStack(alignment: .center) {
                        content
                            .disabled(self.isLoading)
                            .blur(radius: self.isLoading ? 3 : 0)

                        VStack {
                            Text("Please Wait...")
                                .padding([.top, .horizontal], 16)
                            ActivityIndicator(isAnimating: .constant(true), style: .large)
                                .padding([.bottom, .horizontal], 16)
                        }
                        .background(Color.secondary.colorInvert())
                        .foregroundColor(Color.primary)
                        .cornerRadius(16)
                        .opacity(self.isLoading ? 1 : 0)
                        .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
                    }
                }
            } else {
                content
            }
        }
    }
}

//
//  ShimmerLoading.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//

import Foundation
import SwiftUI

struct ShimmerConfig {
    var tint: Color
    var highlight: Color
    var highlightOpacity: CGFloat = 1
    var speed: CGFloat = 2
    var blendMode: BlendMode = .normal
}

extension View {
    @ViewBuilder
    func loadingShimmer(config: ShimmerConfig) -> some View {
        self.modifier(ShimmerEffectHelper(config: config))
    }
}

fileprivate struct ShimmerEffectHelper: ViewModifier {

    var config: ShimmerConfig
    @State private var moveTo: CGFloat = -0.8

    func body(content: Content) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.clear)
                    .mask {
                        content
                    }
                    .overlay {
                        GeometryReader {
                            let size = $0.size
                            let extraOffset = size.height / 2.5 + 50
                            
                            Rectangle()
                                .fill(config.highlight)
                                .mask {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(
                                            .linearGradient(colors: [
                                                .white.opacity(0.0),
                                                config.highlight.opacity(config.highlightOpacity),
                                                .white.opacity(0.0)
                                            ], startPoint: .top, endPoint: .bottom)
                                        )
                                        .rotationEffect(.init(degrees: 45))
                                        .offset(x: moveTo > 0 ? extraOffset : -extraOffset)
                                        .offset(x: size.width * moveTo)
                                }
                                .blendMode(config.blendMode)
                                .background(config.tint)
                        }
                        .mask {
                            content
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.async {
                            moveTo = 0.8
                        }
                    }
                    .animation(.linear(duration: config.speed).repeatForever(autoreverses: false), value: moveTo)
            }
            .redacted(reason: .placeholder)
    }
}

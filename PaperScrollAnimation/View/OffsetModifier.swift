//
//  OffsetModifier.swift
//  PaperScrollAnimation
//
//  Created by 김휘진 on 2021/11/23.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    
    @Binding var rect: CGRect
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader{proxy in
                    Color.clear
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")))
                }
            )
            .onPreferenceChange(OffsetKey.self){ value in
                self.rect = value
            }
    }
}

//Offset preference key
struct OffsetKey: PreferenceKey{
    
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
    
}

//
//  LottieAnimationview.swift
//  LotteExercise
//
//  Created by 김휘진 on 2021/11/14.
//

import SwiftUI
import Lottie

struct LottieAnimationview: UIViewRepresentable {

    var jsonFile: String
    func makeUIView(context: Context) -> AnimationView {
        let animationView = AnimationView(name: jsonFile, bundle: .main)
        animationView.backgroundColor = .clear
        return animationView
    }
    
    func updateUIView(_ uiView: AnimationView, context: Context) {
        
    }
}

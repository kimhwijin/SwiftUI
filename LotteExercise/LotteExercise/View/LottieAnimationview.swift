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
    @Binding var progress: CGFloat
    func makeUIView(context: Context) -> UIView {
        
        
        //UIView 를 만들고, lottie 이미지를 센터에 위치시킨다.
        let rootView = UIView()
        rootView.backgroundColor = .clear

        //lottie 이미지를 위치시키는 애니메이션 뷰
        let animationView = AnimationView(name: jsonFile, bundle: .main)
        animationView.backgroundColor = .clear
        animationView.tag = 1009
        //뷰 사이즈가 제약에 맞춰서 리사이징 되는것을 막음
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        //lottie 이미지가 들어가있는 애니메이션 뷰와 그걸 덮는 UIView의 크기를 일치시켜서 lottie 이미지 사이즈를 조정한다.
        let constraints = [
            animationView.widthAnchor.constraint(equalTo: rootView.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: rootView.heightAnchor),
        ]
        
        rootView.addSubview(animationView)
        rootView.addConstraints(constraints)
        
        return rootView
        
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

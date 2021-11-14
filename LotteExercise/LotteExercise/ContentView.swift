//
//  ContentView.swift
//  LotteExercise
//
//  Created by 김휘진 on 2021/11/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        feelingEmojiView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct feelingEmojiView: View{
    var body: some View{
        
        VStack{
            LottieAnimationview(jsonFile: "feeling_emoji")
            //직접 애니매이션 뷰의 lottie 이미지 사이즈를 조정 불가능하다...
            //UIView로 덮어서 사이즈를 조정할 수 있다.
                //.frame(width: 300, height: 300)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                colors: [
                    Color.green,
                    Color.blue,
                    Color.pink,
                ],
                startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
        
    }
}

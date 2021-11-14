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
        }
        
    }
}

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
    @State var offset: CGFloat = 0
    @State var currentSliderProgress: CGFloat = 0.5
    @GestureState var isDragging: Bool = false
    
    var body: some View{
        
        VStack(spacing: 15){
            Text(getAttributedstring())
                .font(.system(size: 45))
                .fontWeight(.medium)
                .kerning(1.1)
                .padding(.top)
            
            
            GeometryReader{proxy in
                let size = proxy.size
                LottieAnimationview(jsonFile: "feeling_emoji",
                                    progress: $currentSliderProgress)
                    .frame(width: size.width, height: size.height)
                    .scaleEffect(2)
                //직접 애니매이션 뷰의 lottie 이미지 사이즈를 조정 불가능하다...
                //UIView로 덮어서 사이즈를 조정할 수 있다.
                    //.frame(width: 300, height: 300)
            }
            
            //Slider...
            ZStack{
                    Rectangle()
                    .fill(.white)
                    .frame(height: 1)
                Group{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.black)
                        .frame(width: 55, height: 55)
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 11, height: 11)
                }
                //.frame(width: .infinity, alignment: .center)
                .contentShape(Rectangle())
                .offset(x: offset)
                //제스쳐..
                .gesture(
                    DragGesture(minimumDistance: 5)
                        .updating($isDragging, body: {_, out, _ in
                            out = true
                        })
                        .onChanged({value in
                            
                            var translation = value.location.x
                        
                            //stop start , end
                            translation -= 30
                            translation = translation > -145 ? translation : -145
                            translation = translation < 145 ? translation : 145
                            translation = isDragging ? translation : 0
                            offset = translation
                            let progress = (translation + 145) / 290
                            //0~1
                            currentSliderProgress = progress
                        })
                )
            }
            .padding(.bottom, 20)
            .offset(y: -10)
            
            //컨펌 버튼
            Button{
                let star = (currentSliderProgress * 5).rounded()
                print(star)
 
            }label: {
                Text("Done")
                    .font(.title3)
                    .fontWeight(.medium)
                    .kerning(1.1)
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(
                        Color.black,
                        in: RoundedRectangle(cornerRadius: 20)
                    )
            }
            .padding(.horizontal, 15)
            
            
            
        }
        .padding(15)
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
        .overlay(
            Button(action: {},label:{
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.black)
            })
                .padding(.trailing)
                .padding(.top)
            , alignment: .topTrailing
        )
        
    }
    
    func getAttributedstring()-> AttributedString{
        var str = AttributedString("당신의 상태는?")
        if let range = str.range(of: "상태는?"){
            str[range].foregroundColor = .white
        }
        return str
    }
}

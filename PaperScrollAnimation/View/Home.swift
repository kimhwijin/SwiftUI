//
//  Home.swift
//  PaperScrollAnimation
//
//  Created by 김휘진 on 2021/11/23.
//

import SwiftUI

struct Home: View {
    var body: some View {
        
        VStack{
            Text("Historical letters")
                .font(.largeTitle.bold())
                .foregroundColor(.black)
                .padding(.top, 25)
                .padding(.bottom, 30)
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 30){
                    //
                    ForEach(letters){
                        letter in LetterCardView(letter: letter)
                        //
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .coordinateSpace(name: "SCROLL")
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.gray
                .ignoresSafeArea()
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


struct LetterCardView: View{
    var letter: Letter
    
    @State var rect: CGRect = .zero
    
    var body: some View{
        
        VStack(spacing: 15){
            VStack(alignment: .leading, spacing: 12){
                Text(letter.date)
                    .font(.title2.bold())
                Text(letter.title)
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
                .padding(.vertical, 10)
            
            
            Text("I am running Catalina (10.15) with XCode11. After creating a new project and selecting the option to Use SwiftUI, the file opens, but i get an error  troubleshoot it?\nCreated a new project, and it wa still not allowing a preview. Then I realized that my Documents folder is actually being stored in iCloud Drive. I went back to my root user directory on my local HD and created a new folder in my user folder for the project, and after creating it, it worked without issue.")
                .lineSpacing(11)
                .multilineTextAlignment(.leading)
                .foregroundColor(.black)
        }
        .padding()
        .background(
            Color.white
                .cornerRadius(6)
        )
        //masking view , like letter is shrinking
        .mask(){
            Rectangle()
                .padding(.top, rect.minY < (getIndex() * 50) ? -(rect.minY - (getIndex() * 50)) : 0)
        }
        .offset(y: rect.minY < (getIndex() * 50) ? (rect.minY - (getIndex() * 50)) : 0)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
        //stop back ward scrolling...
        //이곳에서 스크롤을 멈추고 위치시키는 이유는 돌돌말려진 편지를 표현하려면 스크린에 계속 있어야 되기때문에.
        
        //돌돌 말리는 친구
        .overlay(
            ScrolledLetterShape()
            
            , alignment: .top
        )
        //카드 돌돌 말리는 친구끼리 분리
        //offset(y: rect.minY < 0 ? -(rect.minY) : 0)
        .offset(y: rect.minY < (getIndex() * 50) ? -(rect.minY - (getIndex() * 50)) : 0)
        .modifier(OffsetModifier(rect: $rect))
        
        .background(
            Text("no more letters")
                .font(.title.bold())
                .foregroundColor(.white)
                .opacity(isLast() ? 1 : 0)
                .offset(y: rect.minY < 0 ? -rect.minY : 0)
        )
        
        //appling bottom padding for last letter to allow scrolling
        .padding(.bottom, isLast() ? rect.height : 0)
    }
    
    func isLast()->Bool{
        return letters.last == letter
    }
    
    func getIndex()->CGFloat{
        let index = letters.firstIndex { letter in
            return self.letter.id == letter.id
        } ?? 0
        
        return CGFloat(index)
    }
    
    
    //몇퍼센트 스크롤 되고있는지...
    func getProgress()->CGFloat{
        let progress = -rect.minY / rect.height
        
        return (progress > 0 ? (progress < 1 ? progress : 1) : 0)
    }
        
    @ViewBuilder
    func ScrolledLetterShape()->some View{
        Rectangle()
            .fill(Color.white)
            .frame(height: 30 * getProgress())
            .overlay(
                Rectangle()
                    .fill(
                        .linearGradient(.init(colors: [
                            Color.black.opacity(0.1),
                            Color.clear,
                            Color.brown.opacity(0.4),
                            Color.black.opacity(0.05)
                        ]), startPoint: .top, endPoint: .bottom)
                    )
                , alignment: .top
            )
            .cornerRadius(6)
            .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
            .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
    }
    
}

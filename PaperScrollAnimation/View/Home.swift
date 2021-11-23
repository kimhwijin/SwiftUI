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
                .foregroundColor(.gray)
        }
        .padding()
        .background(
            Color.white
                .cornerRadius(6)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
        //stop back ward scrolling...
        .offset(y: rect.minY < 0 ? -rect.minY : 0)
        .modifier(OffsetModifier(rect: $rect))
    }
        
}

//
//  Home.swift
//  LiquidSwipe
//
//  Created by 김휘진 on 2021/12/03.
//

import SwiftUI

struct Home: View {
    @State var intros: [Intro] = [
        
        Intro(title: "Plan", subTitle: "your rotues", description: "View your collection route Follow, change or add to your route yourself", pic: "Pic1", color: Color.green),
        Intro(title: "Quick waste", subTitle: "your rotues", description: "View your collection route Follow, change or add to your route yourself", pic: "Pic1", color: Color.gray),
        Intro(title: "Invite", subTitle: "your rotues", description: "View your collection route Follow, change or add to your route yourself", pic: "Pic1", color: Color.yellow),
        Intro(title: "None", subTitle: "your rotues", description: "View your collection route Follow, change or add to your route yourself", pic: "Pic1", color: Color.red)
        
    ]
    var body: some View {
        ZStack{
            
            //indice를 쓰는이유 : offset update 를 realtime 으로 진행해야됨.
            ForEach(intros.indices.reversed(), id: \.self){index in
                IntroView(intro: intros[index])
                
            }
        }
    }
    
    @ViewBuilder
    func IntroView(intro: Intro)-> some View{
        VStack{
            
            Image(intro.pic)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(40)
            
            VStack(alignment: .leading, spacing: 0){
                //Title
                Text(intro.title)
                    .font(.system(size: 45))
                //SubTitle
                Text(intro.subTitle)
                    .font(.system(size: 50, weight: .bold))
                //Description
                Text(intro.description)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .padding(.top)
                    .frame(width: getRect().width - 100)
                    .lineSpacing(8)
                
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .padding([.trailing, .top])
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            intro.color
                .ignoresSafeArea()
        )
    }
}

//Extending View to get Screen bounds...
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}

struct LiquidShape: Shape{
    var offset: CGSize
    
    func path(in rect: CGRect) -> Path {
        return Path{path in
            
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


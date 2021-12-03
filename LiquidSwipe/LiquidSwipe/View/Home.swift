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
                .clipShape(LiquidShape())
                .ignoresSafeArea()
                .overlay(
                    Image(systemName: "chevron.left")
                        .font(.largeTitle)
                        .offset(y: 80)
                    ,alignment: .topTrailing
                )
                .padding(.trailing)
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
    //var offset: CGSize
    
    func path(in rect: CGRect) -> Path {
        return Path{path in
            
            let width: CGFloat = rect.width
            let height: CGFloat = rect.height
            //기본적인 사각형 생성 지점
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            //커브 생성
            //여기서부터 height / 10 에서부터
            let start: CGFloat = height / 11
            let end: CGFloat = start * 3
            let mid: CGFloat = start * 2
            let widthOffset: CGFloat = width / 5
            path.move(to: CGPoint(x: width, y: start))
            //여길 거쳐서
            path.addCurve(to: CGPoint(x: width, y: end),
                          control1: CGPoint(x: width - widthOffset / 2, y: mid),
                          control2: CGPoint(x: width - widthOffset, y: mid)
            )
            
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


//
//  Home.swift
//  LiquidSwipe
//
//  Created by 김휘진 on 2021/12/03.
//

import SwiftUI

struct Home: View {
    @State var offset: CGSize = .zero
    
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
                .clipShape(LiquidShape(offset: offset))
                .ignoresSafeArea()
                .overlay(
                    Image(systemName: "chevron.left")
                        .font(.largeTitle)
                        //드레그 제스쳐하는 오브젝트 생성
                        .frame(width: 50, height: 50)
                        .contentShape(Rectangle())
                        .gesture(DragGesture().onChanged({ (value) in
                            //스왑하는 애니메이션
                            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)){
                                offset = value.translation
                            }
                        }).onEnded({ (value) in
                            withAnimation(.spring()){
                                offset = .zero
                            }
                        }))
                        .offset(x: 10, y: 28)
                    
                    
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
    
    var offset: CGSize
    
    func path(in rect: CGRect) -> Path {
        return Path{path in
            
            //드레그 할때, 화살표 위아래도 같이 크기증가
            //드레그 할때 오프셋이 적용된 높이 너비
            let width: CGFloat = rect.width + (-offset.width > 0 ? offset.width : 0)
            let widthOffset: CGFloat = rect.width / 5
            
            //기본적인 사각형 생성 지점
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            //커브 생성
            //여기서부터 height / 16 에서부터
            //offset width, height 에 따라서 부드럽게, 밖으로 드레그는 무시하게끔
            let start: CGFloat = rect.height / 16 + (-offset.width > 0 ? offset.width : 0)
            
            var end: CGFloat = rect.height * 3 / 16 + (offset.height - offset.width)
            end = end < rect.height * 3 / 16 ? rect.height * 3 / 16 : end
            
            let mid: CGFloat = (start + end) / 2
            path.move(to: CGPoint(x: rect.width, y: start))
            //튀어나온 커브 그리기
            path.addCurve(to: CGPoint(x: rect.width, y: end),
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


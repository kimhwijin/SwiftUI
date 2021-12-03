//
//  Home.swift
//  LiquidSwipe
//
//  Created by 김휘진 on 2021/12/03.
//

import SwiftUI

struct Home: View {
    
    @GestureState var isDragging: Bool = false
    @State var fakeIndex: Int = 0
    @State var currentIndex: Int = 0
    
    @State var offset: CGSize = .zero
    
    @State var intros: [Intro] = [
        
        Intro(title: "Plan", subTitle: "your rotues", description: "View your collection route Follow, change or add to your route yourself", pic: "Pic1", color: Color.green),
        Intro(title: "Quick waste", subTitle: "taste break", description: "View so musch i love you so much ververy Thank you! yourself", pic: "Pic2", color: Color(UIColor.darkGray)),
        Intro(title: "Invite", subTitle: "mouse a trick", description: "View your collection route Follow, change or add to your route yourself", pic: "Pic3", color: Color.yellow),
        Intro(title: "None", subTitle: "your rotues", description: "ForEach(intros.indices.reversed({index inIntroView(intro: intros[index]).clipShape(LiquidShape(offset: intros[index].offset)).ignoresSafeArea().padding(.trailing)", pic: "Pic1", color: Color.red)
        
    ]
    var body: some View {
        ZStack{
            
            //indice를 쓰는이유 : offset update 를 realtime 으로 진행해야됨.
            ForEach(intros.indices.reversed(), id: \.self){index in
                //바뀌는 부분은 fake인덱스부분
                IntroView(intro: intros[index])
                    .clipShape(LiquidShape(offset: intros[index].offset, curvePoint: fakeIndex == index ? 50 : 0))
                    //curvePoint: currentIndex == index ? 50 : 0))
                    .ignoresSafeArea()
                    //뒤에있는건 패딩이없고, 현재 나와있는건 패딩이있어서 배경에 뒤에게 보이도록함.
                    .padding(.trailing, fakeIndex == index ? 15 : 0)
                
            }
            HStack(spacing: 8){
                ForEach(0..<intros.count - 2, id: \.self){index in
                    Circle()
                        .fill(.white)
                        .frame(width: 8, height: 8)
                        .scaleEffect(currentIndex == index ? 1.15 : 0.85)
                        .opacity(currentIndex == index ? 1 : 0.3)
                    
                }
                Spacer()
                Button{
                    
                }label: {
                    Text("skip")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            
        }
        .overlay(
            Button(action: {
                print("asd")
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.largeTitle)
                    //드레그 제스쳐하는 오브젝트 생성
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .contentShape(Rectangle())
                    .gesture(
                        //
                        DragGesture()
                            .updating($isDragging, body: {value, out, _ in
                                out = true
                            })
                            .onChanged({ value in
                                //오프셋 변경
                                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)){
                                    intros[fakeIndex].offset = value.translation
                                }
                            })
                            .onEnded({ value in
                                withAnimation(.spring()){
                                    //어느정도 드레그되면 전횐되도록
                                    if (-intros[fakeIndex].offset.width > getRect().width / 2){
                                        intros[fakeIndex].offset.width =
                                            -getRect().width*3
                                        //인덱스를 업데이트해서 다음장으로 전환함
                                        fakeIndex += 1
                                        
                                        if currentIndex == intros.count - 3{
                                            currentIndex = 0
                                        }
                                        currentIndex += 1
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                                            if fakeIndex == (intros.count - 2){
                                                for index in 0..<intros.count - 2{
                                                    intros[index].offset = .zero
                                                }
                                                fakeIndex = 0
                                            }
                                        }
                                        
                                    }else{
                                        intros[fakeIndex].offset = .zero
                                    }
                                }
                            })
                    )
                
            })
            .offset(y: 26)
            .opacity(isDragging ? 0 : 1)
            .animation(.linear, value: isDragging)
            
            
            ,alignment: .topTrailing
        )
        .onAppear{
            guard let first = intros.first else{
                return
            }
            guard var last = intros.last else{
                return
            }
            last.offset.width = -getRect().width*3
            
            intros.append(first)
            intros.insert(last, at: 0)
            
            fakeIndex = 1
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
    var curvePoint: CGFloat
    
    //Multiple Animatable Data...
    //Animating Shapes
    var animatableData: AnimatablePair<CGSize.AnimatableData, CGFloat>{
        get{
            return AnimatablePair(offset.animatableData, curvePoint)
        }
        set{
            offset.animatableData = newValue.first
            curvePoint = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path{path in
            
            //드레그 할때, 화살표 위아래도 같이 크기증가
            //드레그 할때 오프셋이 적용된 높이 너비
            let width: CGFloat = rect.width + (-offset.width > 0 ? offset.width : 0)
            
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
                          control1: CGPoint(x: width - curvePoint, y: mid),
                          control2: CGPoint(x: width - curvePoint, y: mid)
            )
            
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


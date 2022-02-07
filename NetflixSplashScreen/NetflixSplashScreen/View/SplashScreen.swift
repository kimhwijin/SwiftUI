//
//  SplashScreen.swift
//  NetflixSplashScreen
//
//  Created by 김휘진 on 2022/02/08.
//

import SwiftUI
import SDWebImageSwiftUI


struct SplashScreen: View {
    
    @State var animationFinished: Bool = false
    @State var animationStarted: Bool = false
    
    var body: some View{
        
        ZStack{
            
            Color("BG")
                .ignoresSafeArea()
            
            ZStack{
                
                if animationFinished {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    AnimatedImage(url: getLogoURL())
                        .aspectRatio(contentMode: .fit)
                }
                
            }
            .animation(.none, value: animationFinished)
        }
        .opacity(animationFinished ? 0 : 1)
        .onAppear{
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeInOut(duration: 0.7)){
                    animationFinished = true
                }
            }
            
        }
            
    }
    
    func getLogoURL()->URL{
        let bundle = Bundle.main.path(forResource: "logo", ofType: "gif")
        let url = URL(fileURLWithPath: bundle ?? "")
        return url
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

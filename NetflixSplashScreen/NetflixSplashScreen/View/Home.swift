//
//  Home.swift
//  NetflixSplashScreen
//
//  Created by 김휘진 on 2022/02/08.
//

import SwiftUI

struct Home: View {
    var body: some View {
        
        VStack{
            
            HStack(spacing: 12){
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 30)
                Spacer()
                Button("Help"){
                    
                }
                Button("Privacy"){
                    
                }
            }
            .padding(5)
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.primary)
            
            Image("onboard")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
                .padding(.top, 30)
            
            Text("Watch on any device")
                .font(.title2.bold())
                .padding(.top, 15)
            
            Text("Stream on your phone, tablet, \nlabtop, TV.")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("SIGN IN")
                    .foregroundColor(.white)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(Color("Red"))
            }.padding()
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

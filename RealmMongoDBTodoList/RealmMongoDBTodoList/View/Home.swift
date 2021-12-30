//
//  Home.swift
//  RealmMongoDBTodoList
//
//  Created by 김휘진 on 2021/12/30.
//

import SwiftUI
import RealmSwift

struct Home: View {
    var body: some View {
        NavigationView {
            List{
                
            }
            .navigationTitle("Task's")
            .toolbar{
                Button{
                    
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

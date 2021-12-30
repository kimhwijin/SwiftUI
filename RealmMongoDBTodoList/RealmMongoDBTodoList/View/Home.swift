//
//  Home.swift
//  RealmMongoDBTodoList
//
//  Created by 김휘진 on 2021/12/30.
//

import SwiftUI
import RealmSwift

struct Home: View {
    //모든 Realm Object 데이터를 fetch 함
    //Sorting By Date
    @ObservedResults(TaskItem.self, sortDescriptor: SortDescriptor.init(keyPath: "taskDate", ascending: false)) var tasksFetched
    var body: some View {
        NavigationView {
            
            ZStack{
                if tasksFetched.isEmpty{
                    Text("Add some new Tasks!")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                else{
                    List{
                        
                    }
                }
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

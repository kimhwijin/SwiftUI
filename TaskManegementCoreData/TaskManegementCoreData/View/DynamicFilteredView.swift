//
//  DynamicFilterView.swift
//  TaskManegementCoreData
//
//  Created by 김휘진 on 2022/02/12.
//

import SwiftUI
import CoreData

struct DynamicFilteredView<Content: View, T>: View where T: NSManagedObject{
    
    @FetchRequest var request: FetchedResults<T>
    let content: (T)->Content
    
    init(dateToFilter: Content, @ViewBuilder content: @escaping (T)->Content){
        
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [], predicate: nil)
        self.content = content
    }
    
    var body: some View {
        Group{
            if request.isEmpty{
                Text("No tasks found!!!")
                    .font(.system(size: 16))
                    .fontWeight(.light)
                    .offset(y: 100)
            } else {
                ForEach(request, id: \.objectID){object in
                    self.content(object)
                }
            }
        }
    }
}

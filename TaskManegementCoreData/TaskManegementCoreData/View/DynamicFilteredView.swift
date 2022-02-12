//
//  DynamicFilteredView.swift
//  TaskManegementCoreData
//
//  Created by 김휘진 on 2022/02/12.
//

import SwiftUI
import CoreData


struct DynamicFilteredView<Content: View, T>: View where T: NSManagedObject{
    
    @FetchRequest var request: FetchedResults<T>
    let content: (T)->Content
    
    init(dateToFilter: Date, @ViewBuilder content: @escaping (T)->Content){
        
        let calender = Calendar.current
        
        let today = calender.startOfDay(for: dateToFilter)
        let tommorow = calender.date(byAdding: .day, value: 1, to: today)!
        
        //Filter key
        let filterKey = "taskDate"
        
        //Fetch task between today and tommorow
        let predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@", argumentArray: [today, tommorow])
        
        // Initializing Request with NSPredicate
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Task.taskDate, ascending: false)], predicate: predicate)
        self.content = content
    }
    
    
    
    var body: some View {
        Group{
            if request.isEmpty{
                Text("No tasks found!")
                    .font(.system(size:16))
                    .fontWeight(.light)
                    .offset(y: 100)
            } else {
                ForEach(request, id:\.objectID){object in
                    self.content(object)
                }
            }
        }
    }
}

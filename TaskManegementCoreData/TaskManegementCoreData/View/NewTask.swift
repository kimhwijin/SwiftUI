//
//  NewTask.swift
//  TaskManegementCoreData
//
//  Created by 김휘진 on 2022/02/12.
//

import SwiftUI

struct NewTask: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var taskTitle: String = ""
    @State var taskDescription: String = ""
    @State var taskDate: Date = Date()
    
    @Environment(\.managedObjectContext) var context
    var body: some View {
        
        NavigationView{
            List{
                Section {
                    TextField("Go to work", text: $taskTitle)
                } header: {
                    Text("Task Title")
                }
                
                Section {
                    TextField("Nothing", text: $taskDescription)
                } header: {
                    Text("Task Description")
                }
                
                Section {
                    DatePicker("", selection: $taskDate)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                } header: {
                    Text("Task Date")
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Add New Task")
            .navigationBarTitleDisplayMode(.inline)
            //MARK: Disabaling Dismiss on Swipe
            //추가하니깐 스와이프로 창닫기가 안됨
            .interactiveDismissDisabled()
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Save"){
                        let task = Task(context: context)
                        task.taskTitle = taskTitle
                        task.taskDescription = taskDescription
                        task.taskDate = taskDate
                        
                        try? context.save()
                        dismiss()
                        
                    }
                    .disabled(taskTitle == "" || taskDescription == "")
                    
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
        }
    }
}

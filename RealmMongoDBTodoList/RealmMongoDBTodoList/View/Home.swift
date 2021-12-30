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
                        ForEach(tasksFetched){task in
                            TaskRow(task: task)
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Task's")
            .toolbar{
                Button{
                    //버튼 클릭시 Realm Object 생성
                    let task = TaskItem()
                    $tasksFetched.append(task)
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

struct TaskRow: View{
    
    @ObservedRealmObject var task: TaskItem
    
    var body: some View{
        
        //Task Status Indicator Menu
        HStack(spacing: 15){
            Menu{
                //Update Date
                Button("Missed"){
                    $task.taskStatus.wrappedValue = .missed
                }
                Button("Completed"){
                    $task.taskStatus.wrappedValue = .completed
                }
            } label: {
                Circle()
                    .stroke(.gray)
                    .frame(width: 15, height: 15)
                    .overlay(
                        Circle()
                            .fill(task.taskStatus == .missed ? .red :
                                    (task.taskStatus == .pending ? .yellow : .green))
                    
                    )
            }
            VStack(alignment: .leading, spacing: 12){
                
                TextField("Refresh", text: $task.taskTitle)
                
                if task.taskTitle != ""{
                    
                    Picker(selection: .constant("")){
                        DatePicker(selection: $task.taskDate, displayedComponents: .date){
                            
                        }
                        .labelsHidden()
                        .navigationTitle("Task Date")
                    } label: {
                        HStack{
                            Image(systemName: "calendar")
                            Text(task.taskDate.formatted(date: .abbreviated, time: .omitted))
                        }
                    }
                    
                }
            }
        }
    }
    
}

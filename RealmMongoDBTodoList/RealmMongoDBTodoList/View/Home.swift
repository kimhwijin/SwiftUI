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
    
    //
    @State var lastAddedTaskID: String = ""
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
                            TaskRow(task: task, lastAddedTaskID: $lastAddedTaskID)
                            //Delete Date with Swiping
                                .swipeActions(edge: .trailing, allowsFullSwipe: true){
                                    Button(role: .destructive){
                                        $tasksFetched.remove(task)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                            
                        }
                    }
                    .listStyle(.insetGrouped)
                    .animation(.easeInOut, value: tasksFetched)
                }
            }
            .navigationTitle("lastAddedTaskID" + lastAddedTaskID)
            .toolbar{
                Button{
                    //버튼 클릭시 Realm Object 생성
                    let task = TaskItem()
                    lastAddedTaskID = task.id.stringValue
                    $tasksFetched.append(task)
                } label: {
                    Image(systemName: "plus")
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                lastAddedTaskID = ""
                guard let last = tasksFetched.last else{
                    return
                }
                if last.taskTitle == ""{
                    $tasksFetched.remove(last)
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
    
    @Binding var lastAddedTaskID: String
    //Keyboard focus
    @FocusState var showKeyboard: Bool
    var body: some View{
        
        //Task Status Indicator Menu
        HStack(spacing: 15){
            Menu{
                //Update Date
                Button("Missed0"){
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
                
                TextField("asd", text: $task.taskTitle)
                    .focused($showKeyboard)
                
                if task.taskTitle != ""{
                    
                    Picker(selection: .constant("")){
                        DatePicker(selection: $task.taskDate, displayedComponents: .date){
                            
                        }
                        .datePickerStyle(.graphical)
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
        .onAppear{
            if lastAddedTaskID == task.id.stringValue{
                showKeyboard.toggle()
            }
        }
    }
    
}

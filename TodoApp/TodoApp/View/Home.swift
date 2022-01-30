//
//  Home.swift
//  TodoApp
//
//  Created by 김휘진 on 2022/01/30.
//

import SwiftUI

struct Home: View {
    @StateObject var taskModel: TaskViewModel = TaskViewModel()
    @Namespace var animation
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                
                Section {
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 10){
                            ForEach(taskModel.currentWeek, id:\.self){ day in
                                
                                VStack(spacing: 10){
                                    // dd -> 2자리숫자 day
                                    Text(taskModel.extractDate(date: day, format: "dd"))
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                    // EEE -> Mon, Tue, Wed, ...
                                    Text(taskModel.extractDate(date: day, format: "EEE"))
                                        .font(.system(size: 14))
                                        .fontWeight(.semibold)
                                    Circle()
                                        .fill(taskModel.isToday(date: day) ? .white : .black)
                                        .frame(width:8, height:8)
                                        .opacity(taskModel.isToday(date: day) ? 1 : 0)
                                }
                                .foregroundStyle(taskModel.isToday(date: day) ? .primary : .tertiary)
                                .foregroundColor(taskModel.isToday(date: day) ? .white : .black)
                                .frame(width:45, height:90)
                                .background(
                                    ZStack{
                                        if taskModel.isToday(date: day){
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                    }
                                )
                                .contentShape(Capsule())
                                .onTapGesture{
                                    withAnimation {
                                        taskModel.currentDay = day
                                    }
                                }
                            
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    TaskView()
                    
                } header: {
                    HeaderView()
                }
            
            }
        }
    }
    
    //task view
    func TaskView()->some View{
        LazyVStack(spacing: 18){
            if let tasks = taskModel.filteredTasks{
                if tasks.isEmpty{
                    Text("No task found!!!")
                        .font(.system(size:16))
                        .fontWeight(.light)
                        .offset(y: 100)
                }else{
                    ForEach(tasks){task in
                        TaskCardView(task: task)
                    }
                }
            } else {
                ProgressView()
                    .offset(y: 100)
            }
        }
        .onChange(of: taskModel.currentDay){ newValue in
            taskModel.filterTodayTasks()
        }
    }

    func TaskCardView(task: Task)-> some View{
        HStack{
            VStack(spacing: 10){
                Circle()
                    .fill(.black)
                    .frame(width:15, height:15)
                    .background(
                        Circle()
                            .stroke(.black, lineWidth: 1)
                            .padding(-3)
                    )
                Rectangle()
                    .fill(.black)
                    .frame(width: 3)
            }
            .padding(.leading, 5)
            
            VStack{
                HStack(alignment: .top, spacing: 10){
                    VStack(alignment: .leading, spacing: 12){
                        Text(task.taskTitle)
                            .font(.title2.bold())
                            .foregroundColor(.white)
                        Text(task.taskDescription)
                            .font(.callout)
                            .foregroundColor(.gray)
                            .foregroundStyle(.secondary)
                        
                    }
                    
                    Text(task.taskDate.formatted(date: .omitted, time: .shortened))
                        .foregroundColor(.white)
                    
                }
            }
            .padding()
            .hLeading()
            .background(
                Color("Black")
                    .cornerRadius(25)
            )
        }
        .hLeading()
        
    }
    
    
    //Header
    func HeaderView()->some View{
        HStack(spacing: 10){
            VStack(alignment: .leading, spacing: 10){
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)
                Text("Today")
                    .font(.largeTitle.bold())
            }
            .hLeading()
            
            Button{
                
            } label: {
                 Image("Profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:45, height:45)
                    .clipShape(Circle())
            }
            
        }
        .padding()
        .background(Color.white)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


extension View{
    func hLeading()->some View{
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    func hTrailing()->some View{
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    func hCenter()->some View{
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

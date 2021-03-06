//
//  TaskViewModel.swift
//  TodoApp
//
//  Created by 김휘진 on 2022/01/30.
//

import SwiftUI

class TaskViewModel: ObservableObject{
    
    @Published var storedTasks: [Task] = [

        Task(taskTitle: "Meeting", taskDescription: "Discuss team task for the day", taskDate: .init(timeIntervalSinceNow: -5000)),
        Task(taskTitle: "Icon set", taskDescription: "Edit icons for team task for next week", taskDate: .init(timeIntervalSinceNow: 10000)),
        Task(taskTitle: "Prototype", taskDescription: "Make and send prototype", taskDate: .init(timeIntervalSinceNow: 0)),
        Task(taskTitle: "Check asset", taskDescription: "Start checking the assets", taskDate: .init(timeIntervalSinceNow: 1000)),
        Task(taskTitle: "Team party", taskDescription: "Make fun with team mates", taskDate: .init(timeIntervalSinceNow: 1000)),
        Task(taskTitle: "Client Meeting", taskDescription: "Explain project to clinet", taskDate: .init(timeIntervalSinceNow: 10)),
        
        Task(taskTitle: "Next Project", taskDescription: "Discuss next project with team", taskDate: .init(timeIntervalSinceNow: 5000)),
        Task(taskTitle: "App Proposal", taskDescription: "Meet client for next App Proposal", taskDate: .init(timeIntervalSinceNow: 1000)),
    ]
    
    // Current Week Days
    @Published var currentWeek: [Date] = []
    
    // Current day
    @Published var currentDay: Date = Date()
    
    //filtering todya tasks
    @Published var filteredTasks: [Task]?
    
    
    //initalizing
    init(){
        fetchCurrentWeek()
        filterTodayTasks()
    }
    
    func filterTodayTasks(){
        
        DispatchQueue.global(qos: .userInteractive).async {
            let calender = Calendar.current
            
            let filtered = self.storedTasks.filter{
                return calender.isDate($0.taskDate, inSameDayAs: self.currentDay)
            }
                .sorted { task1, task2 in
                    return task2.taskDate > task1.taskDate
                }
            
            DispatchQueue.main.async {
                withAnimation{
                    self.filteredTasks = filtered
                }
            }
            
        }
        
    }
    
    //
    func fetchCurrentWeek() {
        let today = Date()
        let calendear = Calendar.current
        
        let week = calendear.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (0...6).forEach { day in
            if let weekday = calendear.date(byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekday)
            }
        }
    }
    
    // extracting date
    func extractDate(date: Date, format: String)->String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    // checking if current date is today
    func isToday(date: Date)-> Bool{
        let calendar = Calendar.current
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    func isCurrentHour(date: Date)->Bool{
        
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        
        return hour == currentHour
    }

}


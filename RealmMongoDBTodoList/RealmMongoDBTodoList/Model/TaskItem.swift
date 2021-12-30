//
//  TaskItem.swift
//  RealmMongoDBTodoList
//
//  Created by 김휘진 on 2021/12/30.
//

import SwiftUI
import RealmSwift


class TaskItem: Object, Identifiable {
    
    //데이터가 real time 으로 update 되도록 binding 해준다.
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var taskTitle: String
    @Persisted var taskDate: Date = Date()
    
    //Task status...
    @Persisted var taskStatus: TaskStatus = .pending
    
}

enum TaskStatus: String, PersistableEnum {
    case missed = "Missed"
    case completed = "Completed"
    case pending = "Pending"
}

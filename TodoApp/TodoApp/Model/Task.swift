//
//  Task.swift
//  TodoApp
//
//  Created by 김휘진 on 2022/01/30.
//

import SwiftUI

//Task

struct Task: Identifiable{
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskDate: Date
}

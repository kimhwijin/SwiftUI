//
//  TaskManegementCoreDataApp.swift
//  TaskManegementCoreData
//
//  Created by 김휘진 on 2022/02/09.
//

import SwiftUI

@main
struct TaskManegementCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//
//  RealmMongoDBTodoListApp.swift
//  RealmMongoDBTodoList
//
//  Created by 김휘진 on 2021/12/30.
//

import SwiftUI
import RealmSwift

@main
struct RealmMongoDBTodoListApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.realmConfiguration, Realm.Configuration())
        }
    }
}

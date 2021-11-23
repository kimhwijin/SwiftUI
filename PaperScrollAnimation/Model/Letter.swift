//
//  Letter.swift
//  PaperScrollAnimation
//
//  Created by 김휘진 on 2021/11/23.
//

import SwiftUI

struct Letter: Identifiable, Hashable{
    var id = UUID().uuidString
    var date: String
    var title: String
}

var letters: [Letter] = [
    Letter(date: "December 8 2021", title: "Happy birthday"),
    Letter(date: "June 18 2021", title: "Happy birthday"),
    Letter(date: "October 20 2021", title: "Happy birthday")
]

//
//  Intro.swift
//  LiquidSwipe
//
//  Created by 김휘진 on 2021/12/03.
//

import SwiftUI

//intro model
struct Intro: Identifiable{
    var id = UUID().uuidString
    var title: String
    var subTitle: String
    var description: String
    var pic: String
    var color: Color
    var offset: CGSize = .zero
}

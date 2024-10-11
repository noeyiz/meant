//
//  Record.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Foundation

struct Record {
    let id: UUID
    var date: Date
    var type: String
    var content: String
    var reminiscences: [Reminiscence]
    
    init(id: UUID, date: Date, type: String, content: String, reminiscences: [Reminiscence] = []) {
        self.id = id
        self.date = date
        self.type = type
        self.content = content
        self.reminiscences = reminiscences
    }
}

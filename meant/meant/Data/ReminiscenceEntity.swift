//
//  ReminiscenceEntity.swift
//  meant
//
//  Created by 지연 on 10/11/24.
//

import Foundation

import RealmSwift

class ReminiscenceEntity: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var date: Date
    @Persisted var content: String
    
    convenience init(_ reminiscence: Reminiscence) {
        self.init()
        id = reminiscence.id
        date = reminiscence.date
        content = reminiscence.content
    }
}

extension ReminiscenceEntity {
    func toDomain() -> Reminiscence {
        return Reminiscence(id: id, date: date, content: content)
    }
}

//
//  RecordEntity.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Foundation

import RealmSwift

class RecordEntity: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var date: Date
    @Persisted var type: String
    @Persisted var content: String
    
    convenience init(_ record: Record) {
        self.init()
        id = record.id
        date = record.date
        type = record.type
        content = record.content
    }
}

extension RecordEntity {
    func toDomain() -> Record {
        return Record(id: id, date: date, type: type, content: content)
    }
}

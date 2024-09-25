//
//  RecordRepositoryInterface.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Foundation

protocol RecordRepositoryInterface {
    func fetchRecords() -> [Record]
    func saveRecord(_ record: Record) throws
    func updateRecord(_ record: Record) throws
    func deleteRecord(_ record: Record) throws
}

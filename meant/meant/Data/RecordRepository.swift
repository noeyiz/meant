//
//  RecordRepository.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Foundation

import RealmSwift

class RecordRepository: RecordRepositoryInterface {
    private let realm: Realm?
    
    init(realmManager: RealmManager = .shared) {
        self.realm = realmManager.getRealm()
    }
    
    func fetchRecords() -> [Record] {
        guard let realm = realm else { return [] }
        let recordEntities = realm.objects(RecordEntity.self)
        let records = Array(recordEntities).map { $0.toDomain() }
        return records
    }
    
    func saveRecord(_ record: Record) throws {
        guard let realm = realm else { throw RecordError.realmNotInitialized }
        do {
            try realm.write {
                let recordEntity = RecordEntity(record)
                realm.add(recordEntity)
            }
        } catch {
            throw RecordError.failedToSave
        }
    }
    
    func updateRecord(_ record: Record) throws {
        guard let realm = realm else { throw RecordError.realmNotInitialized }
        do {
            try realm.write {
                let recordEntity = RecordEntity(record)
                realm.add(recordEntity, update: .modified)
            }
        } catch {
            throw RecordError.failedToUpdate
        }
    }
    
    func deleteRecord(_ record: Record) throws {
        guard let realm = realm else { throw RecordError.realmNotInitialized }
        do {
            try realm.write {
                let recordEntity = RecordEntity(record)
                realm.delete(recordEntity)
            }
        } catch {
            throw RecordError.failedToDelete
        }
    }
}

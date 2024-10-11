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
                if let existingRecord = realm.object(
                    ofType: RecordEntity.self,
                    forPrimaryKey: record.id
                ) {
                    realm.delete(existingRecord)
                } else {
                    throw RecordError.recordNotFound
                }
            }
        } catch {
            throw RecordError.failedToDelete
        }
    }
    
    func resetRecords() throws {
        guard let realm = realm else { throw RecordError.realmNotInitialized }
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            throw RecordError.failedToDelete
        }
    }
    
    func saveReminiscence(for recordID: UUID, _ reminiscence: Reminiscence) throws {
        guard let realm = realm else { throw RecordError.realmNotInitialized }
        do {
            try realm.write {
                guard let record = realm.object(
                    ofType: RecordEntity.self,
                    forPrimaryKey: recordID
                ) else {
                    throw RecordError.recordNotFound
                }
                let reminiscenceEntity = ReminiscenceEntity(reminiscence)
                record.reminiscences.append(reminiscenceEntity)
            }
        } catch {
            throw RecordError.failedToSave
        }
    }
    
    func deleteReminiscence(for recordID: UUID, reminiscenceID: UUID) throws {
        guard let realm = realm else { throw RecordError.realmNotInitialized }
        do {
            try realm.write {
                guard let record = realm.object(
                    ofType: RecordEntity.self,
                    forPrimaryKey: recordID
                ) else {
                    throw RecordError.recordNotFound
                }
                if let index = record.reminiscences.firstIndex(where: { $0.id == reminiscenceID }) {
                    record.reminiscences.remove(at: index)
                } else {
                    throw RecordError.reminiscenceNotFound
                }
            }
        } catch {
            throw RecordError.failedToDelete
        }
    }
}

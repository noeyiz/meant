//
//  RealmManager.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Foundation

import RealmSwift

final class RealmManager {
    static let shared = RealmManager()
    private var realm: Realm?
    
    private init() {
        do {
            realm = try Realm()
        } catch {
            print("Failed to initialize Realm: \(error)")
        }
    }
    
    func getRealm() -> Realm? {
        return realm
    }
}

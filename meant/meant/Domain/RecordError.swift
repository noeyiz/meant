//
//  RecordError.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//


import Foundation

enum RecordError: Error {
    case realmNotInitialized
    case failedToSave
    case failedToUpdate
    case failedToDelete
    case recordNotFound
    case reminiscenceNotFound
    
    var errorDescription: String {
        switch self {
        case .realmNotInitialized:
            return "Realm database is not initialized"
        case .failedToSave:
            return "Failed to save the record"
        case .failedToUpdate:
            return "Failed to update the record"
        case .failedToDelete:
            return "Failed to delete the record"
        case .recordNotFound:
            return "Record not found in Realm"
        case .reminiscenceNotFound:
            return "Reminiscence not founc in Realm"
        }
    }
}

//
//  HomeViewModel.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Combine
import Foundation

final class HomeViewModel {
    private let recordRepository: RecordRepositoryInterface
    @Published var records = [Record]()
    
    init(recordRepository: RecordRepositoryInterface) {
        self.recordRepository = recordRepository
        fetchRecords()
    }
    
    func fetchRecords() {
        records = recordRepository.fetchRecords()
    }
}

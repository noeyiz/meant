//
//  HomeViewController.swift
//  meant
//
//  Created by 지연 on 9/25/24.
//

import Combine
import UIKit

final class HomeViewController: BaseViewController<HomeView> {
    private let viewModel: HomeViewModel
    private let recordCellViewModels = RecordType.allCases
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupDelegate()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchRecords()
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        setNavigationBarStyle(.largeTitleWithRightButton)
        setNavigationBarTitle("meant")
        setNavigationBarRightButtonIcon("gearshape")
    }
    
    private func setupDelegate() {
        recordCollectionView.delegate = self
        recordCollectionView.dataSource = self
    }
    
    // MARK: - Bind
    
    private func bind() {
        viewModel.$records
            .sink { [weak self] records in
                print(records)
            }.store(in: &cancellables)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.frame.width - 15) / 2
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let recordViewModel = DIContainer.shared.makeRecordViewModel()
        let type = recordCellViewModels[indexPath.row]
        let recordViewController = RecordViewController(
            viewModel: recordViewModel,
            recordType: type
        )
        generateHaptic()
        navigationController?.pushViewController(recordViewController, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return recordCellViewModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: RecordCell.self)
        cell.configure(with: recordCellViewModels[indexPath.row])
        return cell
    }
}

private extension HomeViewController {
    var recordCollectionView: UICollectionView {
        contentView.recordCollectionView
    }
}

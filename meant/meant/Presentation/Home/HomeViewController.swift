//
//  HomeViewController.swift
//  meant
//
//  Created by 지연 on 9/25/24.
//

import UIKit

final class HomeViewController: BaseViewController<HomeView> {
    private let recordCellViewModels = RecordType.allCases
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        recordCollectionView.delegate = self
        recordCollectionView.dataSource = self
    }
    
    private func setupNavigationBar() {
        setNavigationBarStyle(.largeTitleWithRightButton)
        setNavigationBarTitle("meant")
        setNavigationBarRightButtonIcon("gearshape")
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
        let type = recordCellViewModels[indexPath.row]
        let recordViewController = RecordViewController(recordType: type)
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

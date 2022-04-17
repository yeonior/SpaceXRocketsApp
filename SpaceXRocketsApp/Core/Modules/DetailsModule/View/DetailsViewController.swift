//
//  DetailsCollectionViewController.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 12.04.2022.
//

import UIKit

protocol DetailsViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
    func setViewModel(_ viewModel: DetailsCollectionViewModel)
}

struct DetailsViewSizeConstants {
    static let collectionViewMinimumLineSpacing: CGFloat = 16.0
    static let collectionViewMinimumInteritemSpacing: CGFloat = 64.0
    static let collectionViewTopContentInset: CGFloat = 40.0
    static let collectionViewItemWidth: CGFloat = Size.screenWidth.floatValue - collectionViewMinimumInteritemSpacing
    static let collectionViewItemHeight: CGFloat = 100.0
}

final class DetailsViewController: UIViewController {
    
    // MARK: - Subviews
    var collectionView: UICollectionView?
    
    // MARK: - Properties
    var router: Routing!
    var presenter: DetailsPresenterProtocol!
    var serialNumber: Int!
    
    private var viewModel: DetailsCollectionViewModel? {
        didSet {
            collectionView?.dataSource = viewModel
            collectionView?.delegate = viewModel
            collectionView?.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        DispatchQueue.global().async { [unowned self] in
            presenter.fetchData()
        }
    }
    
    // MARK: - Private methods
    private func configureUI() {
        
        view.backgroundColor = Color.background.uiColor
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = DetailsViewSizeConstants.collectionViewMinimumInteritemSpacing
        layout.minimumLineSpacing = DetailsViewSizeConstants.collectionViewMinimumLineSpacing
        
        collectionView = UICollectionView(frame: view.frame,
                                          collectionViewLayout: layout)
        collectionView?.contentInset = UIEdgeInsets(top: DetailsViewSizeConstants.collectionViewTopContentInset,
                                                    left: 0,
                                                    bottom: 0,
                                                    right: 0)
        
        guard let collectionView = collectionView else { return }
        collectionView.register(DetailsCollectionCell.self, forCellWithReuseIdentifier: DetailsCollectionCell.identifier)
        
        collectionView.dataSource = viewModel
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundView = UIView()
        collectionView.backgroundView?.backgroundColor = Color.lauchesPageBackground.uiColor
        collectionView.backgroundColor = Color.lauchesPageBackground.uiColor
        
        view.addSubview(collectionView)
    }
}

// MARK: - DetailsViewProtocol
extension DetailsViewController: DetailsViewProtocol {
    func success() {
        presenter.provideViewModel(with: serialNumber)
    }

    func failure(error: Error) {
        debugPrint(error.localizedDescription)
    }
    
    func setViewModel(_ viewModel: DetailsCollectionViewModel) {
        self.viewModel = viewModel
    }
}

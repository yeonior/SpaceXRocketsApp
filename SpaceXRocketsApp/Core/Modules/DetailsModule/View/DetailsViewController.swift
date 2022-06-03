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
    static let collectionViewItemWidth: CGFloat = Sizes.screenWidth - collectionViewMinimumInteritemSpacing
    static let collectionViewItemHeight: CGFloat = 100.0
}

final class DetailsViewController: UIViewController {
    
    // MARK: - Subviews
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = DetailsViewSizeConstants.collectionViewMinimumInteritemSpacing
        layout.minimumLineSpacing = DetailsViewSizeConstants.collectionViewMinimumLineSpacing
        
        let collectionView = UICollectionView(frame: view.bounds,
                                              collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: DetailsViewSizeConstants.collectionViewTopContentInset,
                                                   left: 0,
                                                   bottom: 0,
                                                   right: 0)
        collectionView.register(DetailsCollectionCell.self, forCellWithReuseIdentifier: DetailsCollectionCell.identifier)
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundView = UIView()
        collectionView.backgroundView?.backgroundColor = Colors.lauchesPageBackground.uiColor
        collectionView.backgroundColor = Colors.lauchesPageBackground.uiColor
        collectionView.indicatorStyle = .white
        
        return collectionView
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        $0.style = .large
        $0.center = view.center
        $0.startAnimating()
        $0.color = Colors.activityIndicatorView.uiColor
        return $0
    }(UIActivityIndicatorView())
    
    // MARK: - Properties
    var router: Routing!
    var presenter: DetailsPresenterProtocol!
    var serialNumber: Int!
    
    private var viewModel: DetailsCollectionViewModel? {
        didSet {
            collectionView.dataSource = viewModel
            collectionView.delegate = viewModel
            collectionView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        DispatchQueue.global().async {
            self.presenter.fetchData()
        }
    }
    
    // MARK: - Private methods
    private func configureUI() {
        view.backgroundColor = Colors.background.uiColor
        collectionView.dataSource = viewModel
        
        view.addSubview(collectionView)
        view.addSubview(activityIndicatorView)
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
        activityIndicatorView.stopAnimating()
    }
}

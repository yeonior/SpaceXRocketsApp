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
    func setViewModel(_ viewModel: DetailsViewModel)
}

final class DetailsViewController: UIViewController {
    
    var collectionView: UICollectionView?
    var router: Routing!
    var presenter: DetailsPresenterProtocol!
    var serialNumber: Int!
    
    var viewModel: DetailsViewModel? {
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
        DispatchQueue.global().async {
            self.presenter.fetchData()
        }
    }
    
    // MARK: - Private methods
    private func configureUI() {
        
        view.backgroundColor = Color.background.uiColor
        
        // layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
//        layout.minimumInteritemSpacing = 50
        layout.minimumLineSpacing = 16
        
        // init and insets
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView?.contentInset = UIEdgeInsets(top: 32,
                                                    left: 0,
                                                    bottom: 64,
                                                    right: 0)
        
        guard let collectionView = collectionView else { return }
        collectionView.register(DetailsCell.self, forCellWithReuseIdentifier: DetailsCell.identifier)
        
        // protocols
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        
        // attributes
        collectionView.showsVerticalScrollIndicator = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundView = UIView()
        collectionView.backgroundView?.backgroundColor = Color.lauchesPageBackground.uiColor
        
        // adding
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
    
    func setViewModel(_ viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }
}

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
}

final class DetailsViewController: UIViewController {
    
    var collectionView: UICollectionView?
    var router: Routing!
    var presenter: DetailsPresenterProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        presenter.fetchLaunches()
    }
    
    private func configureUI() {
        
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
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // attributes
        collectionView.showsVerticalScrollIndicator = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundView = UIView()
        collectionView.backgroundView?.backgroundColor = Color.lauchesPageBackground.uiColor
        
        // adding
        view.addSubview(collectionView)
//        guard let backgroundView = collectionView.backgroundView else { return }

        // backgroundView constraints
//        backgroundView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
//            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
    }
}

extension DetailsViewController: DetailsViewProtocol {
    func success() {
        print("success")
    }
    
    func failure(error: Error) {
        debugPrint(error.localizedDescription)
    }
}

extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCell.identifier, for: indexPath) as? DetailsCell {

//            cell.backgroundView?.backgroundColor = .green

            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension DetailsViewController: UICollectionViewDelegate {
    
}

extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 311, height: 100)
    }
}

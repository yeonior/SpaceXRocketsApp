//
//  MainView.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 05.04.2022.
//

import UIKit

final class MainView: UIView {
    
    // MARK: - Subviews
    let header = MainViewHeader()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        collectionView.register(MainCollectionViewCell.self,
                                forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundView = UIView()
        collectionView.backgroundView?.backgroundColor = Color.lauchesPageBackground.uiColor
        collectionView.backgroundColor = Color.lauchesPageBackground.uiColor
        
        return collectionView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: bounds, style: .grouped)
        tableView.register(MainInfoSectionCell.self,
                           forCellReuseIdentifier: MainInfoSectionCell.identifier)
        tableView.register(MainStageSectionCell.self,
                           forCellReuseIdentifier: MainStageSectionCell.identifier)
        tableView.register(MainShowButtonCell.self,
                           forCellReuseIdentifier: MainShowButtonCell.identifier)
        tableView.register(MainSectionHeader.self,
                           forHeaderFooterViewReuseIdentifier: MainSectionHeader.identifier)
        tableView.backgroundColor = Color.mainViewHeaderBackground.uiColor
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.isScrollEnabled = false
        
        return tableView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func configureUI() {
        
        clipsToBounds = true
        layer.cornerRadius = MainViewSizeConstants.cornerRadius
        
        header.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(header)
        addSubview(collectionView)
        addSubview(tableView)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        let headerConstraints = [
            header.topAnchor.constraint(equalTo: topAnchor),
            header.heightAnchor.constraint(equalToConstant: MainViewSizeConstants.headerHeight),
            header.leadingAnchor.constraint(equalTo: leadingAnchor),
            header.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
        
        let collectionViewConstraints = [
            collectionView.topAnchor.constraint(equalTo: header.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: MainCollectionViewSizeConstants.cellHeight),
        ]
        
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(headerConstraints)
        NSLayoutConstraint.activate(collectionViewConstraints)
        NSLayoutConstraint.activate(tableViewConstraints)
    }
}

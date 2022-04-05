//
//  MainContainerView.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 05.04.2022.
//

import UIKit.UIView

final class MainContainerView: UIView {
    
    lazy var topView = MainTopView()
    lazy var tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setup() {
        
        // view
        backgroundColor = .systemGray2
        layer.cornerRadius = 30.0
        clipsToBounds = true
        
        // tableView
        tableView = UITableView(frame: bounds, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .black
//        tableView.contentInset.bottom = 100
        
        addSubview(topView)
        addSubview(tableView)
        
        // constraints
        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: topAnchor),
            topView.heightAnchor.constraint(equalToConstant: 100),
            topView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

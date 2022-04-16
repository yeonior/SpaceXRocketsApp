//
//  MainBottomSheetView.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 05.04.2022.
//

import UIKit

final class MainBottomSheetView: UIView {
    
    // MARK: - Subviews
    lazy var topView = MainBottomSheetTopView()
    lazy var tableView = UITableView()
    
    // MARK: - Init
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
        layer.cornerRadius = 32.0
        clipsToBounds = true
        
        // tableView
        tableView = UITableView(frame: bounds, style: .grouped)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: self.tableView.bounds.size.width,
                                                         height: .leastNonzeroMagnitude))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: self.tableView.bounds.size.width,
                                                         height: .leastNonzeroMagnitude))
        tableView.register(MainInfoSectionCell.self, forCellReuseIdentifier: MainInfoSectionCell.identifier)
        tableView.register(MainShowButtonCell.self, forCellReuseIdentifier: MainShowButtonCell.identifier)
        tableView.register(MainTableViewSectionHeader.self, forHeaderFooterViewReuseIdentifier: MainTableViewSectionHeader.identifier)
        tableView.register(MainStageSectionCell.self, forCellReuseIdentifier: MainStageSectionCell.identifier)
        tableView.backgroundColor = Color.bottomSheetViewBackground.uiColor
        tableView.separatorColor = .clear
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        tableView.contentInsetAdjustmentBehavior = .never
//        tableView.isScrollEnabled = false
//        tableView.contentInset.bottom = 100
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(topView)
        addSubview(tableView)
        
        // constraints
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: topAnchor),
            topView.heightAnchor.constraint(equalToConstant: 112),
            topView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

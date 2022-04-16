//
//  MainBottomSheetView.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 05.04.2022.
//

import UIKit.UIView

final class MainBottomSheetView: UIView {
    
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
        layer.cornerRadius = 32.0
        clipsToBounds = true
        
        // tableView
        tableView = UITableView(frame: bounds, style: .grouped)
        tableView.register(MainInfoSectionCell.self, forCellReuseIdentifier: "infoCell")
        tableView.register(MainShowButtonCell.self, forCellReuseIdentifier: "buttonCell")
        tableView.register(MainTableViewSectionHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        tableView.register(MainStageSectionCell.self, forCellReuseIdentifier: "stageCell")
        tableView.backgroundColor = Color.bottomSheetViewBackground.uiColor
        tableView.separatorColor = .clear
        tableView.bounces = true
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -6, right: 0)
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
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

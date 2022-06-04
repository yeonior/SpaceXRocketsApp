//
//  MainViewController.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 05.04.2022.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func setBackgroundImage(from data: Data)
    func setHeaderViewWithName(_ name: String)
    func setCollectionViewViewModel(_ viewModel: MainCollectionViewViewModel)
    func setTableViewViewModel(_ viewModel: MainTableViewViewModel)
    func removeCoverView()
}

struct MainViewSizeConstants {
    static let cornerRadius: CGFloat = 32.0
    static let height: CGFloat = Sizes.screenHeight / 2
    static let headerViewHeight: CGFloat = 112.0
    static let additionalHeight: CGFloat = headerViewHeight + MainCollectionViewSizeConstants.cellHeight
    static let backgroundImageViewHeight: CGFloat = Sizes.screenHeight / 2
}

final class MainViewController: UIViewController {
    
    // MARK: - Subviews
    private let scrollView: UIScrollView = {
        $0.bounces = false
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
        return $0
    }(UIScrollView())
    
    private let baseView = UIView()
    
    private let backgroundImageView: UIImageView = {
        $0.backgroundColor = Colors.background.uiColor
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    private let mainView = MainView()
    private let coverView = UIView()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        $0.style = .large
        $0.color = Colors.activityIndicatorView.uiColor
        $0.startAnimating()
        return $0
    }(UIActivityIndicatorView())
    
    // MARK: - Properties
    var presenter: MainPresenterProtocol!
    var router: Routing!
    var serialNumber: Int!
    
    private var collectionViewViewModel: MainCollectionViewViewModel? {
        didSet {
            mainView.collectionView.dataSource = collectionViewViewModel
            mainView.collectionView.delegate = collectionViewViewModel
            mainView.collectionView.reloadData()
        }
    }
    private var tableViewViewModel: MainTableViewViewModel? {
        didSet {
            mainView.tableView.dataSource = tableViewViewModel
            mainView.tableView.delegate = tableViewViewModel
            mainView.tableView.reloadData()
        }
    }
    
    private var mainViewHeightConstraint: NSLayoutConstraint?
    private var isFirstLoad = true
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetViewPosition()
        addObserverToCollectionView()
        addObserverToTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideNavigationBar()
        requestData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCoverViewFrame()
    }
    
    // observing the table view to get height
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == ObserverConstants.tableViewContentSizeKeyPath {
            if object is UITableView {
                if let newvalue = change?[.newKey] {
                    let newsize  = newvalue as! CGSize
                    mainViewHeightConstraint?.constant = newsize.height + MainViewSizeConstants.additionalHeight + navigationBarHeight
                }
            }
        }
    }
    
    // MARK: - Private methods
    private func configureUI() {
        
        view.backgroundColor = Colors.mainBackground.uiColor
        mainView.headerView.buttonAction = showSettings
        activityIndicatorView.center = view.center
        coverView.backgroundColor = .black
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        baseView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(baseView)
        baseView.addSubview(backgroundImageView)
        baseView.addSubview(mainView)
        coverView.addSubview(activityIndicatorView)
        view.addSubview(coverView)
        
        applyConstraints()
    }
    
    private func configureCoverViewFrame() {
        coverView.frame = view.bounds
    }
    
    private func applyConstraints() {
        
        let baseViewHeightConstraint = baseView.heightAnchor.constraint(equalTo: view.heightAnchor)
        baseViewHeightConstraint.priority = UILayoutPriority(250)
        
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let baseViewConstraints = [
            baseView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            baseView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            baseView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            baseView.widthAnchor.constraint(equalTo: view.widthAnchor),
            baseViewHeightConstraint
        ]
        
        let backgroundImageViewConstraints = [
            backgroundImageView.topAnchor.constraint(equalTo: baseView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: MainViewSizeConstants.backgroundImageViewHeight)
        ]
        
        let mainViewConstraints = [
            mainView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor,
                                          constant: -MainViewSizeConstants.cornerRadius),
            mainView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor,
                                             constant: MainViewSizeConstants.cornerRadius),
            mainView.tableView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(baseViewConstraints)
        NSLayoutConstraint.activate(backgroundImageViewConstraints)
        NSLayoutConstraint.activate(mainViewConstraints)
        
        mainViewHeightConstraint = mainView.heightAnchor.constraint(equalToConstant: MainViewSizeConstants.height)
        mainViewHeightConstraint?.isActive = true
    }
    
    private func requestData() {
        guard tableViewViewModel == nil
           || collectionViewViewModel == nil
           || backgroundImageView.image == nil else { return }
        
        self.presenter.requestData(by: self.serialNumber)
        self.presenter.provideData()
    }
    
    private func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func showLaunches() {
        showNavigationBar()
        router.showDetailsModule(with: serialNumber, and: title ?? "")
    }
    
    private func showSettings() {
        router.showSettingsModule()
    }
    
    private func addObserverToCollectionView() {
        if isFirstLoad {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(updateCollectionView),
                                                   name: ObserverConstants.collectionViewUpdateNotificationName,
                                                   object: nil)
            isFirstLoad = false
        }
    }
    
    private func addObserverToTableView() {
        mainView.tableView.addObserver(self,
                                       forKeyPath: ObserverConstants.tableViewContentSizeKeyPath,
                                       options: .new,
                                       context: nil)
    }
    
    private func resetViewPosition() {
        scrollView.scrollToTop(animated: true)
        mainView.collectionView.scrollToLeft(animated: true)
    }
    
    @objc
    private func updateCollectionView() {
        DispatchQueue.global().async {
            self.presenter.requestData(by: self.serialNumber)
            self.presenter.provideCollectionViewViewModel()
        }
    }
}

// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func setBackgroundImage(from data: Data) {
        backgroundImageView.image = UIImage(data: data)
    }
    
    func setHeaderViewWithName(_ name: String) {
        title = name
        mainView.headerView.titleLabel.text = name
    }
    
    func setCollectionViewViewModel(_ viewModel: MainCollectionViewViewModel) {
        self.collectionViewViewModel = viewModel
    }
    
    func setTableViewViewModel(_ viewModel: MainTableViewViewModel) {
        self.tableViewViewModel = viewModel
        self.tableViewViewModel?.buttonAction = showLaunches
    }
    
    func removeCoverView() {
        activityIndicatorView.stopAnimating()
        UIView.animate(withDuration: 0.3) {
            self.coverView.alpha = 0.0
        } completion: { _ in
            self.coverView.removeFromSuperview()
        }
    }
}

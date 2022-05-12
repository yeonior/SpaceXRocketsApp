//
//  MainViewController.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 05.04.2022.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func setBackgroundImage(with data: Data)
    func setHeaderWithName(_ name: String)
    func setTableViewViewModel(_ viewModel: MainTableViewViewModel)
    func setCollectionViewViewModel(_ viewModel: MainCollectionViewViewModel)
}

struct MainViewSizeConstants {
    static let cornerRadius: CGFloat = 32.0
    static let height: CGFloat = Size.screenHeight.floatValue / 2
    static let headerHeight: CGFloat = 112.0
    static let additionalHeight: CGFloat = headerHeight + MainCollectionViewSizeConstants.cellHeight
    static let backgroundImageViewHeight: CGFloat = Size.screenHeight.floatValue / 2
    static let leftPadding: CGFloat = 32.0
    static let rightPadding: CGFloat = 32.0
}

final class MainViewController: UIViewController {
    
    // MARK: - Subviews
    lazy var scrollView: UIScrollView = {
        $0.bounces = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
        return $0
    }(UIScrollView())
    
    lazy var baseView = UIView()
    
    lazy var backgroundImageView: UIImageView = {
        $0.backgroundColor = Color.background.uiColor
        $0.alpha = 0
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    lazy var mainView = MainView()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        $0.style = .large
        $0.center = view.center
        $0.startAnimating()
        $0.color = Color.activityIndicatorView.uiColor
        return $0
    }(UIActivityIndicatorView())
    
    // MARK: - Properties
    var presenter: MainPresenterProtocol!
    var router: Routing!
    var serialNumber: Int!
    
    private var tableViewViewModel: MainTableViewViewModel? {
        didSet {
            DispatchQueue.main.sync {
                mainView.tableView.dataSource = tableViewViewModel
                mainView.tableView.delegate = tableViewViewModel
                mainView.tableView.reloadData()
            }
        }
    }
    private var collectionViewViewModel: MainCollectionViewViewModel? {
        didSet {
            DispatchQueue.main.sync {
                mainView.collectionView?.dataSource = collectionViewViewModel
                mainView.collectionView?.delegate = collectionViewViewModel
                mainView.collectionView?.reloadData()
            }
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
        resetViewState()
        mainView.tableView.addObserver(self,
                                       forKeyPath: ObserverConstants.tableViewContentSizeKeyPath,
                                       options: .new,
                                       context: nil)
        if isFirstLoad {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(updateCollectionView(_:)),
                                                   name: ObserverConstants.collectionViewUpdateNotificationName,
                                                   object: nil)
            isFirstLoad = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideNavigationBar()
        // requesting data
        guard tableViewViewModel == nil
           || collectionViewViewModel == nil
           || backgroundImageView.image == nil else { return }
        fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mainView.tableView.removeObserver(self, forKeyPath: ObserverConstants.tableViewContentSizeKeyPath)
        super.viewWillDisappear(animated)
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
        
        view.backgroundColor = Color.mainBackground.uiColor
        mainView.header.buttonAction = showSettings
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        baseView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(baseView)
        baseView.addSubview(backgroundImageView)
        baseView.addSubview(mainView)
        view.addSubview(activityIndicatorView)
        
        // constraints
        let baseViewHeightConstraint = baseView.heightAnchor.constraint(equalTo: view.heightAnchor)
        baseViewHeightConstraint.priority = UILayoutPriority(250)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            baseView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            baseView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            baseView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            baseView.widthAnchor.constraint(equalTo: view.widthAnchor),
            baseViewHeightConstraint,
            backgroundImageView.topAnchor.constraint(equalTo: baseView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: MainViewSizeConstants.backgroundImageViewHeight),
            mainView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor,
                                          constant: -MainViewSizeConstants.cornerRadius),
            mainView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor,
                                             constant: MainViewSizeConstants.cornerRadius),
            mainView.tableView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor)
        ])
        
        mainViewHeightConstraint = mainView.heightAnchor.constraint(equalToConstant: MainViewSizeConstants.height)
        mainViewHeightConstraint?.isActive = true
    }
    
    private func fetchData() {
        DispatchQueue.global().async {
            self.presenter.fetchData(by: self.serialNumber)
            self.presenter.provideBackgroundImage()
            self.presenter.provideRocketName()
            self.presenter.provideTableViewViewModel()
            self.presenter.provideCollectionViewViewModel()
        }
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
    
    private func resetViewState() {
        scrollView.scrollToTop(animated: true)
        mainView.collectionView?.scrollToLeft(animated: true)
    }
    
    private func showSettings() {
        router.showSettingsModule()
    }
    
    @objc
    func updateCollectionView(_ notification: Notification) {
        DispatchQueue.global().async {
            self.presenter.fetchData(by: self.serialNumber)
            self.presenter.provideCollectionViewViewModel()
        }
    }
}

// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func setBackgroundImage(with data: Data) {
        DispatchQueue.main.sync {
            backgroundImageView.image = UIImage(data: data)
            UIView.animate(withDuration: 0.5) {
                self.backgroundImageView.alpha = 1.0
            }
            activityIndicatorView.stopAnimating()
        }
    }
    
    func setHeaderWithName(_ name: String) {
        DispatchQueue.main.sync {
            title = name
            mainView.header.titleLabel.text = name
            mainView.header.activateButton()
            activityIndicatorView.stopAnimating()
        }
    }
    
    func setTableViewViewModel(_ viewModel: MainTableViewViewModel) {
        self.tableViewViewModel = viewModel
        self.tableViewViewModel?.buttonAction = showLaunches
        DispatchQueue.main.sync {
            activityIndicatorView.stopAnimating()
        }
    }
    
    func setCollectionViewViewModel(_ viewModel: MainCollectionViewViewModel) {
        self.collectionViewViewModel = viewModel
        DispatchQueue.main.sync {
            activityIndicatorView.stopAnimating()
        }
    }
}

//
//  MainViewController.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 05.04.2022.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func setBackgroundImage(with data: Data)
    func setName(_ name: String)
    func setViewModel(_ viewModel: MainViewModel)
}

final class MainViewController: UIViewController {
    
    // MARK: - Subviews
    lazy var backgroundImageView: UIImageView = {
        $0.backgroundColor = Color.background.uiColor
        $0.alpha = 0
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    lazy var bottomSheetView = MainBottomSheetView()
    
    // MARK: - Properties
    var presenter: MainPresenterProtocol!
    var router: Routing!
    var serialNumber: Int!
    
    private var viewModel: MainViewModel? {
        didSet {
            DispatchQueue.main.sync {
                bottomSheetView.tableView.dataSource = viewModel
                bottomSheetView.tableView.delegate = viewModel
                bottomSheetView.tableView.reloadData()
            }
        }
    }
    
    // bottomSheetView heights
    private let minBottomSheetViewHeight: CGFloat = 400.0
    private let maxBottomSheetViewHeight: CGFloat = UIScreen.main.bounds.height - 150.0
    private var currentBottomSheetViewHeight: CGFloat = 400.0
    
    // bottomSheetView dynamic constraints
    private var bottomSheetViewHeightConstraint: NSLayoutConstraint?
    private var bottomSheetViewBottomConstraint: NSLayoutConstraint?
    
    var panGesture = UIGestureRecognizer()
    var canSwipe = true
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupPanGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideNavigationBar()
        guard viewModel == nil else { return }
        fetchData()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        
        view.backgroundColor = Color.background.uiColor
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(backgroundImageView)
        view.addSubview(bottomSheetView)
        
        // constraints
        NSLayoutConstraint.activate([
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 32),
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetView.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        bottomSheetViewHeightConstraint = bottomSheetView.heightAnchor.constraint(equalToConstant: minBottomSheetViewHeight)
        bottomSheetViewBottomConstraint = bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 32.0)
        bottomSheetViewHeightConstraint?.isActive = true
        bottomSheetViewBottomConstraint?.isActive = true
    }
    
    private func fetchData() {
        DispatchQueue.global().async { [unowned self] in
            presenter.fetchData(by: serialNumber)
            presenter.provideBackgroundImage()
            presenter.provideRocketName()
            presenter.provideViewModel()
        }
    }
    
    private func setupPanGesture() {
        panGesture = UIPanGestureRecognizer(target: self,
                                            action: #selector(handlePanGesture(_:)))
        panGesture.delegate = self
        // changing to false to immediately listen on gesture movement
//        panGesture.delaysTouchesBegan = true
//        panGesture.delaysTouchesEnded = true
        view.addGestureRecognizer(panGesture)
    }

    @objc
    private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {

        let translation = gesture.translation(in: view)
        let isDraggingDown = translation.y > 0
        let transitionHeight = translation.y.magnitude > 100.0
        let newHeight = currentBottomSheetViewHeight - translation.y

        switch gesture.state {
        case .began:
            canSwipe = false
        case .changed:
            if newHeight < maxBottomSheetViewHeight && newHeight >= minBottomSheetViewHeight {
                bottomSheetViewHeightConstraint?.constant = newHeight
                view.layoutIfNeeded()
            }
        case .ended:
            if newHeight < maxBottomSheetViewHeight
                && newHeight > minBottomSheetViewHeight
                && isDraggingDown {
                // if new height is below max and going down, set to default height
                transitionHeight
                ? animateContainerHeight(minBottomSheetViewHeight)
                : animateContainerHeight(maxBottomSheetViewHeight)
            } else
            if newHeight > minBottomSheetViewHeight
                && newHeight < maxBottomSheetViewHeight
                && !isDraggingDown {
                // if new height is below max and going up, set to max height at top
                transitionHeight
                ? animateContainerHeight(maxBottomSheetViewHeight)
                : animateContainerHeight(minBottomSheetViewHeight)
            }
        case .cancelled:
            // reseting the bottom sheet position to min
            animateContainerHeight(minBottomSheetViewHeight)
        default:
            break
        }
    }
    
    private func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.bottomSheetViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        } completion: { [unowned self] _ in
            currentBottomSheetViewHeight = height
            canSwipe = true
            scrollTableViewAtTop()
        }
    }
    
    private func scrollTableViewAtTop() {
        guard viewModel != nil else { return }
        if currentBottomSheetViewHeight == minBottomSheetViewHeight {
            bottomSheetView.tableView.scrollToRow(at: [0,0], at: .top, animated: true)
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
}

// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func setBackgroundImage(with data: Data) {
        DispatchQueue.main.sync {
            backgroundImageView.image = UIImage(data: data)
            UIView.animate(withDuration: 0.5) { [unowned self] in
                backgroundImageView.alpha = 1.0
            }
        }
    }
    
    func setName(_ name: String) {
        DispatchQueue.main.sync {
            title = name
            bottomSheetView.topView.titleLabel.text = name
        }
    }
    
    func setViewModel(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
        self.viewModel?.buttonTapCallback = showLaunches
    }
}

// MARK: - UIGestureRecognizerDelegate
extension MainViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if currentBottomSheetViewHeight > maxBottomSheetViewHeight - 10 {
            bottomSheetView.tableView.isScrollEnabled = true
            return false
        }
        bottomSheetView.tableView.isScrollEnabled = false
        return canSwipe
    }
}

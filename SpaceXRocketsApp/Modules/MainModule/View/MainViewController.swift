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
    
    var viewModel: MainViewModel? {
        didSet {
            DispatchQueue.main.sync {
                bottomSheetView.tableView.dataSource = viewModel
                bottomSheetView.tableView.delegate = viewModel
                bottomSheetView.tableView.reloadData()
            }
        }
    }
    
    // hiding the navigation bar
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        super.viewWillDisappear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // bottomSheetView heights
    let minBottomSheetViewHeight: CGFloat = 400.0
    let maxBottomSheetViewHeight: CGFloat = UIScreen.main.bounds.height - 150.0
    var currentBottomSheetViewHeight: CGFloat = 400.0
    
    // bottomSheetView dynamic constraints
    var bottomSheetViewHeightConstraint: NSLayoutConstraint?
    var bottomSheetViewBottomConstraint: NSLayoutConstraint?
    
    var panGesture = UIGestureRecognizer()
    var canSwipe = true
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupPanGesture()
        DispatchQueue.global().async {
            self.presenter.fetchData(by: self.serialNumber)
            self.presenter.provideBackgroundImage()
            self.presenter.provideRocketName()
            self.presenter.provideViewModel()
        }
        
    }
    
    // reseting the bottom sheet position to min
    override func viewDidDisappear(_ animated: Bool) {
        animateContainerHeight(minBottomSheetViewHeight)
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        
        // view
        view.backgroundColor = Color.background.uiColor
        view.addSubview(backgroundImageView)
        view.addSubview(bottomSheetView)
        
        // constraints
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 32)
        ])
        
        bottomSheetViewHeightConstraint = bottomSheetView.heightAnchor.constraint(equalToConstant: minBottomSheetViewHeight)
        bottomSheetViewBottomConstraint = bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 32.0)
        bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomSheetViewHeightConstraint?.isActive = true
        bottomSheetViewBottomConstraint?.isActive = true
    }
    
    private func setupPanGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delegate = self
        // changing to false to immediately listen on gesture movement
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }

    @objc
    private func handlePanGesture(gesture: UIPanGestureRecognizer) {

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
            if newHeight < maxBottomSheetViewHeight && newHeight > minBottomSheetViewHeight && isDraggingDown {
                // if new height is below max and going down, set to default height
                transitionHeight ? animateContainerHeight(minBottomSheetViewHeight) : animateContainerHeight(maxBottomSheetViewHeight)
            }
            else if newHeight > minBottomSheetViewHeight && newHeight < maxBottomSheetViewHeight && !isDraggingDown {
                // if new height is below max and going up, set to max height at top
                transitionHeight ? animateContainerHeight(maxBottomSheetViewHeight) : animateContainerHeight(minBottomSheetViewHeight)
            }
        default:
            break
        }
    }
    
    private func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.bottomSheetViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        } completion: { [unowned self] _ in
            self.currentBottomSheetViewHeight = height
            self.canSwipe = true
            scrollTableToTop()
        }
    }
    
    private func scrollTableToTop() {
        if currentBottomSheetViewHeight == minBottomSheetViewHeight {
            bottomSheetView.tableView.scrollToRow(at: [0,0], at: .top, animated: true)
        }
    }
    
    private func showLaunches() {
        router.showDetailsModule(with: serialNumber, and: title ?? "")
    }
}

// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func setBackgroundImage(with data: Data) {
        DispatchQueue.main.sync {
            backgroundImageView.image = UIImage(data: data)
            UIView.animate(withDuration: 1.0) { [unowned self] in
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

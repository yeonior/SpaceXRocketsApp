//
//  MainViewController.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 05.04.2022.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func setBackgroundImage(with data: Data)
    func setViewModel(viewModel: MainViewModel)
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
    var viewModel: MainViewModel? {
        didSet {
            DispatchQueue.main.sync {
                bottomSheetView.tableView.dataSource = viewModel
                bottomSheetView.tableView.delegate = viewModel
                bottomSheetView.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Properties
    
    var presenter: MainPresenterProtocol!
    var router: Routing!
    var serialNumber: Int!
    
    // bottomSheetView heights
    let minBottomSheetViewHeight: CGFloat = 400.0
    let maxBottomSheetViewHeight: CGFloat = UIScreen.main.bounds.height - 100.0
    var currentBottomSheetViewHeight: CGFloat = 400.0
    
    // bottomSheetView dynamic constraints
    var BottomSheetViewHeightConstraint: NSLayoutConstraint?
    var BottomSheetViewBottomConstraint: NSLayoutConstraint?
    
    var panGesture = UIGestureRecognizer()
    var canSwipe = true
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupPanGesture()
        DispatchQueue.global().async {
            self.presenter.provideData(by: self.serialNumber)
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
            backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor)
        ])

        BottomSheetViewHeightConstraint = bottomSheetView.heightAnchor.constraint(equalToConstant: minBottomSheetViewHeight)
        BottomSheetViewBottomConstraint = bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 40.0)
        bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        BottomSheetViewHeightConstraint?.isActive = true
        BottomSheetViewBottomConstraint?.isActive = true
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
                BottomSheetViewHeightConstraint?.constant = newHeight
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
            self.BottomSheetViewHeightConstraint?.constant = height
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
    
    func setViewModel(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - UIGestureRecognizerDelegate
extension MainViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if currentBottomSheetViewHeight == maxBottomSheetViewHeight {
            bottomSheetView.tableView.isScrollEnabled = true
            return false
        }
        
        bottomSheetView.tableView.isScrollEnabled = false
        return canSwipe
    }
}

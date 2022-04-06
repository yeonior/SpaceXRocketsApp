//
//  MainPage.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 05.04.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Subviews
    
    lazy var backgroundImageView: UIImageView = {
        $0.image = UIImage(named: "rocket")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())

    lazy var bottomSheetView = MainBottomSheetView()
    
    // MARK: - Properties
    
    // container heights
    let minContainerHeight: CGFloat = 400.0
    let maxContainerHeight: CGFloat = UIScreen.main.bounds.height - 100.0
    var currentContainerHeight: CGFloat = 400.0
    
    // dynamic container constraints
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    var canSwipe = true
    var panGesture = UIGestureRecognizer()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupPanGesture()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        animateContainerHeight(minContainerHeight)
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        bottomSheetView.tableView.dataSource = self
        bottomSheetView.tableView.delegate = self
        
        // view
        view.backgroundColor = .systemBackground
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

        containerViewHeightConstraint = bottomSheetView.heightAnchor.constraint(equalToConstant: minContainerHeight)
        containerViewBottomConstraint = bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 40.0)
        bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
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
        let newHeight = currentContainerHeight - translation.y

        switch gesture.state {
        case .began:
            canSwipe = false
        case .changed:
            if newHeight < maxContainerHeight && newHeight >= minContainerHeight {
                containerViewHeightConstraint?.constant = newHeight
                view.layoutIfNeeded()
            }
        case .ended:
            if newHeight < maxContainerHeight && newHeight > minContainerHeight && isDraggingDown {
                // if new height is below max and going down, set to default height
                transitionHeight ? animateContainerHeight(minContainerHeight) : animateContainerHeight(maxContainerHeight)
            }
            else if newHeight > minContainerHeight && newHeight < maxContainerHeight && !isDraggingDown {
                // if new height is below max and going up, set to max height at top
                transitionHeight ? animateContainerHeight(maxContainerHeight) : animateContainerHeight(minContainerHeight)
            }
        default:
            break
        }
    }

    private func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        } completion: { [unowned self] _ in
            self.currentContainerHeight = height
            self.canSwipe = true
            scrollTableToTop()
        }
    }
    
    private func scrollTableToTop() {
        if currentContainerHeight == minContainerHeight {
            bottomSheetView.tableView.scrollToRow(at: [0,0], at: .top, animated: true)
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension MainViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if currentContainerHeight == maxContainerHeight {
            bottomSheetView.tableView.isScrollEnabled = true
            return false
        }
        
        bottomSheetView.tableView.isScrollEnabled = false
        return canSwipe
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 3 ? 1 : 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        indexPath.section == 3 ? MainShowButtonTableViewCell() : MainFirstSectionTableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return section == 0 ? 0.0 : 32
        0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        guard section == 2 else { return 0 }
//
//        return 120
        0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 3 ? 60 : 50
    }
}

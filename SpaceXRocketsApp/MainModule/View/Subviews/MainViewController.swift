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

    lazy var containerView = MainContainerView()
    
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
    
    // MARK: - Private methods
    
    private func configureUI() {
        containerView.tableView.dataSource = self
        containerView.tableView.delegate = self
        
        // view
        view.backgroundColor = .systemBackground
        view.addSubview(backgroundImageView)
        view.addSubview(containerView)
        
        // constraints
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor)
        ])

        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: minContainerHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 40.0)
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
    private func setupPanGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delegate = self
        // changing to false to immediately listen on gesture movement
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        containerView.topView.dragView.addGestureRecognizer(panGesture)
    }

    @objc
    private func handlePanGesture(gesture: UIPanGestureRecognizer) {

        let translation = gesture.translation(in: view)
        let isDraggingDown = translation.y > 0
        let transitionHeight = translation.y.magnitude > 100.0
        let newHeight = currentContainerHeight - translation.y

        switch gesture.state {
        case .changed:
            if newHeight < maxContainerHeight && newHeight >= minContainerHeight {
                canSwipe = false
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
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension MainViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if currentContainerHeight == maxContainerHeight {
            return false
        }
        return canSwipe
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        guard section == 2 else { return nil }
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 160))
        footerView.backgroundColor = .black
        
        let showButton = MainShowButton(frame: CGRect(x: 0, y: 0, width: 300, height: 54))
        showButton.center = footerView.center
        
        footerView.addSubview(showButton)
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard section == 2 else { return 20 }
        
        return 200
    }
}

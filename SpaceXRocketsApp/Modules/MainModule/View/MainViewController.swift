//
//  MainViewController.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 05.04.2022.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func setBackgroundImage(with data: Data)
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
    
    // container heights
    let minContainerHeight: CGFloat = 400.0
    let maxContainerHeight: CGFloat = UIScreen.main.bounds.height - 100.0
    var currentContainerHeight: CGFloat = 400.0
    
    // dynamic container constraints
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    var panGesture = UIGestureRecognizer()
    var canSwipe = true
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupPanGesture()
        DispatchQueue.global().async {
            self.presenter.provideInfo(by: self.serialNumber)
        }
    }
    
    // reseting the bottom sheet position to min
    override func viewDidDisappear(_ animated: Bool) {
        animateContainerHeight(minContainerHeight)
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        bottomSheetView.tableView.dataSource = self
        bottomSheetView.tableView.delegate = self
        
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
//        indexPath.section == 3 ? MainShowButtonTableViewCell() : MainStageSectionTableViewCell()
        switch indexPath.section {
        case 0:
            let cell = MainInfoSectionTableViewCell()
//            cell.mainLabel.text = page.name
//            cell.detailsLabel.text = String(page.costPerLaunch)
            return cell
        case 3:
            return MainShowButtonTableViewCell()
        default:
            return MainStageSectionTableViewCell()
        }
    }
    
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        
//        let header = view as? UITableViewHeaderFooterView
//        header?.textLabel?.font = Font.tableSectionHeader.uiFont
//        header?.textLabel?.textColor = Color.tableSectionHeader.uiColor
//    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        "ПЕРВАЯ СТУПЕНЬ"
//    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 3 ? 60 : 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0, 3:
            return nil
        default:
            return MainTableViewSectionHeader()
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0, 3:
            return 0
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0, 1:
            return 20
        case 2, 3:
            return 32
        default:
            return 0
        }
    }
}

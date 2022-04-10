//
//  BasePageViewController.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 05.04.2022.
//

import UIKit

protocol BaseViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

final class BasePageViewController: UIPageViewController {
    
    var viewControllersToDisplay: [UIViewController] = []
    var presenter: BasePresenterProtocol!
    var router: Routing!
    
    var startPageIndex = 0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
        configurePageControl()
        setupScrollViewDelegate()
        presenter.fetchPages()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configurePageControlHeight()
    }
    
    // MARK: - Private methods
    
    private func setupPageViewController() {
        delegate = self
        dataSource = self
        additionalSafeAreaInsets.bottom = CGFloat(12)
        view.backgroundColor = Color.background.uiColor
    }
    
    private func setViewControllerToDisplay() {
        setViewControllers([viewControllersToDisplay[startPageIndex]], direction: .forward, animated: true, completion: nil)
    }
    
    private func configurePageControl() {
        let pageControl = UIPageControl.appearance()
        pageControl.currentPageIndicatorTintColor = Color.currentPageIndicator.uiColor
        pageControl.pageIndicatorTintColor = Color.pageIndicator.uiColor
        pageControl.backgroundColor = .clear
        pageControl.center = view.center
        pageControl.isUserInteractionEnabled = false
    }
    
    private func configurePageControlHeight() {
        for view in self.view.subviews{
            if view is UIPageControl {
                view.frame.origin.y = self.view.frame.size.height - 56
            }
        }
    }
    
    private func setupScrollViewDelegate() {
        let scrollView = view.subviews.compactMap({ $0 as? UIScrollView }).first!
        scrollView.delegate = self
    }
}

// MARK: - UIPageViewControllerDataSource
extension BasePageViewController: UIPageViewControllerDataSource {
    
    // the view controller before the given one
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? MainViewController else { return nil }
        
        if let index = viewControllersToDisplay.firstIndex(of: vc) {
            if index > 0 {
                return viewControllersToDisplay[index - 1]
            } else {
                return nil
            }
        }
        
        return nil
    }
    
    // the view controller after the given one
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? MainViewController else { return nil }
        
        if let index = viewControllersToDisplay.firstIndex(of: vc) {
            if index < viewControllersToDisplay.count - 1 {
                return viewControllersToDisplay[index + 1]
            } else {
                return nil
            }
        }
        
        return nil
    }
    
    // the number of pages reflecting in the page control
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        viewControllersToDisplay.count
    }
    
    // the current page index reflecting in the page control
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        startPageIndex
    }
}

// MARK: - UIPageViewControllerDelegate
extension BasePageViewController: UIPageViewControllerDelegate {
    
    // blocking the pan gesture to prevent simultaneous recognizing
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let vc = viewControllers?.first as? MainViewController else { return }
        vc.canSwipe = false
        vc.panGesture.isEnabled = false
    }
    
    // unblocking the pan gesture
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let vc = previousViewControllers.first as? MainViewController else { return }
        vc.canSwipe = true
        vc.panGesture.isEnabled = true
    }
}

// MARK: - UIScrollViewDelegate
extension BasePageViewController: UIScrollViewDelegate {
    
    // disabling UIPageViewController bounce
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard viewControllersToDisplay.count > 1 else {
            scrollView.isScrollEnabled = false
            return
        }
        
        guard let viewControllers = viewControllers, viewControllers.count != 0 else { return }
        
        let baseRecord = viewControllers
            .map{ [superview = view!] viewController -> (viewController: UIViewController, originX: CGFloat) in
                let originX = superview.convert(viewController.view.bounds.origin, from: viewController.view).x
                return (viewController: viewController, originX: originX)
            }
            .sorted(by: { $0.originX < $1.originX })
            .first!
        
        guard let baseIndex = viewControllersToDisplay.firstIndex(of: baseRecord.viewController as! MainViewController) else { return }
        
        let baseViewControllerOffsetXRatio = -baseRecord.originX/scrollView.bounds.width
        let progress = (CGFloat(baseIndex) + baseViewControllerOffsetXRatio)/CGFloat(viewControllersToDisplay.count - 1)
        if !(0...1 ~= progress) {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
    }
}

// MARK: - MainViewProtocol
extension BasePageViewController: BaseViewProtocol {
    
    // setting up view controllers to display depending on the request result (success or failure)
    
    func success() {
        for page in presenter.pages {
            let vc = router.activateMainModule(with: page)
            viewControllersToDisplay.append(vc)
        }
        setViewControllerToDisplay()
    }
    
    func failure(error: Error) {
        debugPrint(error.localizedDescription)
        viewControllersToDisplay = [router.provideEmptyMainViewController()]
        setViewControllerToDisplay()
    }
}

//
//  OnboardingViewController.swift
//  BeaconsOnboarding
//
//  Created by Franco Rivera on 10/1/18.
//  Copyright © 2018 Franco Rivera. All rights reserved.
//

import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    var currentIndex: Int = 0
    var pageControl = UIPageControl()
    var nextPageButton = UIButton()
    
    @objc func nextView(){
        let nextIndex = currentIndex >= orderedViewControllers.count-1 ? 0 : currentIndex + 1
        setViewControllers([orderedViewControllers[nextIndex]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
        self.pageControl.currentPage = nextIndex
        currentIndex = nextIndex
    }
    // MARK: UIPageViewControllerDataSource
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVc(viewController: "page1"),
                self.newVc(viewController: "page2"),
                self.newVc(viewController: "page3")]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        
        
        // This sets up the first view that will show up on our page control
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        configurePageControl()
        nextPageButton = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.maxY-100, width: UIScreen.main.bounds.width-200, height: 40))
        nextPageButton.backgroundColor = UIColor.white
        nextPageButton.setTitle("Continue", for: .normal)
        nextPageButton.setTitleColor(UIColor.red, for: .normal)
        nextPageButton.setTitleColor(UIColor.blue, for: .selected)
        nextPageButton.layer.cornerRadius = 10
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(nextView))
        nextPageButton.addGestureRecognizer(tap)
        self.view.addSubview(nextPageButton)
        // Do any additional setup after loading the view.
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 250,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor(displayP3Red: 255/255, green: 155/255, blue: 155/255, alpha: 1)
        self.pageControl.pageIndicatorTintColor = UIColor(red: 0.9254, green: 0.5476, blue: 0.5665, alpha: 1)
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 0.925, green: 0.3355, blue: 0.4256, alpha: 1)
        self.view.addSubview(pageControl)
    }
    
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    
    // MARK: Delegate methords
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }
    
    // MARK: Data source functions.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            // return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            // return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}

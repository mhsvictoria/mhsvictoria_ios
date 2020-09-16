//
//  MhsgvPageViewController.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-08-07.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

class MhsgvPageViewController: UIPageViewController {
    
    var currentSelection: Int = FormFlow.age.rawValue {
        didSet {
            NSLog("<><><> PAGE: currentSelection \(currentSelection)")
            goToPage(currentSelection)
        }
    }
    
    fileprivate lazy var pages: [BaseViewController] = {
        return [
            self.getViewController(withIdentifier: viewArray[FormFlow.age.rawValue], number: FormFlow.age.rawValue),
            self.getViewController(withIdentifier: viewArray[FormFlow.description.rawValue], number: FormFlow.description.rawValue),
            self.getViewController(withIdentifier: viewArray[FormFlow.resourcePreference.rawValue], number: FormFlow.resourcePreference.rawValue),
           
        ]
    }()
    
    fileprivate func getViewController(withIdentifier identifier: String, number: Int) -> BaseViewController
    {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier) as? BaseViewController
        vc?.pageNumber = number
        vc?.mhsgvPageViewController = self
        return vc!
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = cornerRadius
        
        self.dataSource = self
        self.delegate   = self
        
        if let firstVC = pages.first
        {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    private func goToPage(_ page: Int) {
        NSLog("<><><> PAGE: goToPage \(page)")
        // go to the first page
        if page == 0 {
            if let firstVC = pages.first
            {
                setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
            }
            return
        }
        
        if page == FormFlow.end.rawValue {
            if let lastVC = pages.last
            {
                setViewControllers([lastVC], direction: .forward, animated: true, completion: nil)
            }
            return
        }
        
        let currentVC = pages[page]
        setViewControllers([currentVC], direction: .forward, animated: true, completion: nil)
    }
}

extension MhsgvPageViewController: UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController as! BaseViewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard pages.count > previousIndex else {
            return nil
        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = pages.firstIndex(of: viewController as! BaseViewController) else {
            return nil
        }
        
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pages.count else {
            return nil
        }
        
        guard pages.count > nextIndex else {
            return nil
        }
        
        return pages[nextIndex]
    }
}

extension MhsgvPageViewController: UIPageViewControllerDelegate {
}

//
//  MainViewController.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-08-07.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit
import CodableCSV

class MainViewController: UIViewController {
    
    
    let resourceManager = ResourceManager()
    var query = ResourceQuery()
    
    @IBOutlet weak var containerView: UIView!
    var pageVC: UIPageViewController?
    var pages: [UIViewController] = []
    @IBOutlet weak var pageControl: CustomPageControl!
    var nextTab: Int?
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resourceManager.delegate = self
        //resourceManager.fetchResources()
        resourceManager.fakeFetch()
        loadPages()
    }
    
    private func loadPages() {
        let storyboard = UIStoryboard(name: "Resources", bundle: nil)
        guard let page1 = storyboard.instantiateViewController(identifier: "Form1ViewController") as? Form1ViewController else { return }
        guard let page2 = storyboard.instantiateViewController(identifier: "Form2ViewController") as? Form2ViewController else { return }
        guard let page3 = storyboard.instantiateViewController(identifier: "Form3ViewController") as? Form3ViewController else { return }
        pages = [page1, page2, page3]
        page1.pageNumber = 0
        page2.pageNumber = 1
        page3.pageNumber = 2
        pageVC?.setViewControllers([page1], direction: .forward, animated: false, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UIPageViewController {
            pageVC = destination
            destination.delegate = self
            destination.dataSource = self
        }
        
        if let resultsVC = segue.destination as? ResultsViewController {
            //resultsVC.rankedResults = getRankedResources()
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if let currentPageIndex = (pageVC?.viewControllers?.first as? BaseViewController)?.pageNumber {
            goToTab(number: currentPageIndex + 1)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        if let currentPageIndex = (pageVC?.viewControllers?.first as? BaseViewController)?.pageNumber {
            goToTab(number: currentPageIndex - 1)
        }
    }
    
    private func setButtonVisibility(number: Int) {
        // TODO
        if number == pages.count - 1 {
            nextButton.isHidden = true
        } else {
            nextButton.isHidden = false
        }
        if number == 0 {
            UIView.animate(withDuration: 0.10) {
                self.backButton.alpha = 0
                self.backButton.isHidden = true
            }
        } else {
            UIView.animate(withDuration: 0.10) {
                self.backButton.alpha = 1
                self.backButton.isHidden = false
            }
        }
    }
    
    func goToTab(number: Int) {
        print(number)
        if let pageVC = pageVC {
            if let currentPageIndex = (pageVC.viewControllers?.first as? BaseViewController)?.pageNumber {
                if currentPageIndex < number {
                    pageVC.setViewControllers([pages[number]], direction: .forward, animated: true, completion: nil)
                } else {
                    pageVC.setViewControllers([pages[number]], direction: .reverse, animated: true, completion: nil)
                }
                pageControl.selectedTabNumber = number
                setButtonVisibility(number: number)
            }
        }
    }
    
}

extension MainViewController: UIPageViewControllerDelegate {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let page = pendingViewControllers.first as? BaseViewController {
            nextTab = page.pageNumber
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let tabNumber = nextTab {
            pageControl.selectedTabNumber = tabNumber
            setButtonVisibility(number: tabNumber)
        }
    }
}

extension MainViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let page = viewController as? BaseViewController, page.pageNumber - 1 >= 0 {
            return pages[page.pageNumber - 1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let page = viewController as? BaseViewController, page.pageNumber + 1 < pages.count {
            return pages[page.pageNumber + 1]
        }
        return nil
    }
    
    
}


extension MainViewController: Form1ViewControllerDelegate {
    
    func ageSelected(age: Int) {
        query.age = age
    }
}

extension MainViewController: Form2ViewControllerDelegate {
    
    func selectionsDidChange(selections: [Identity]) {
        query.identities = selections
    }
}

extension MainViewController: Form3ViewControllerDelegate {
    
    func finishWasPressed() {
        performSegue(withIdentifier: "ResultsSegue", sender: self)
    }
}

extension MainViewController: ResourceManagerDelegate {
    func didFetchResources(resources: [Resource]) {
        print(resources)
    }
}


struct ResourceQuery {
    var age: Int?
    var identities: [Identity] = []
    var locations: [Location] = []
    var costOptions: [Cost] = []
}

enum Identity: String, CaseIterable, Codable {
    case male = "Male"
    case female = "Female"
    case substanceUse = "Substance Use"
    case family = "Family"
    case immigrant = "Immigrant"
    case indigenous = "Indigenous"
    case student = "Student"
    case religious = "Religious"
    case lgbt = "LGBTQ+"
}

enum Cost: String, RawRepresentableAll, CaseIterable, Codable {
    case lowCost = "Low Cost"
    case free = "Free"
    case allCosts = "All"
    static var all: Cost { allCosts }
    typealias RawValue = String
}

enum Location: String, RawRepresentableAll, CaseIterable, Codable {
    static var all: Location { allLocations }
    case sooke = "Sooke"
    case sidney = "Sidney"
    case victoria = "Victoria"
    case langford = "Langford"
    case allLocations = "All"
    typealias RawValue = String
}

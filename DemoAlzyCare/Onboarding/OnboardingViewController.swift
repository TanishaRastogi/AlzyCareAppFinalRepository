import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private let pageControl = UIPageControl()
    
    private let pages: [(title: String, description: String, imageName: String)] = [
        ("Welcome to AlzyCare", "Your comprehensive Alzheimer's companion. Assess, plan, and cherish memories with a personalized cognitive activities planner generated daily, alongside diary and meditation support.", "AlzyCareLogo"),
        ("Assessment", "Discover your Alzheimer's risk level through assessments covering executive functioning, memory, logic, and reasoning. Get categorized results from mild to severe, guiding personalized care.", "CognitiveActivityOnboarding"),
        ("Planner", "Customize your day with activities tailored to improve your cognitive strengths from assessment scores, enhanced by biweekly reminiscence therapy for holistic cognitive well-being", "PlannerOnboardingScreen"),
        ("Memory Lane", "Explore Memory Lane: organize, color-code, and add descriptions to your memories, sorting by recent additions for a personalized journey.", "MemoryLaneOnboarding")
    ]
    
    private var contentViewControllers: [OnboardingContentViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        for (index, page) in pages.enumerated() {
            let contentVC = OnboardingContentViewController()
            contentVC.titleText = page.title
            contentVC.descriptionText = page.description
            contentVC.imageName = page.imageName
            contentVC.pageIndex = index
            contentViewControllers.append(contentVC)
        }
        
        if let firstVC = contentViewControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        setupPageControl()
    }
    
    private func setupPageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = contentViewControllers.firstIndex(of: viewController as! OnboardingContentViewController) else {
            return nil
        }
        
        let previousIndex = currentIndex - 1
        return previousIndex >= 0 ? contentViewControllers[previousIndex] : nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = contentViewControllers.firstIndex(of: viewController as! OnboardingContentViewController) else {
            return nil
        }
        
        let nextIndex = currentIndex + 1
        return nextIndex < contentViewControllers.count ? contentViewControllers[nextIndex] : nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let currentVC = pageViewController.viewControllers?.first as? OnboardingContentViewController,
           let currentIndex = contentViewControllers.firstIndex(of: currentVC) {
            pageControl.currentPage = currentIndex
        }
    }
}


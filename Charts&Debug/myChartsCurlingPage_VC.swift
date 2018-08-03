//
//  myCurlingPageViewController.swift
//

import UIKit

class myPageViewControllerClass: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    
    var myPageViewController: myChartsCurlingPageVC? {
        didSet {
            myPageViewController?.myCurlingPageDelegate = self
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let aPageViewController = segue.destination as? myChartsCurlingPageVC {
            self.myPageViewController = aPageViewController
        }
    }
    
    @IBAction func tappedNextPageIcon(_ sender: Any) {
        myPageViewController?.scrollToNextViewController()
    }
    
//    @IBAction func didTapNextButton(_ sender: UIButton) {
//        myPageViewController?.scrollToNextViewController()
//    }
    

    //Fired when the user taps on the pageControl to change its current page.
    @objc func didChangePageControlValue() {
        myPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.addTarget(self, action: #selector(myPageViewControllerClass.didChangePageControlValue), for: .valueChanged)
    }
}

extension myPageViewControllerClass: myPageViewControllerDelegate {
    
    func curlingPageViewController(_ thisPageViewController: myChartsCurlingPageVC,
                                   didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func curlingPageViewController(_ thisPageViewController: myChartsCurlingPageVC,
                                   didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}

//MARK: -
class myChartsCurlingPageVC: UIPageViewController {
    
    weak var myCurlingPageDelegate: myPageViewControllerDelegate?
    
    fileprivate(set) lazy var orderedViewControllers: [UIViewController] = {
        // The view controllers will be shown in this order
        return [self.newColoredViewController("Chart1"),
            self.newColoredViewController("Chart2"),
            self.newColoredViewController("Chart3"),
            self.newColoredViewController("Chart4")]
    }()
    
   
    /**
     Scrolls to the next view controller.
     */
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self,
                viewControllerAfter: visibleViewController) {
                    scrollToViewController(nextViewController)
        }
    }
    
    /**
     Scrolls to the view controller at the given index. Automatically calculates
     the direction.
     
     - parameter newIndex: the new index to scroll to
     */
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
            let currentIndex = orderedViewControllers.index(of: firstViewController) {
                let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .forward : .reverse
                let nextViewController = orderedViewControllers[newIndex]
                scrollToViewController(nextViewController, direction: direction)
        }
    }
    
    fileprivate func newColoredViewController(_ color: String) -> UIViewController {
        return UIStoryboard(name: "PageViewCharts", bundle: nil) .
            instantiateViewController(withIdentifier: "\(color)ViewController")
    }
    
    /**
     Scrolls to the given 'viewController' page.
     
     - parameter viewController: the view controller to show.
     */
    fileprivate func scrollToViewController(_ viewController: UIViewController,
        direction: UIPageViewControllerNavigationDirection = .forward) {
        setViewControllers([viewController],
            direction: direction,
            animated: true,
            completion: { (finished) -> Void in
                // Setting the view controller programmatically does not fire
                // any delegate methods, so we have to manually notify the
                // 'tutorialDelegate' of the new index.
                self.notifyCurlingDelegateOfNewIndex()
        })
    }
    
    /**
     Notifies myPageViewControllerDelegate (myCurlingPageDelegate) that the current page index was updated.
     */
    fileprivate func notifyCurlingDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
                myCurlingPageDelegate?.curlingPageViewController(self, didUpdatePageIndex: index)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        if let initialViewController = orderedViewControllers.first {
            scrollToViewController(initialViewController)
        }
        
        myCurlingPageDelegate?.curlingPageViewController(self, didUpdatePageCount: orderedViewControllers.count)
    }
}

// MARK: - UIPageViewControllerDataSource
extension myChartsCurlingPageVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
                return nil
            }
            
            let previousIndex = viewControllerIndex - 1
            
            // User is on the first view controller and swiped left to loop to
            // the last view controller.
            guard previousIndex >= 0 else {
                //return orderedViewControllers.last
                return nil
            }
//
            guard orderedViewControllers.count > previousIndex else {
                return nil
            }
            
            return orderedViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
                return nil
            }
            
            let nextIndex = viewControllerIndex + 1
            let orderedViewControllersCount = orderedViewControllers.count
            
            // User is on the last view controller and swiped right to loop to
            // the first view controller.
//            guard orderedViewControllersCount != nextIndex else {
//                return orderedViewControllers.first
//            }
        
            guard orderedViewControllersCount > nextIndex else {
                return nil
        }
        return orderedViewControllers[nextIndex]
    }
}

// MARK: - UIPageViewControllerDelegate
extension myChartsCurlingPageVC: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool) {
        notifyCurlingDelegateOfNewIndex()
    }
    
}

//MARK: - Protocol functions
protocol myPageViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter thisPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func curlingPageViewController(_ thisPageViewController: myChartsCurlingPageVC,
        didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter thisPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func curlingPageViewController(_ thisPageViewController: myChartsCurlingPageVC,
        didUpdatePageIndex index: Int)
    
}




//
//  RocketViewController.swift
//  RocketsApp
//
//  Created by Kirill Privalov on 30.06.2022.
//

import Foundation
import UIKit

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

class RocketScreenViewController: UIViewController {
    var pageViewController: UIPageViewController
    var firstRocketController = FirstViewController()
    var secondRocketController = SecondViewController()
    
    var currentVC: UIViewController {
        didSet {}
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        controllers.append(firstRocketController)
        controllers.append(secondRocketController)
        self.currentVC = controllers.first!
                  
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var controllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.dataSource = self
        pageViewController.setViewControllers([controllers.first!], direction: .forward, animated: true)
        currentVC = controllers.first!
    }
}

extension RocketScreenViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        self.currentVC = controllers[index - 1]
        return controllers[index - 1]    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController), index + 1 < controllers.count else { return nil }
        self.currentVC = controllers[index + 1]
        return controllers[index + 1]    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return controllers.firstIndex(of: self.currentVC) ?? 0
    }
}

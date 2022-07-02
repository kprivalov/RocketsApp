//
//  RocketViewController.swift
//  RocketsApp
//
//  Created by Kirill Privalov on 30.06.2022.
//

import Foundation
import UIKit

// MARK: - ViewControllers

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

// MARK: - RocketScreenViewController

class RocketScreenViewController: UIPageViewController {
    var firstRocketController = FirstViewController()
    var secondRocketController = SecondViewController()
    
    var controllers = [UIViewController]()

    var currentVC: UIViewController {
        didSet {}
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle = .scroll,
                  navigationOrientation: UIPageViewController.NavigationOrientation = .horizontal,
                  options: [UIPageViewController.OptionsKey : Any]? = nil) {
        controllers.append(firstRocketController)
        controllers.append(secondRocketController)
        self.currentVC = controllers.first!
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        setViewControllers([controllers.first!], direction: .forward, animated: true)
        currentVC = controllers.first!
    }
}

// MARK: - UIPageViewControllerDataSource

extension RocketScreenViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        self.currentVC = controllers[index - 1]
        return controllers[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController), index + 1 < controllers.count else { return nil }
        self.currentVC = controllers[index + 1]
        return controllers[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        controllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        controllers.firstIndex(of: self.currentVC) ?? 0
    }
}

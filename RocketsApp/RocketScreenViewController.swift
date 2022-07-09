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
    lazy var settingsButton = UIButton()
    
    private func goToSettingsScreen() {
        let settings = SettingsTableView()
        let nav = NavigationController(rootViewController: settings)
        nav.modalPresentationStyle = .automatic
        present(nav, animated: true)
    }
    
    func customizeSettingsButton() {
        settingsButton.addAction(UIAction(title: "Click Me", handler: { [weak self] _ in
            self?.goToSettingsScreen()
        }), for: .allEvents)
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 32)
        let gearshapeImage = UIImage(systemName: "gearshape", withConfiguration: configuration)?.withTintColor(UIColor(red: 0.792, green: 0.792, blue: 0.792, alpha: 1), renderingMode: .alwaysOriginal)
        
        // Autolayout
        settingsButton.setImage(gearshapeImage, for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        settingsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    

    override func viewDidLoad() {
        view.addSubview(settingsButton)
        customizeSettingsButton()
        super.viewDidLoad()
        view.backgroundColor = .black
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

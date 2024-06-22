//
//  SceneDelegate.swift
//  MKNewsReader
//
//  Created by MK on 6/17/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let vm = NewsListViewController.ViewModel(
            payload: .init(),
            dependency: .init(newsRepository: NewsRepository())
        )
        let vc = NewsListViewController(viewModel: vm)
        let nc = BaseNavigationController(rootViewController: vc)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataStack.shared.saveContext()
    }
}

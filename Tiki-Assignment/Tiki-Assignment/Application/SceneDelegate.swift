//
//  SceneDelegate.swift
//  Tiki-Assignment
//
//  Created by Kai on 05/07/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.setupWindow(windowScene: windowScene)
    }
    
    @available(iOS 13, *)
    func setupWindow(windowScene: UIWindowScene) {
        MyApp.shared.bootstrap()
        let rootViewController = OnboardingViewController()
        let navigation = UINavigationController(rootViewController: rootViewController)
        
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        self.window?.windowScene = windowScene
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
    }

    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {

    }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {

    }
}

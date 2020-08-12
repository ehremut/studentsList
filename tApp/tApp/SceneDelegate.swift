//
//  SceneDelegate.swift
//  tApp
//
//  Created by macOS developer on 16.07.2020.
//  Copyright © 2020 macOS developer. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let mainVC = ModelBuilder.createMainModule()
        let navBar = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = navBar
        window?.makeKeyAndVisible()
    }
}


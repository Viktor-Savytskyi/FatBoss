//
//  SceneDelegate.swift
//  FatBoss
//
//  Created by 12345 on 26.06.2023.
//

import UIKit
import Swinject
import SwinjectStoryboard

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    let container = Container()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        window?.rootViewController = GlobalRouter.shared.setNavigationController()
        window?.makeKeyAndVisible()
    }
    
   
}


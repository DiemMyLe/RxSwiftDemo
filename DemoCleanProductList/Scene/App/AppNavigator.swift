//
//  AppNavigator.swift
//  DemoCleanProductList
//
//  Created by DiemMy Le on 4/4/21.
//  Copyright © 2021 DiemMy Le. All rights reserved.
//

import UIKit

protocol AppNavigatorProtocol {
    func toMain()
}

//implement
struct AppNavigator: AppNavigatorProtocol {
    unowned let window: UIWindow
    unowned let assebler: Assembler
    
    func toMain() {
        let navi = UINavigationController()
        let vc: MainMenuViewController = assebler.resolve(navigationController: navi)
        navi.viewControllers.append(vc)
        window.rootViewController = navi
        window.makeKeyAndVisible()
    }
}

//
//  MainMenuNavigator.swift
//  DemoCleanProductList
//
//  Created by DiemMy Le on 4/4/21.
//  Copyright © 2021 DiemMy Le. All rights reserved.
//

import UIKit

protocol MainMenuNavigatorProtocol {
    func goToColorPickerCollectionView()
}

struct MainMenuNavigator: MainMenuNavigatorProtocol {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func goToColorPickerCollectionView() {
        let vc: CollectionMenuViewController = assembler.resolve(navigation: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
}

//
//  MainMenuAssembler.swift
//  DemoCleanProductList
//
//  Created by DiemMy Le on 4/4/21.
//  Copyright © 2021 DiemMy Le. All rights reserved.
//

import UIKit

protocol MainMenuAssembler {
    func resolve(navigationController: UINavigationController) -> MainMenuViewController
    func resolve(navigationController: UINavigationController) -> MainMenuViewModel
    func resolve(navigationController: UINavigationController) -> MainMenuNavigatorProtocol
    func resolve() -> MainMenuUsecasesProtocol
}

extension MainMenuAssembler {
    func resolve(navigationController: UINavigationController) -> MainMenuViewController {
        let vc = MainMenuViewController.instantiate()
        let vm: MainMenuViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> MainMenuViewModel {
        return MainMenuViewModel(navigator: resolve(navigationController: navigationController), usecase: resolve())
    }
}

extension MainMenuAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> MainMenuNavigatorProtocol {
        return MainMenuNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> MainMenuUsecasesProtocol {
        return MainMenuUsecases()
    }
}



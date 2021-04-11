//
//  CollectionMenuAssembler.swift
//  DemoCleanProductList
//
//  Created by DiemMy Le on 4/7/21.
//  Copyright © 2021 DiemMy Le. All rights reserved.
//

import UIKit

protocol CollectionMenuAssembler {
    func resolve(navigation: UINavigationController) -> CollectionMenuViewController
    func resolve(navigation: UINavigationController) -> CollectionMenuViewModel
    func resolve(navigation: UINavigationController) -> CollectionMenuNavigatorProtocol
    func resolve() -> CollectionMenuUseCaseProtocol
}

extension CollectionMenuAssembler {
    func resolve(navigation: UINavigationController) -> CollectionMenuViewController {
        let vc = CollectionMenuViewController.instantiate()
        let vm: CollectionMenuViewModel = resolve(navigation: navigation)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigation: UINavigationController) -> CollectionMenuViewModel {
        return CollectionMenuViewModel(navigator: resolve(navigation: navigation), usecase: resolve())
    }
}

extension CollectionMenuAssembler where Self: DefaultAssembler {
    func resolve(navigation: UINavigationController) -> CollectionMenuNavigatorProtocol {
        return CollectionMenuNavigator(assembler: self, navigationController: navigation)
    }
    func resolve() -> CollectionMenuUseCaseProtocol {
        return CollectionMenuUseCase()
    }
}


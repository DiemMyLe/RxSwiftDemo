//
//  AppAssembler.swift
//  DemoCleanProductList
//
//  Created by DiemMy Le on 4/4/21.
//  Copyright © 2021 DiemMy Le. All rights reserved.
//

import UIKit

protocol AppAssembler {
    func resolve(window: UIWindow) -> AppViewModel
    func resolve(window: UIWindow) -> AppNavigatorProtocol
    func resolve() -> AppUsecaseProtocol
}

extension AppAssembler {
    func resolve(window: UIWindow) -> AppViewModel {
        return AppViewModel(navigator: resolve(window: window), usecase: resolve())
    }
}
extension AppAssembler where Self: DefaultAssembler {
    func resolve(window: UIWindow) -> AppNavigatorProtocol {
        return AppNavigator(window: window, assebler: self)
    }
    func resolve() -> AppUsecaseProtocol {
        return AppUsecase()
    }
}


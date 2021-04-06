//
//  MainMenuViewModel.swift
//  DemoCleanProductList
//
//  Created by DiemMy Le on 4/4/21.
//  Copyright © 2021 DiemMy Le. All rights reserved.
//

import UIKit
import MGArchitecture
import RxCocoa
import RxSwift

struct MainMenuViewModel {
    //navigator, usecase
    let navigator: MainMenuNavigatorProtocol
    let usecase: MainMenuUsecasesProtocol
}

extension MainMenuViewModel: ViewModel {

    struct Input {
        let load: Driver<Void>
        let seclectMenu: Driver<IndexPath>
    }

    struct Output {
        @Property var menuSections = [MenuSection]()
    }

    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        //input
        input.load.map({self.createMenuSections()})
            .drive(output.$menuSections)
            .disposed(by: disposeBag)
        
        input.seclectMenu.map { (indexPath) in
            output.menuSections[indexPath.section].menus[indexPath.row]
        }.drive(onNext: { (menu) in
            debugPrint("MENU: \(menu.strDescription)")
            }).disposed(by: disposeBag)
        
        return output
    }
    
    func createMenuSections() -> [MenuSection] {
        return [MenuSection(title: "Products", menus: [.product, .listProduct, .collectionProduct]),
                MenuSection(title: "Repos", menus: [.repos, .repoCollection, .repoCarousel]),
                MenuSection(title: "Others", menus: [.login, .users])]
    }
}

extension MainMenuViewModel {
    enum Menu: Int {
        case product
        case listProduct
        case collectionProduct
        case repos
        case repoCollection
        case repoCarousel
        case users
        case login
        
        
        var strDescription: String {
            switch self {
            case .product:
                return "product"
            case .listProduct:
                return "list products"
            case .collectionProduct:
                return "collect products"
            case .repos:
                return "repo"
            case .repoCollection:
                return "repo collect"
            case .repoCarousel:
                return "repo carousel"
            case .users:
                return "users"
            case .login:
                return "login"
            }
        }
    }
    
    struct MenuSection {
        var title: String
        var menus: [Menu]
    }
}



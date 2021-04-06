//
//  AppViewModel.swift
//  DemoCleanProductList
//
//  Created by DiemMy Le on 4/4/21.
//  Copyright © 2021 DiemMy Le. All rights reserved.
//

import UIKit
import MGArchitecture
import RxSwift
import RxCocoa

struct AppViewModel {
    var navigator: AppNavigatorProtocol
    var usecase: AppUsecaseProtocol
}

extension AppViewModel: ViewModel {
    
    struct Input {
        var load: Driver<Void>
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.load.drive(onNext: { (_) in
            self.navigator.toMain()
            }).disposed(by: disposeBag)
        
        return output
    }
}



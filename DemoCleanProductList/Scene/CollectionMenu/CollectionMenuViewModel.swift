//
//  CollectionMenuViewModel.swift
//  DemoCleanProductList
//
//  Created by DiemMy Le on 4/7/21.
//  Copyright © 2021 DiemMy Le. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MGArchitecture

struct CollectionMenuViewModel {
    //usecase, navigator
    var navigator: CollectionMenuNavigatorProtocol
    var usecase: CollectionMenuUseCaseProtocol
}
extension CollectionMenuViewModel: ViewModel {
    
    struct Input { //actions
        let load: Driver<Void>
        let selectionItemCollection: Driver<IndexPath>
    }
    
    struct Output { //data
        @Property var collectionColor = [ColorPicker]()
    }
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        //input
        input.load.map({
            self.initColorCollection()
        }).drive(output.$collectionColor).disposed(by: disposeBag)
        
        input.selectionItemCollection.map { (indexpath) in
            output.collectionColor[indexpath.row]
        }.drive(onNext: { (color) in
            debugPrint("select \(color)")
        }).disposed(by: disposeBag)
        
        return output
    }
}


extension CollectionMenuViewModel {
    struct ColorPicker {
        var hexValue: String
    }
    
    func initColorCollection() -> [ColorPicker] {
        let arr = [ColorPicker(hexValue: "bad5ff"),
                   ColorPicker(hexValue: "d1fffd"),
                   ColorPicker(hexValue: "f2cef2"),
                   ColorPicker(hexValue: "6aab2e"),
                   ColorPicker(hexValue: "fcffe6"),
                   ColorPicker(hexValue: "d66da3"),
                   ColorPicker(hexValue: "82e0d7"),
                   ColorPicker(hexValue: "b797fc")]
        
        return arr
    }
}

//
//  Assembler.swift
//  DemoCleanProductList
//
//  Created by DiemMy Le on 4/4/21.
//  Copyright © 2021 DiemMy Le. All rights reserved.
//

import UIKit

protocol Assembler: class,
                    MainMenuAssembler,
                    AppAssembler,
                    CollectionMenuAssembler {
    
}

final class DefaultAssembler: Assembler {
    
}



//MARK: GatewayAssembler --- gate between DOMAIN and DATA

protocol GatewayAssembler {
    
}

//
//  MainMenuViewController.swift
//  DemoCleanProductList
//
//  Created by DiemMy Le on 4/4/21.
//  Copyright © 2021 DiemMy Le. All rights reserved.
//

import UIKit
import MGArchitecture
import RxSwift
import RxCocoa
import Then
import Reusable

class MainMenuViewController: UIViewController, Bindable {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MainMenuViewModel!
    var disposeBag = DisposeBag()
    var menuSections = [ViewModel.MenuSection]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //config tableView
        tableView.do {
            $0.register(cellType: MainMenuCell.self)
            $0.delegate = self
            $0.dataSource = self
            $0.rowHeight = 70
        }
        
        self.title = "Menu"
    }
    
    func bindViewModel() {
        let input = MainMenuViewModel.Input(load: Driver.just(()), seclectMenu: tableView.rx.itemSelected.asDriver())
        
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.$menuSections.asDriver().drive(onNext: { (menuSections) in
            self.menuSections = menuSections
            self.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
}

extension MainMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuSections[section].menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MainMenuCell.self).then { (cellItem) in
            cellItem.lbMenuTitle.text = menuSections[indexPath.section].menus[indexPath.row].strDescription
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menuSections[section].title
    }
}

extension MainMenuViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}

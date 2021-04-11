//
//  CollectionMenuViewController.swift
//  DemoCleanProductList
//
//  Created by DiemMy Le on 4/7/21.
//  Copyright © 2021 DiemMy Le. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import MGArchitecture
import Reusable

class CollectionMenuViewController: UIViewController, Bindable {
   
    @IBOutlet weak var collectionViewColor: UICollectionView!
    
    //viewmodel
    var viewModel: CollectionMenuViewModel!
    var arrColor = [CollectionMenuViewModel.ColorPicker]()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.title = "Color"
    }
    
    func setUpView() {
        let layout = UICollectionViewFlowLayout()
        collectionViewColor.do({
            $0.collectionViewLayout = layout
            $0.register(cellType: CollectionViewCell.self)
            $0.delegate = self
            $0.dataSource = self
        })
    }
    
    func bindViewModel() {
        let input = CollectionMenuViewModel.Input(load: Driver.just(()), selectionItemCollection: collectionViewColor.rx.itemSelected.asDriver())
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        //transform output to UI
        output.$collectionColor.asDriver().drive(onNext: { (arrColor) in
            self.arrColor = arrColor
            self.collectionViewColor.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension CollectionMenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let colorPicker = arrColor[indexPath.row]
        debugPrint("\(colorPicker.hexValue)")
    }
}

extension CollectionMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrColor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let colorPicker = arrColor[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CollectionViewCell.self)
        cell.lbCollectionTitle.text = "#\(colorPicker.hexValue)"
        cell.lbCollectionTitle.backgroundColor = UIColor(hex: "#\(colorPicker.hexValue)")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width/4, height: 50)
    }
    
}

extension CollectionMenuViewController: UICollectionViewDelegateFlowLayout {
    
}

extension CollectionMenuViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.colorPicker
}

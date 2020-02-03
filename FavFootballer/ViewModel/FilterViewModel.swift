//
//  FilterViewModel.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/12/22.
//  Copyright © 2019 Tomoaki Tashiro. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class FilterViewModel {
    
    private let readJson: ReadJson!
    private var disposeBag = DisposeBag()

    let filterConditions = BehaviorRelay<[String : String]>(value: [:])
    let nationList = BehaviorRelay<[String]>(value: [""])
    let clubList = BehaviorRelay<[String]>(value: [""])
    let isError = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Initializer
    
    init(dataBase: ReadJson) {
        readJson = dataBase
    }
    
    // MARK: - Function
    
    /// 入力された検索条件をセット
    ///
    /// - Parameters:
    ///   - filterCriteria: 選手リストのフィルタ条件
    ///
    func setFilterConditions(_ conditions: [String : String]) {
        
        var setFilterConditions = self.filterConditions.value
        setFilterConditions.updateValue(conditions.values.first!, forKey: Array(conditions.keys).first!)
        self.filterConditions.accept(setFilterConditions)
    }
    
    /// 入力されたフィルタ条件をセット
    ///
    /// - Parameters:
    ///   - filterCriteria: 選手リストのフィルタ条件
    ///
    func resetFilterConditions() {
        
        filterConditions.accept([:])
    }
    
    /// 国リストを取得
    ///
    func getNationList() {

        readJson.getNationList().subscribe(
            // 国リストの取得成功
            onSuccess: { nationList in
                self.isError.accept(false)
                for nation in nationList {
                    self.nationList.accept(self.nationList.value + [nation.nationName])
                }
            },
            // 国リストの取得失敗
            onError: { (error) in
                self.isError.accept(true)
                print("Error: ", error.localizedDescription)
            }
        ).disposed(by: disposeBag)
    }
    
    /// クラブリストを取得
    ///
    func getClubList() {

        readJson.getClubList().subscribe(
            // クラブリストの取得成功
            onSuccess: { clubList in
                self.isError.accept(false)
                for club in clubList {
                    self.clubList.accept(self.clubList.value + [club.clubName])
                }
            },
            // クラブリストの取得失敗
            onError: { (error) in
                self.isError.accept(true)
                print("Error: ", error.localizedDescription)
            }
        ).disposed(by: disposeBag)
    }

}


//
//  ListViewModel.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/09/02.
//  Copyright © 2019年 Tomoaki Tashiro. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ListViewModel {
    
    private let firestoreDb: FirestoreDb!
    private var disposeBag = DisposeBag()

    let playerList = BehaviorRelay<[Player]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)
    let isEmpty = BehaviorRelay<Bool>(value: false)
    let isError = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Initializer
    
    init(dataBase: FirestoreDb) {
        firestoreDb = dataBase
    }
    
    // MARK: - Function
    
    /// 選手リストを取得
    ///
    /// - Parameters:
    ///   - filterConditions: 選手リストのフィルタ条件
    ///
    func getPlayerList(_ filterConditions: [String : String]) {
        
        self.isLoading.accept(true)
        
        firestoreDb.getPlayerList(filterConditions).subscribe(
            // 選手リストの取得成功
            onSuccess: { playerList in
                self.isLoading.accept(false)
                self.isError.accept(false)
                if playerList.isEmpty {
                    self.isEmpty.accept(true)
                } else {
                    self.isEmpty.accept(false)
                    self.playerList.accept(playerList)
                }
            },
            // 選手リストの取得失敗
            onError: { (error) in
                self.isLoading.accept(false)
                self.isError.accept(true)
                print("Error: ", error.localizedDescription)
            }
        ).disposed(by: disposeBag)
    }
        
}

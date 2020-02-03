//
//  DetailViewModel.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/12/07.
//  Copyright © 2019 Tomoaki Tashiro. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel {
    
    private let realmDb: RealmDb!
    private var disposeBag = DisposeBag()

    let favoritePlayerList = BehaviorRelay<[FavoritePlayer]>(value: [])
    let isExists = BehaviorRelay<Bool>(value: false)
    let isError = BehaviorRelay<Bool>(value: false)
    let count = BehaviorRelay<Int>(value: 0)
    
    // MARK: - Initializer
    
    init(dataBase: RealmDb) {
        realmDb = dataBase
    }
    
    // MARK: - Function
        
    /// お気に入り選手を登録
    ///
    /// - Parameters:
    ///   - player: 選手データ
    ///
    func addFavoritePlayer(_ player: Player) {

        realmDb.addFavoritePlayer(player).subscribe(
            // お気に入り選手の登録成功
            onCompleted: {
                self.isError.accept(false)
            },
            
            // お気に入り選手の登録失敗
            onError: { (error) in
                self.isError.accept(true)
                print("Error: ", error.localizedDescription)
            }
        ).disposed(by: disposeBag)
    }
    
    /// お気に入り選手を削除
    ///
    /// - Parameters:
    ///   - player: 選手データ
    ///
    func deleteFavoritePlayer(_ player: Player) {
 
        realmDb.deleteFavoritePlayer(player).subscribe(
            // お気に入り選手の削除成功
            onCompleted: {
                self.isError.accept(false)
            },
            
            // お気に入り選手の削除失敗
            onError: { (error) in
                self.isError.accept(true)
                print("Error: ", error.localizedDescription)
            }
        ).disposed(by: disposeBag)
    }
    
    /// お気に入りに登録されている選手か確認
    ///
    /// - Parameters:
    ///   - player: 選手データ
    ///
    func isExistsFavoritePlayer(_ player: Player) {
        
        realmDb.isExistsFavoritePlayer(player).subscribe(
            // お気に入り状態の取得成功
            onSuccess: { isExists in
                self.isError.accept(false)
                self.isExists.accept(isExists)
            },
            // お気に入り状態の取得失敗
            onError: { (error) in
                self.isError.accept(true)
                print("Error: ", error.localizedDescription)
            }
        ).disposed(by: disposeBag)
    }
    
    /// お気に入り登録選手数を取得
    ///
    func getFavoritePlayerCount() {
        
        realmDb.getFavoritePlayerCount().subscribe(
            // お気に入り登録選手数の取得成功
            onSuccess: { count in
                self.isError.accept(false)
                self.count.accept(count)
            },
            // お気に入り登録選手数の取得失敗
            onError: { (error) in
                self.isError.accept(true)
                print("Error: ", error.localizedDescription)
            }
        ).disposed(by: disposeBag)
    }
    
}

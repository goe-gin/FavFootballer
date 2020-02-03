//
//  FavoriteViewModel.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/12/16.
//  Copyright © 2019 Tomoaki Tashiro. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class FavoriteViewModel {
    
    private let realmDb: RealmDb!
    private var disposeBag = DisposeBag()

    let favoritePlayerList = BehaviorRelay<[Player]>(value: [])
    let isError = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Initializer
    
    init(dataBase: RealmDb) {
        realmDb = dataBase
    }
    
    // MARK: - Function
    
    /// 全てのお気に入り登録選手を取得
    ///
    func getFavoritePlayerObject() -> Results<FavoritePlayer> {
        
        return realmDb.getFavoritePlayerObject()
    }
    
   /// 指定番号のお気に入り選手を削除
   ///
   /// - Parameters:
   ///   - player: 選手データ
   ///
   func deleteFavoritePlayerForRow(_ row: Int) {

       realmDb.deleteFavoritePlayerForRow(row).subscribe(
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
    
    /// FavoritePlayerToPlayer型をPlayer型に変換
    ///
    func convertFavoritePlayerToPlayer(_ favoritePlayer: FavoritePlayer) -> Player {
        
        var position: [String] = []

        for favoritePlayerPosition in favoritePlayer.position {
            position.append(favoritePlayerPosition.position)
        }
        
        var trait: [String] = []

        for favoritePlayerTrait in favoritePlayer.trait {
            trait.append(favoritePlayerTrait.trait)
        }
        
        var speciality: [String] = []

        for favoritePlayerSpeciality in favoritePlayer.speciality {
            speciality.append(favoritePlayerSpeciality.speciality)
        }
        
        let player = Player(
            version: favoritePlayer.version,
            playerId: favoritePlayer.playerId,
            name: favoritePlayer.name,
            nationId: favoritePlayer.nationId,
            nationName: favoritePlayer.nationName,
            position: position,
            fullName: favoritePlayer.fullName,
            age: favoritePlayer.age,
            height: favoritePlayer.height,
            weight: favoritePlayer.weight,
            overallRating: favoritePlayer.overallRating,
            potential: favoritePlayer.potential,
            preferredFoot: favoritePlayer.preferredFoot,
            weakFoot: favoritePlayer.weakFoot,
            skillMoves: favoritePlayer.skillMoves,
            attackingWorkRate: favoritePlayer.attackingWorkRate,
            defensiveWorkRate: favoritePlayer.defensiveWorkRate,
            realFace: favoritePlayer.realFace,
            clubId: favoritePlayer.clubId,
            clubName: favoritePlayer.clubName,
            loanedFrom: favoritePlayer.loanedFrom,
            contract: favoritePlayer.contract,
            speciality: speciality,
            crossing: favoritePlayer.crossing,
            finishing: favoritePlayer.finishing,
            headingAccuracy: favoritePlayer.headingAccuracy,
            shortPassing: favoritePlayer.shortPassing,
            volleys: favoritePlayer.volleys,
            dribbling: favoritePlayer.dribbling,
            curve: favoritePlayer.curve,
            fkAccuracy: favoritePlayer.fkAccuracy,
            longPassing: favoritePlayer.longPassing,
            ballControl: favoritePlayer.ballControl,
            acceleration: favoritePlayer.acceleration,
            sprintSpeed: favoritePlayer.sprintSpeed,
            agility: favoritePlayer.agility,
            reactions: favoritePlayer.reactions,
            balance: favoritePlayer.balance,
            shotPower: favoritePlayer.shotPower,
            jumping: favoritePlayer.jumping,
            stamina: favoritePlayer.stamina,
            strength: favoritePlayer.strength,
            longShots: favoritePlayer.longShots,
            trait: trait,
            aggression: favoritePlayer.aggression,
            interceptions: favoritePlayer.interceptions,
            positioning: favoritePlayer.positioning,
            vision: favoritePlayer.vision,
            penalties: favoritePlayer.penalties,
            composure: favoritePlayer.composure,
            marking: favoritePlayer.marking,
            standingTackle: favoritePlayer.standingTackle,
            slidingTackle: favoritePlayer.slidingTackle,
            gkDiving: favoritePlayer.gkDiving,
            gkHandling: favoritePlayer.gkHandling,
            gkKicking: favoritePlayer.gkKicking,
            gkPositioning: favoritePlayer.gkPositioning,
            gkReflexes: favoritePlayer.gkReflexes,
            faceImageURL: favoritePlayer.faceImageURL,
            nationImageURL: favoritePlayer.nationImageURL,
            clubImageURL: favoritePlayer.clubImageURL
        )
        return player
    }
    
}


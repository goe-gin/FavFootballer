//
//  RealmDb.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/12/07.
//  Copyright © 2019 Tomoaki Tashiro. All rights reserved.
//

import RealmSwift
import RxSwift
import RxCocoa
import RxRealm

class RealmDb {
    
    var favoritePlayerList: [Player] = []
    
    /// Realmに登録されている全ての選手を取得
    ///
    /// - Returns: Disposables.create()
    ///
    func getFavoritePlayerObject() -> Results<FavoritePlayer> {
        
        let realm = try! Realm()
        
        return realm.objects(FavoritePlayer.self).sorted(byKeyPath: "overallRating", ascending: false)
    }

    /// Realmにお気に入り選手を登録
    ///
    /// - Returns: Disposables.create()
    ///
    func addFavoritePlayer(_ player: Player) -> Completable {
        
        return Completable.create(subscribe: { completable in
            do {
                var position: [[String: String]] = []

                for value in player.position {
                    position.append(["position": value])
                }
                
                var trait: [[String: String]] = []

                for value in player.trait {
                    trait.append(["trait": value])
                }
                
                var speciality: [[String: String]] = []

                for value in player.speciality {
                    speciality.append(["speciality": value])
                }
                
                let realm = try Realm()
                try realm.write {
                    realm.add(FavoritePlayer(value:
                        [
                            "version": player.version,
                            "playerId": player.playerId,
                            "name": player.name,
                            "nationId": player.nationId,
                            "nationName": player.nationName,
                            "fullName": player.fullName,
                            "age": player.age,
                            "height": player.height,
                            "weight": player.weight,
                            "overallRating": player.overallRating,
                            "potential": player.potential,
                            "preferredFoot": player.preferredFoot,
                            "weakFoot": player.weakFoot,
                            "skillMoves": player.skillMoves,
                            "attackingWorkRate": player.attackingWorkRate,
                            "defensiveWorkRate": player.defensiveWorkRate,
                            "realFace": player.realFace,
                            "clubId": player.clubId,
                            "clubName": player.clubName,
                            "loanedFrom": player.loanedFrom ?? "",
                            "contract": player.contract,
                            "crossing": player.crossing,
                            "finishing": player.finishing,
                            "headingAccuracy": player.headingAccuracy,
                            "shortPassing": player.shortPassing,
                            "volleys": player.volleys,
                            "dribbling": player.dribbling,
                            "curve": player.curve,
                            "fkAccuracy": player.fkAccuracy,
                            "longPassing": player.longPassing,
                            "ballControl": player.ballControl,
                            "acceleration": player.acceleration,
                            "sprintSpeed": player.sprintSpeed,
                            "agility": player.agility,
                            "reactions": player.reactions,
                            "balance": player.balance,
                            "shotPower": player.shotPower,
                            "jumping": player.jumping,
                            "stamina": player.stamina,
                            "strength": player.strength,
                            "longShots": player.longShots,
                            "aggression": player.aggression,
                            "interceptions": player.interceptions,
                            "positioning": player.positioning,
                            "vision": player.vision,
                            "penalties": player.penalties,
                            "composure": player.composure,
                            "marking": player.marking,
                            "standingTackle": player.standingTackle,
                            "slidingTackle": player.slidingTackle,
                            "gkDiving": player.gkDiving,
                            "gkHandling": player.gkHandling,
                            "gkKicking": player.gkKicking,
                            "gkPositioning": player.gkPositioning,
                            "gkReflexes": player.gkReflexes,
                            "faceImageURL": player.faceImageURL,
                            "nationImageURL": player.nationImageURL,
                            "clubImageURL": player.clubImageURL,
                            "position": position,
                            "trait": trait,
                            "speciality": speciality
                        ]
                    ))
                }
                completable(.completed)
                
            } catch {
                
                completable(.error(error))
            }
            
            return Disposables.create()
        })
    }
    
    /// Realmのお気に入り選手を削除
    ///
    /// - Returns: Disposables.create()
    ///
    func deleteFavoritePlayer(_ player: Player) -> Completable {
        
        return Completable.create(subscribe: { completable in
            do {
                let realm = try Realm()
                let result = realm.objects(FavoritePlayer.self)
                    .filter("version == %@ && playerId == %@", player.version, player.playerId)

                try realm.write {
                    realm.delete(result)
                }
                completable(.completed)

            } catch {
                
                completable(.error(error))
            }
            
            return Disposables.create()
       })
    }
    
    /// Realmの指定番号のお気に入り選手を削除
    ///
    /// - Returns: Disposables.create()
    ///
    func deleteFavoritePlayerForRow(_ row: Int) -> Completable {
        
        return Completable.create(subscribe: { completable in
            do {
                let realm = try Realm()
                let result = realm.objects(FavoritePlayer.self).sorted(byKeyPath: "overallRating", ascending: false)
                var deleteRecord: FavoritePlayer!
                
                for (index, record) in result.enumerated() {
                    if (row == index) {
                        
                        deleteRecord = record
                        break
                    }
                }
                    
                try realm.write {
                    realm.delete(deleteRecord)
                }
                completable(.completed)

            } catch {
                
                completable(.error(error))
            }
            
            return Disposables.create()
       })
    }
    
    /// Realmに登録されている選手か確認
    ///
    /// - Parameters:
    ///   - player: 選手データ
    ///
    /// - Returns: Disposables.create()
    ///
    func isExistsFavoritePlayer(_ player: Player) -> Single<Bool> {
        
        return Single.create(subscribe: { single in
            do {
                let realm = try Realm()
                if realm.objects(FavoritePlayer.self)
                    .filter("version == %@ && playerId == %@", player.version, player.playerId).first != nil {
                    
                    single(.success(true))
                } else {
                    
                    single(.success(false))
                }
            } catch {
                
                single(.error(error))
            }
            
            return Disposables.create()
       })
    }
    
    /// Realmに登録されている選手数を取得
    ///
    /// - Returns: Disposables.create()
    ///
    func getFavoritePlayerCount() -> Single<Int> {
        
        return Single.create(subscribe: { single in
            do {
                let realm = try Realm()
                let count = realm.objects(FavoritePlayer.self).count
                
                single(.success(count))
            } catch {
                
                single(.error(error))
            }
            
            return Disposables.create()
       })
    }
    
}

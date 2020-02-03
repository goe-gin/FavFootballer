//
//  FirestoreDb.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/10/31.
//  Copyright © 2019 Tomoaki Tashiro. All rights reserved.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import RxSwift
import RxCocoa

class FirestoreDb {
    
    var playerList: [Player] = []
    
    /// FireStoreから選手リストを取得
    ///
    /// - Parameters:
    ///   - filterCriteria: 選手リストのフィルタ条件
    ///
    /// - Returns: Disposables.create()
    ///
    func getPlayerList(_ filterConditions: [String : String]) -> Single<[Player]> {
        
        return Single<[Player]>.create(subscribe: { single in

            var collection = Constant.versionList[1]
            var rangeStatus = Constant.defaultRangeStatus
            var rangeMin = Constant.defaultRangeMin
            var rangeMax = Constant.defaultRangeMax
            
            if let version = filterConditions["version"] {
                if !version.isEmpty {
                    collection = version
                }
            }
            
            var playersRef: Query = Firestore.firestore().collection(collection)

            if (!filterConditions.isEmpty) {
                
                for (filterCondition, value) in filterConditions {
                    
                    switch filterCondition {
                    case "rangeStatus":
                        if (!value.isEmpty && value == "Potential") {
                            rangeStatus = "potential"
                        }
                    case "rangeMin":
                        if (!value.isEmpty) {
                            rangeMin = Int(value)!
                        }
                    case "rangeMax":
                        if (!value.isEmpty) {
                            rangeMax = Int(value)!
                        }
                    case "age":
                        if (!value.isEmpty) {
                            playersRef = playersRef.whereField("age", isEqualTo: Int(value)!)
                        }
                    case "nation":
                        if (!value.isEmpty) {
                            playersRef = playersRef.whereField("nation_name", isEqualTo: value)
                        }
                    case "club":
                        if (!value.isEmpty) {
                            playersRef = playersRef.whereField("club_name", isEqualTo: value)
                        }
                    case "position":
                        if (!value.isEmpty) {
                            playersRef = playersRef.whereField("position", arrayContains: value)
                        }
                    case "preferredFoot":
                        if (!value.isEmpty) {
                            playersRef = playersRef.whereField("preferred_foot", isEqualTo: value)
                        }
                    case "weakFoot":
                        if (!value.isEmpty) {
                            playersRef = playersRef.whereField("weak_foot", isEqualTo: Int(value)!)
                        }
                    case "skillMoves":
                        if (!value.isEmpty) {
                            playersRef = playersRef.whereField("skill_moves", isEqualTo: Int(value)!)
                        }
                    case "attackingWorkRate":
                        if (!value.isEmpty) {
                            playersRef = playersRef.whereField("attacking_work_rate", isEqualTo: value)
                        }
                    case "defensiveWorkRate":
                        if (!value.isEmpty) {
                            playersRef = playersRef.whereField("defensive_work_rate", isEqualTo: value)
                        }
                    case "realFace":
                        if (!value.isEmpty) {
                            playersRef = playersRef.whereField("real_face", isEqualTo: value)
                        }
                    default: break
                        
                    }
                }
            }
            
            playersRef = playersRef.whereField(rangeStatus, isGreaterThanOrEqualTo: rangeMin).whereField(rangeStatus, isLessThanOrEqualTo: rangeMax).order(by: rangeStatus, descending: true).limit(to: 100)
                        
            playersRef.getDocuments() { (querySnapshot, error) in
                if let error = error {
                    single(.error(error))
                    return
                }
                self.playerList = []
                for document in querySnapshot!.documents {
                    if let player = try? Firestore.Decoder().decode(Player.self, from: document.data()) {
                        
                        self.playerList.append(player)
                    }
                }
                
                single(.success(self.playerList))
            }
            return Disposables.create()
        })
    }

}

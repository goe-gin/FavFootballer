//
//  PlayerRealm.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/12/06.
//  Copyright © 2019 Tomoaki Tashiro. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - FavoritePlayer

/// お気に入り選手モデル
///
class FavoritePlayer: Object {
    
    @objc dynamic var playerId = 0
    @objc dynamic var version = ""
    @objc dynamic var name = ""
    @objc dynamic var nationId = 0
    @objc dynamic var nationName = ""
    @objc dynamic var fullName = ""
    @objc dynamic var age = 0
    @objc dynamic var height = 0
    @objc dynamic var weight = 0
    @objc dynamic var overallRating = 0
    @objc dynamic var potential = 0
    @objc dynamic var preferredFoot = ""
    @objc dynamic var weakFoot = 0
    @objc dynamic var skillMoves = 0
    @objc dynamic var attackingWorkRate = ""
    @objc dynamic var defensiveWorkRate = ""
    @objc dynamic var realFace = ""
    @objc dynamic var clubId = 0
    @objc dynamic var clubName = ""
    @objc dynamic var loanedFrom = ""
    @objc dynamic var contract = ""
    @objc dynamic var crossing = 0
    @objc dynamic var finishing = 0
    @objc dynamic var headingAccuracy = 0
    @objc dynamic var shortPassing = 0
    @objc dynamic var volleys = 0
    @objc dynamic var dribbling = 0
    @objc dynamic var curve = 0
    @objc dynamic var fkAccuracy = 0
    @objc dynamic var longPassing = 0
    @objc dynamic var ballControl = 0
    @objc dynamic var acceleration = 0
    @objc dynamic var sprintSpeed = 0
    @objc dynamic var agility = 0
    @objc dynamic var reactions = 0
    @objc dynamic var balance = 0
    @objc dynamic var shotPower = 0
    @objc dynamic var jumping = 0
    @objc dynamic var stamina = 0
    @objc dynamic var strength = 0
    @objc dynamic var longShots = 0
    @objc dynamic var aggression = 0
    @objc dynamic var interceptions = 0
    @objc dynamic var positioning = 0
    @objc dynamic var vision = 0
    @objc dynamic var penalties = 0
    @objc dynamic var composure = 0
    @objc dynamic var marking = 0
    @objc dynamic var standingTackle = 0
    @objc dynamic var slidingTackle = 0
    @objc dynamic var gkDiving = 0
    @objc dynamic var gkHandling = 0
    @objc dynamic var gkKicking = 0
    @objc dynamic var gkPositioning = 0
    @objc dynamic var gkReflexes = 0
    @objc dynamic var faceImageURL = ""
    @objc dynamic var nationImageURL = ""
    @objc dynamic var clubImageURL = ""
    let position = List<FavoritePlayerPosition>()
    let speciality = List<FavoritePlayerSpeciality>()
    let trait = List<FavoritePlayerTrait>()
}

class FavoritePlayerPosition: Object {
    
    @objc dynamic var position: String = ""
}

class FavoritePlayerSpeciality: Object {
    
    @objc dynamic var speciality: String = ""
}

class FavoritePlayerTrait: Object {
    
    @objc dynamic var trait: String = ""
}

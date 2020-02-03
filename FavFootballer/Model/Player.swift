//
//  PlayerModel.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/09/02.
//  Copyright © 2019年 Tomoaki Tashiro. All rights reserved.
//

import Foundation

// MARK: - Player

/// 選手モデル
///
struct Player: Codable {
    let version: String
    let playerId: Int
    let name: String
    let nationId: Int
    let nationName: String
    let position: [String]
    let fullName: String
    let age, height, weight, overallRating: Int
    let potential: Int
    let preferredFoot: String
    let weakFoot, skillMoves: Int
    let attackingWorkRate, defensiveWorkRate, realFace: String
    let clubId: Int
    let clubName: String
    let loanedFrom: String?
    let contract: String
    let speciality: [String]
    let crossing, finishing, headingAccuracy, shortPassing: Int
    let volleys, dribbling, curve, fkAccuracy: Int
    let longPassing, ballControl, acceleration, sprintSpeed: Int
    let agility, reactions, balance, shotPower: Int
    let jumping, stamina, strength, longShots: Int
    let trait: [String]
    let aggression, interceptions, positioning, vision: Int
    let penalties, composure, marking, standingTackle: Int
    let slidingTackle, gkDiving, gkHandling, gkKicking: Int
    let gkPositioning, gkReflexes: Int
    let faceImageURL, nationImageURL, clubImageURL: String

    enum CodingKeys: String, CodingKey {
        case version
        case playerId = "player_id"
        case name
        case nationId = "nation_id"
        case nationName = "nation_name"
        case position
        case fullName = "full_name"
        case age, height, weight
        case overallRating = "overall_rating"
        case potential
        case preferredFoot = "preferred_foot"
        case weakFoot = "weak_foot"
        case skillMoves = "skill_moves"
        case attackingWorkRate = "attacking_work_rate"
        case defensiveWorkRate = "defensive_work_rate"
        case realFace = "real_face"
        case clubId = "club_id"
        case clubName = "club_name"
        case loanedFrom = "loaned_from"
        case contract, speciality, crossing, finishing
        case headingAccuracy = "heading_accuracy"
        case shortPassing = "short_passing"
        case volleys, dribbling, curve
        case fkAccuracy = "fk_accuracy"
        case longPassing = "long_passing"
        case ballControl = "ball_control"
        case acceleration
        case sprintSpeed = "sprint_speed"
        case agility, reactions, balance
        case shotPower = "shot_power"
        case jumping, stamina, strength
        case longShots = "long_shots"
        case trait, aggression, interceptions, positioning, vision, penalties, composure
        case marking = "defensive"
        case standingTackle = "standing_tackle"
        case slidingTackle = "sliding_tackle"
        case gkDiving = "gk_diving"
        case gkHandling = "gk_handling"
        case gkKicking = "gk_kicking"
        case gkPositioning = "gk_positioning"
        case gkReflexes = "gk_reflexes"
        case faceImageURL = "face_image_url"
        case nationImageURL = "nation_image_url"
        case clubImageURL = "club_image_url"
    }
}

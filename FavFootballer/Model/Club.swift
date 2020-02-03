//
//  Club.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/10/31.
//  Copyright © 2019 Tomoaki Tashiro. All rights reserved.
//

import Foundation

// MARK: - Club

/// クラブモデル
///
struct Club: Codable {
    let clubId: Int
    let clubName, clubImageURL: String

    enum CodingKeys: String, CodingKey {
        case clubId = "club_id"
        case clubName = "club_name"
        case clubImageURL = "club_image_url"
    }
}

//
//  Nation.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/10/31.
//  Copyright © 2019 Tomoaki Tashiro. All rights reserved.
//

import Foundation

// MARK: - Nation

/// 国モデル
///
struct Nation: Codable {
    let nationId: Int
    let nationName, nationImageURL: String

    enum CodingKeys: String, CodingKey {
        case nationId = "nation_id"
        case nationName = "nation_name"
        case nationImageURL = "nation_image_url"
    }
}

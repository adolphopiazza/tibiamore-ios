//
//  KillStatisticsModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 20/01/24.
//

import Foundation

struct KillStatisticsModel: Decodable, Hashable {
    let killstatistics: KillStatisticsInfoModel
}

struct KillStatisticsInfoModel: Decodable, Hashable {
    let entries: [KillStatisticsDataModel]
    let total: KillStatisticsDataModel
}

struct KillStatisticsDataModel: Decodable, Hashable {
    let lastDayKilled: Int
    let lastDayPlayersKilled: Int
    let lastWeekKilled: Int
    let lastWeekPlayersKilled: Int
    let race: String?
}


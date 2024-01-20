//
//  KillStatisticsModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 20/01/24.
//

import Foundation

struct KillStatisticsModel: Decodable {
    let killstatistics: KillStatisticsInfoModel
}

struct KillStatisticsInfoModel: Decodable {
    let entries: [KillStatisticsDataModel]
    let total: KillStatisticsDataModel
}

struct KillStatisticsDataModel: Decodable {
    let lastDayKilled: Int
    let lastDayPlayersKilled: Int
    let lastWeekKilled: Int
    let lastWeekPlayersKilled: Int
    let race: String?
}


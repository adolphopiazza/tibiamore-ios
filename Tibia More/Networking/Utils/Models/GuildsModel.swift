//
//  GuildsModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 21/01/24.
//

import Foundation

// MARK: - All the guilds
struct GuildsModel: Decodable {
    let guilds: GuildsInfoModel
}

struct GuildsInfoModel: Decodable {
    let world: String
    let active: [ActiveGuildsModel]
}

struct ActiveGuildsModel: Decodable {
    let name: String
    let logo: String?
    let description: String
}

// MARK: - Specific Guild
struct SpecificGuildModel: Decodable {
    let guild: SpecificGuildInfoModel
}

struct SpecificGuildInfoModel: Decodable {
    let active: Bool
    let description: String
    let disbandCondition: String
    let disbandDate: String
    let founded: String
    let guildhalls: [GuildhallsModel]?
    let homepage: String
    let inWar: Bool
    let invites: [GuildInvitesModel]?
    let logoUrl: String
    let members: [GuildMembersModel]
    let membersInvited: Int
    let membersTotal: Int
    let name: String
    let openApplications: Bool
    let playersOffline: Int
    let playersOnline: Int
    let world: String
}

struct GuildhallsModel: Decodable {
    let name: String
    let paidUntil: String
    let world: String
}

struct GuildInvitesModel: Decodable {
    let date: String
    let name: String
}

struct GuildMembersModel: Decodable {
    let joined: String
    let level: Int
    let name: String
    let rank: String
    let status: String
    let title: String
    let vocation: String
}

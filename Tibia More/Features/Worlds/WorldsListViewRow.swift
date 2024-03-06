//
//  WorldsListViewRow.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 07/01/24.
//

import SwiftUI

struct WorldsListViewRow: View {
    
    var model: WorldModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .fill(setOnlineColor(status: model.status))
                    .frame(width: 10, height: 10)
                
                Text(model.name)
                    .font(.title)
                
                Spacer()
                
                if model.battleyeProtected {
                    Image(setReleaseIcon(status: model.battleyeDate))
                }
                
                Image(setWorld(location: model.location))
            }
            
            LabeledContent("Players Online", value: String(model.playersOnline))
            LabeledContent("PvP Type", value: model.pvpType)
            LabeledContent("Transfer", value: model.transferType)
            
            if model.battleyeProtected {
                LabeledContent("Battleye Date", value: model.battleyeDate.formatDate(with: .yyyyMMdd))
            }
            
            if model.premiumOnly {
                Text("Premium Only")
                    .padding(6)
                    .background {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(.orange)
                    }
                    .padding(.top, 4)
            }
        }
    }
    
}

// MARK: - Private functions
extension WorldsListViewRow {
    func setOnlineColor(status: String) -> Color {
        return status == "online" ? .green : .red
    }
    
    func setReleaseIcon(status: String) -> ImageResource {
        return status == "release" ? .battleyeRelease : .battleyeNotRelease
    }
    
    func setWorld(location: String) -> ImageResource {
        switch location {
        case "Europe":
            return .GB
        case "South America":
            return .BR
        default:
            return .US
        }
    }
}

#Preview {
    WorldsListViewRow(model: WorldModel(name: "Belobra",
                                       status: "online",
                                       playersOnline: 320,
                                       location: "South America",
                                       pvpType: "Retro Open PvP",
                                       premiumOnly: false,
                                       transferType: "regular",
                                       battleyeProtected: true,
                                       battleyeDate: "2018-05-05",
                                       gameWorldType: "",
                                       tournamentWorldType: ""))
}

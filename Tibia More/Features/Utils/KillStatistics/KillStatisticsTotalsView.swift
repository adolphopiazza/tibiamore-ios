//
//  KillStatisticsTotalsView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 20/01/24.
//

import SwiftUI

struct KillStatisticsTotalsView: View {
    
    let model: KillStatisticsDataModel
    
    var body: some View {
        LabeledContent("Last day killed by players", value: String(model.lastDayKilled ))
        LabeledContent("Last day players died", value: String(model.lastDayPlayersKilled ))
        LabeledContent("Last week killed by players", value: String(model.lastWeekKilled ))
        LabeledContent("Last week players died", value: String(model.lastWeekPlayersKilled ))
    }
}

#Preview {
    KillStatisticsTotalsView(model: KillStatisticsDataModel(lastDayKilled: 3213, lastDayPlayersKilled: 31, lastWeekKilled: 42323521, lastWeekPlayersKilled: 3, race: "rotworm"))
}

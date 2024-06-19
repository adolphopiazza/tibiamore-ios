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
        LabeledContent("Statistics.LastDayKilled", value: String(model.lastDayKilled ))
        LabeledContent("Statistics.LastDayDied", value: String(model.lastDayPlayersKilled ))
        LabeledContent("Statistics.LastWeekKilled", value: String(model.lastWeekKilled ))
        LabeledContent("Statistics.LastWeekDied", value: String(model.lastWeekPlayersKilled ))
    }
}

#Preview {
    KillStatisticsTotalsView(model: KillStatisticsDataModel(lastDayKilled: 3213, lastDayPlayersKilled: 31, lastWeekKilled: 42323521, lastWeekPlayersKilled: 3, race: "rotworm"))
}

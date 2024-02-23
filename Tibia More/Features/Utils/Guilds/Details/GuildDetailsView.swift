//
//  GuildDetailsView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 21/01/24.
//

import SwiftUI

struct GuildDetailsView: View {
    
    @State var viewModel: GuildDetailsViewModel
    
    var body: some View {
        Form {
            AsyncImage(url: URL(string: viewModel.guild?.logoUrl ?? "")) { image in
                HStack {
                    Spacer()
                    
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 100)
                    
                    Spacer()
                }
            } placeholder: {
                ProgressView()
            }
            
            if let description = viewModel.guild?.description, !description.isEmpty {
                DisclosureGroup("Description") {
                    Text(description)
                }
            }

            Section("About") {
                // create a more generic view row later!
                WorldsDetailsViewRow("Founded", value: viewModel.guild?.founded.formatDate(with: .yyyyMMdd))
                WorldsDetailsViewRow("Active", value: viewModel.guild?.active ?? false ? "✅" : "🚫")
                WorldsDetailsViewRow("Applications Open", value: viewModel.guild?.openApplications ?? false ? "✅" : "🚫")
                WorldsDetailsViewRow("In War", value: viewModel.guild?.inWar ?? false ? "✅" : "🚫")
                WorldsDetailsViewRow("Players Online", value: String(viewModel.guild?.playersOnline ?? 0))
                WorldsDetailsViewRow("Players Offline", value: String(viewModel.guild?.playersOffline ?? 0))
                WorldsDetailsViewRow("Total of Members", value: String(viewModel.guild?.membersTotal ?? 0))
                WorldsDetailsViewRow("Invited", value: String(viewModel.guild?.membersInvited ?? 0))
            }
            
            if let guildhalls = viewModel.guild?.guildhalls {
                Section("Guildhalls") {
                    ForEach(guildhalls, id: \.name) { guildhall in
                        VStack(alignment: .leading) {
                            Text(guildhall.name)
                                .font(.title2)
                            
                            WorldsDetailsViewRow("World", value: guildhall.world)
                            WorldsDetailsViewRow("Paid Until", value: guildhall.paidUntil.formatDate(with: .yyyyMMdd))
                        }
                    }
                }
            }
            
            if let invitedMembers = viewModel.guild?.invites {
                Section("Invited Members") {
                    ForEach(invitedMembers, id: \.name) { invite in
                        VStack(alignment: .leading) {
                            WorldsDetailsViewRow("Name", value: invite.name)
                            WorldsDetailsViewRow("Date", value: invite.date.formatDate(with: .yyyyMMdd))
                        }
                    }
                }
            }
        }
        .fontDesign(.serif)
        .opacity(viewModel.opacity)
        .navigationTitle(viewModel.guild?.name ?? "")
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
            
            if viewModel.hasError && !viewModel.isLoading {
                ContentUnavailableView("Sorry, we got an error",
                                       systemImage: .SFImages.networkSlash)
            }
        }
    }
    
}

#Preview {
    NavigationStack {
        GuildDetailsView(viewModel: GuildDetailsViewModel(name: "Elysium"))
    }
}

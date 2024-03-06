//
//  FansitesDetailView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 20/01/24.
//

import SwiftUI

struct FansitesDetailView: View {
    
    @Binding var navigationPath: NavigationPath
    
    let model: FansiteModel
    
    var body: some View {
        Form {
            headerView
                .contentShape(.rect)
                .onTapGesture {
                    self.navigationPath.append(NavigationRoutes.Utils.Fansites.browser(with: model.homepage))
                }
            
            aboutView
            
            contentTypeView
            
            socialsView
        }
        .fontDesign(.serif)
        .navigationTitle(model.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Visit this website") {
                    self.navigationPath.append(NavigationRoutes.Utils.Fansites.browser(with: model.homepage))
                }
            }
        }
    }
    
    private var headerView: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                
                AsyncImage(url: URL(string: model.logoUrl)) { image in
                    image
                } placeholder: {
                    ProgressView()
                }
                
                
                Spacer()
            }
            
            Text(model.name)
                .font(.title)
                .padding(.top, 16)
        }
    }
    
    private var aboutView: some View {
        Section("About") {
            LabeledContent("Contact", value: model.contact)
            CharacterSearchDetailsViewRow(title: "Specials", value: model.specials.joined(separator: "\n"), orientation: .vertical)
            CharacterSearchDetailsViewRow(title: "Languages", value: model.languages.joined(separator: ", "))
            
            if model.fansiteItem {
                LabeledContent("Fansite Item") {
                    AsyncImage(url: URL(string: model.fansiteItemUrl)) { image in
                        image
                    } placeholder: {
                        ProgressView()
                    }
                    
                }
            }
        }
    }
    
    private var contentTypeView: some View {
        Section("Content Type") {
            LabeledContent("Statistics", value: model.contentType.statistics ? "✅" : "🚫")
            LabeledContent("Texts", value: model.contentType.texts ? "✅" : "🚫")
            LabeledContent("Tools", value: model.contentType.tools ? "✅" : "🚫")
            LabeledContent("Wiki", value: model.contentType.wiki ? "✅" : "🚫")
        }
    }
    
    private var socialsView: some View {
        Section("Socials") {
            LabeledContent("Discord", value: model.socialMedia.discord ? "✅" : "🚫")
            LabeledContent("Facebook", value: model.socialMedia.facebook ? "✅" : "🚫")
            LabeledContent("Instagram", value: model.socialMedia.instagram ? "✅" : "🚫")
            LabeledContent("Reddit", value: model.socialMedia.reddit ? "✅" : "🚫")
            LabeledContent("Twitch", value: model.socialMedia.twitch ? "✅" : "🚫")
            LabeledContent("X", value: model.socialMedia.twitter ? "✅" : "🚫")
            LabeledContent("Youtube", value: model.socialMedia.youtube ? "✅" : "🚫")
        }
    }
    
}

#Preview {
    FansitesDetailView(navigationPath: Binding.constant(NavigationPath()),
                       model: FansiteModel(contact: "Bomdrax",
                                           contentType: FansiteContentModel(statistics: false,
                                                                            texts: true,
                                                                            tools: false,
                                                                            wiki: false),
                                           fansiteItem: true,
                                           fansiteItemUrl: "https://static.tibia.com/images/community/fansiteitems/BomDiaTibia.com.gif",
                                           homepage: "https://www.bomdiatibia.com/",
                                           languages: ["pt"],
                                           logoUrl: "https://static.tibia.com/images/community/fansitelogos/BomDiaTibia.com.gif",
                                           name: "BomDiaTibia.com",
                                           socialMedia: FansiteSocialModel(discord: true,
                                                                           facebook: true,
                                                                           instagram: true,
                                                                           reddit: false,
                                                                           twitch: false,
                                                                           twitter: false,
                                                                           youtube: true),
                                           specials: ["Podcasts. Also on Spotify.", "Entertainment through contests and events."]))
}

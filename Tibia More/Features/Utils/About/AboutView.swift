//
//  AboutView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 08/02/24.
//

import SwiftUI

struct AboutView: View {
    
    private let viewModel: AboutViewModel = AboutViewModel()
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        Form {
            LabeledContent("About.Language") {
                Button {
                    Task {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            await UIApplication.shared.open(url)
                        }
                    }
                } label: {
                    Image(systemName: .SFImages.chevronRight)
                }

            }
            
            Section("App Info") {
                LabeledContent("Version", value: UIApplication.appVersion ?? "")
                LabeledContent("Build", value: UIApplication.buildVersionNumber ?? "")
            }
            
            Section("Sources") {
                ForEach(viewModel.sources, id: \.title) { source in
                    LabeledContent(source.title) {
                        Button {
                            navigationPath.append(NavigationRoutes.Utils.About.browser(with: source.url))
                        } label: {
                            Image(systemName: .SFImages.chevronRight)
                        }
                    }
                }
            }
            
            Section("Developer") {
                ForEach(viewModel.developer, id: \.title) { source in
                    LabeledContent(source.title) {
                        Button {
                            navigationPath.append(NavigationRoutes.Utils.About.browser(with: source.url))
                        } label: {
                            Image(systemName: .SFImages.chevronRight)
                        }
                    }
                }
            }
            
            Section("Tibia") {
                LabeledContent("CipSoft website") {
                    Button {
                        navigationPath.append(NavigationRoutes.Utils.About.browser(with: "https://www.cipsoft.com/en/"))
                    } label: {
                        Image(systemName: .SFImages.chevronRight)
                    }
                }
                
                Text("Tibia.CipSoft")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(4)
            }
        }
        .fontDesign(.serif)
        .navigationTitle(viewModel.viewTitle.localized)
    }
}

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    static var buildVersionNumber: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
}

#Preview {
    NavigationStack {
        AboutView(navigationPath: Binding.constant(NavigationPath()))
    }
}

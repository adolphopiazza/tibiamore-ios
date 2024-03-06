//
//  AboutViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 08/02/24.
//

import Foundation

final class AboutViewModel {
    
    struct Sources {
        let title: String
        let url: String
    }
    
    let viewTitle: String = "About"
    let sources: [Sources] = [Sources(title: "TibiaData", url: "https://tibiadata.com/"),
                              Sources(title: "TibiaLabs", url: "https://tibialabs.com/"),
                              Sources(title: "TibiaWiki", url: "https://tibia.fandom.com/wiki/Main_Page"),
                              Sources(title: "Tibia.com", url: "https://www.tibia.com/")]
    let developer: [Sources] = [Sources(title: "GitHub", url: "https://github.com/AdolphoPiazza"),
                                Sources(title: "LinkedIn", url: "https://www.linkedin.com/in/adolphopiazza/")]
    
}

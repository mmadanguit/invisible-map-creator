//
//  SideMenuViewModel.swift
//  InvisibleMapCreator
//
//  Created by Marion Madanguit on 2/22/21.
//

import Foundation

enum SideMenuViewModel: Int, CaseIterable {
    case signIn
    case printTags
    case manageMaps
    case settings
    case videoWalkthrough
    case giveFeedback
    
    var title: String {
        switch self {
        case .signIn: return "Sign in"
        case .printTags: return "Print tags"
        case .manageMaps: return "Manage maps"
        case .settings: return "Settings"
        case .videoWalkthrough: return "Video walkthrough"
        case .giveFeedback: return "Give feedback"
        }
    }
    
    var imageName: String? {
        switch self {
        case .signIn: return "person.fill"
        case .printTags: return "printer.fill.and.paper.fill"
        case .manageMaps: return "map.fill"
        case .settings: return "gearshape.fill"
        case .videoWalkthrough: return nil
        case .giveFeedback: return nil
        }
    }
}

//
//  UserSettings.swift
//  MoviePreview
//
//  Created by Vinh Nguyen Dinh on R 2/11/09.
//

import SwiftUI

class UserSettings: ObservableObject {
    let defaults = UserDefaults.standard
    
    static let isFirstTimeRunAppKey = "IsFirstTimeRunApp"

    @Published var isFirstTimeRunApp: Bool {
        didSet {
            UserDefaults.standard.setValue(self.isFirstTimeRunApp, forKey: UserSettings.isFirstTimeRunAppKey)
        }
    }
    
    init() {
        self.isFirstTimeRunApp = UserDefaults.standard.object(forKey: UserSettings.isFirstTimeRunAppKey) as? Bool ?? true
    }
}

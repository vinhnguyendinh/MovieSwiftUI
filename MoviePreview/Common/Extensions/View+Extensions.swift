//
//  View+Extensions.swift
//  MoviePreview
//
//  Created by Vinh Nguyen Dinh on R 2/11/09.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

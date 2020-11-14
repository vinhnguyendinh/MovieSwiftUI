//
//  TextFieldInputModifier.swift
//  MoviePreview
//
//  Created by Vinh Nguyen Dinh on R 2/11/09.
//

import SwiftUI

struct TextFieldInputModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.custom("Open Sans", size: 18))
            .foregroundColor(.white)
            .padding(15)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 1)
            )
    }
}

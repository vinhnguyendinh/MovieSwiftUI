//
//  LoginButtonModifier.swift
//  MoviePreview
//
//  Created by Vinh Nguyen Dinh on R 2/11/09.
//

import SwiftUI

struct LoginButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
            .frame(minWidth: 200)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white, lineWidth: 3)
            )
    }
}

extension Text {
    func loginModifier() -> some View {
        return self.foregroundColor(.white)
            .fontWeight(.semibold)
            .font(.body)
            .modifier(LoginButtonModifier())
    }
}

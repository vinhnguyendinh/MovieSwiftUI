//
//  LauncherView.swift
//  MoviePreview
//
//  Created by Vinh Nguyen Dinh on R 2/11/05.
//

import SwiftUI

struct LauncherView: View {
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                Text("Movie Preview")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.headline)
                    .textCase(.uppercase)
            }
                
        })
    }
}

struct LauncherView_Previews: PreviewProvider {
    static var previews: some View {
        LauncherView()
    }
}

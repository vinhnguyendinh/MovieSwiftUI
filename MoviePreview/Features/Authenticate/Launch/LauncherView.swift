//
//  LauncherView.swift
//  MoviePreview
//
//  Created by Vinh Nguyen Dinh on R 2/11/05.
//

import SwiftUI

struct LauncherView: View {
    @ObservedObject var userSettings = UserSettings()
    
    @State private var isShowingNextView: Bool = false
    
    var body: some View {
        VStack {
            contentView()
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isShowingNextView = true
            }
        })
    }
    
    private func contentView() -> some View {
        return NavigationView {
            NavigationLink(
                destination: destinationView(),
                isActive: $isShowingNextView,
                label: {
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
                        backgroundImageView()
                        logoView()
                    }).navigationBarTitle("")
                    .navigationBarHidden(true)
                })
        }
    }
    
    private func destinationView() -> some View {
        return Group {
            if self.userSettings.isFirstTimeRunApp {
                IntroductionView()
            } else {
                LoginView()
            }
        }.navigationTitle("")
        .navigationBarHidden(true)
    }
    
    private func backgroundImageView() -> some View {
        return Image("background")
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
    
    private func logoView() -> some View {
        return VStack {
            Image("logo")
                .resizable()
                .frame(width: 150, height: 150, alignment: .center)
            Text("Movie Preview")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.headline)
                .textCase(.uppercase)
        }
    }
}

struct LauncherView_Previews: PreviewProvider {
    static var previews: some View {
        LauncherView()
    }
}

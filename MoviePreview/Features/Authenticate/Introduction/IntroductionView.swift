//
//  IntroductionView.swift
//  MoviePreview
//
//  Created by Vinh Nguyen Dinh on R 2/11/05.
//

import SwiftUI

enum TabType: Int {
    case first = 0
    case second
    case last
}

struct IntroductionView: View {
    // MARK: - Properties
    private let contentTabList: [(iconName: String, title: String, des: String, button: String)] = [
        ("walkthrough_1", "Get the first", "Movie &TV information", "Next →"),
        ("walkthrough_2", "Know the movie", "is not worth Watching", "Next →"),
        ("walkthrough_3", "Real-time", "updates movie Trailer", "Get Started"),
    ]
    
    @ObservedObject var userSettings = UserSettings()
    
    @State private var tabSelection: Int = 0
    
    // MARK: - Body
    var body: some View {
        contentView()
    }
    
    // MARK: - Content views
    fileprivate func contentView() -> some View {
        return NavigationLink(
            destination: destinationView(),
            isActive: !self.$userSettings.isFirstTimeRunApp,
            label: {
                VStack {
                    TabView(selection: $tabSelection,
                            content:  {
                                tabContentView()
                            }).tabViewStyle(PageTabViewStyle())
                }.navigationTitle("")
                .navigationBarHidden(true)
            })
    }
    
    private func destinationView() -> some View {
        return LoginView()
    }
    
    private func tabContentView() -> some View {
        ForEach(0..<self.contentTabList.count, id: \.self) { index in
            self.createTabView(iconName: self.contentTabList[index].iconName,
                               title: self.contentTabList[index].title,
                               description: self.contentTabList[index].des,
                               buttonTitle: self.contentTabList[index].button) {
                self.buttonHandler(index: index)
            } buttonContent: {
                self.createButtonContent(index: index)
            }
            
        }
    }
    
    private func createTabView<Content: View>(iconName: String,
                                              title: String,
                                              description: String,
                                              buttonTitle: String,
                                              buttonHandler: @escaping (() -> Void),
                                              @ViewBuilder buttonContent: @escaping () -> Content) -> some View {
        return self.createImageTabItem(iconName: iconName, tag: 1) {
            VStack {
                Text(title)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                Text(description)
                    .foregroundColor(.white)
                    .fontWeight(.light)
                    .font(.largeTitle)
                Spacer().frame(height: 100)
                Button(action: {
                    buttonHandler()
                }, label: {
                    buttonContent()
                })
            }
        }
    }
    
    private func createButtonContent(index: Int) -> some View {
        let tabType = TabType(rawValue: index) ?? .first
        
        return Group {
            switch tabType {
            case .last:
                Text(self.contentTabList[index].button)
                    .foregroundColor(.white)
                    .fontWeight(.light)
                    .font(.largeTitle)
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "F99F00"), Color(hex: "DB3069")]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(30)
                
            default:
                Text(self.contentTabList[index].button)
                    .foregroundColor(.white)
                    .fontWeight(.light)
                    .font(.largeTitle)
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.white, lineWidth: 1)
                    )
            }
        }
    }
    
    private func createImageTabItem<Content: View>(iconName: String, tag: Int, @ViewBuilder content: @escaping () -> Content) -> some View {
        return ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
            Image(iconName)
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            
            content()
        }).tabItem {
            
        }.tag(tag)
    }
    
    // MARK: - Handler
    private func buttonHandler(index: Int) {
        guard let tabType = TabType(rawValue: index) else {
            return
        }
        
        switch tabType {
        case .last:
            self.userSettings.isFirstTimeRunApp = false
            break
            
        default:
            self.tabSelection = tabType.rawValue + 1
            break
        }
    }
}

struct IntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionView()
    }
}

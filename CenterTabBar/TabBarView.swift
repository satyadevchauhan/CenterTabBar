//
//  TabBarView.swift
//  CenterTabBar
//
//  Created by Satyadev Chauhan on 07/03/23.
//

import SwiftUI

enum Tab: String {
    
    case home = "Home"
    case search = "Search"
    case message = "Message"
    case user = "Account"
    
    var image: String {
        switch self {
        case .home: return "house"
        case .search: return "magnifyingglass"
        case .message: return "message"
        case .user: return "person"
        }
    }
}

struct TabBarView: View {
    
    @State var selected: Tab = .home
    @State var showMenu = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    
                    Spacer()
                    
                    switch selected {
                    case .home:
                        Text(Tab.home.rawValue)
                    case .search:
                        Text(Tab.search.rawValue)
                    case .message:
                        Text(Tab.message.rawValue)
                    case .user:
                        Text(Tab.user.rawValue)
                    }
                    
                    Spacer()
                    
                    ZStack {
                        
                        if showMenu {
                            MenuView(widthAndHeight: geometry.size.width/7)
                                .offset(y: -geometry.size.height/6)
                        }
                        
                        HStack {
                            
                            TabBarItemView(selected: $selected, tab: .home, width: geometry.size.width/5, height: geometry.size.height/28)
                            
                            TabBarItemView(selected: $selected, tab: .search, width: geometry.size.width/5, height: geometry.size.height/28)
                            
                            ZStack {
                                Circle()
                                    .foregroundColor(.white)
                                    .frame(width: geometry.size.width/7, height: geometry.size.width/7)
                                    .shadow(radius: 4)
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width/7-6 , height: geometry.size.width/7-6)
                                    .foregroundColor(.accentColor)
                                    .rotationEffect(Angle(degrees: showMenu ? 135 : 0))
                            }
                            .offset(y: -geometry.size.height/8/2)
                            .onTapGesture {
                                withAnimation {
                                    showMenu.toggle()
                                }
                            }
                            
                            TabBarItemView(selected: $selected, tab: .message, width: geometry.size.width/5, height: geometry.size.height/28)
                            
                            TabBarItemView(selected: $selected, tab: .user, width: geometry.size.width/5, height: geometry.size.height/28)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                        .background(Color("TabBarBackground").shadow(radius: 2))
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .onChange(of: selected) { _ in
                withAnimation {
                    showMenu = false
                }
            }
            .onAppear {
                showMenu = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

//
//  MainTabbedView.swift
//  Cryptocurrency_Test
//
//  Created by Ashish Viltoriya on 04/11/24.
//

import SwiftUI
#Preview {
    MainTabbedView()
}

enum TabbedItems: Int, CaseIterable{
    case home = 0
    case Updated
    case setting
   
    var iconName: String{
        switch self {
        case .home:
            return "bitcoin"
        case .Updated:
            return "arrow"
        case .setting:
            return "settings"
        }
    }
}

struct MainTabbedView: View {
    
    @State var selectedTab = 0
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            TabView(selection: $selectedTab) {
                ContentView()
                    .tag(0)

                UpdatedView()
                    .tag(1)

                ProfileView()
                    .tag(2)
            }
            ZStack{
                HStack{
                    ForEach((TabbedItems.allCases), id: \.self){ item in
                        Button{
                            selectedTab = item.rawValue
                        } label: {
                            CustomTabItem(imageName: item.iconName, isActive: (selectedTab == item.rawValue))
                        }
                    }
                }
                .padding(6)
            }
            .frame(height: 70)
            .background(.gray.opacity(0.2))
            .cornerRadius(35)
            .padding(.horizontal, 26)
        }
    }
}
extension MainTabbedView{
     public func CustomTabItem(imageName: String, isActive: Bool) -> some View{
        HStack(spacing: 10){
            Spacer()
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 30, height: 30)
            Spacer()
        }
        .frame(width: 70, height: 70)
        .background(isActive ? .gray.opacity(0.4) : .clear)
        .cornerRadius(40)
    }
}

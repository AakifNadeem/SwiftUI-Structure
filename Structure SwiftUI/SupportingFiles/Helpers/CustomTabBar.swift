//
//  TabBarView1.swift
//
//  Created by Aakif Nadeem on 14/10/22.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: TabBarEnum
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
            
            TabsLayoutView(selectedTab: $selectedTab)
        }
        .frame(maxHeight: 115, alignment: .top)
        .cornerRadius(15)
    }
}

fileprivate struct TabsLayoutView: View {
    @Binding var selectedTab: TabBarEnum
    @Namespace var namespace
    
    var body: some View {
        HStack {
            Spacer(minLength: 0)
            
            ForEach(TabBarEnum.allCases) { tab in
                VStack {
                    TabButton(tab: tab, selectedTab: $selectedTab, namespace: namespace)
                        .frame(maxWidth: 85, maxHeight: 65, alignment: .center)
                }
                Spacer()
            }
        }
    }
    
    private struct TabButton: View {
        let tab: TabBarEnum
        @Binding var selectedTab: TabBarEnum
        var namespace: Namespace.ID
        
        var body: some View {
            Button {
                withAnimation {
                    selectedTab = tab
                }
            } label: {
                VStack {
                    Image(isSelected ? selectedTab.selectedIcon : tab.icon)
                        .foregroundColor(isSelected ? .black : .gray)
                        .scaleEffect(isSelected ? 1.2 : 0.9)
                        .animation(isSelected ? .spring(response: 0.5, dampingFraction: 0.3, blendDuration: 1) : .spring(), value: selectedTab)
                        .padding(.bottom, tab == .Home ? 10 : 0)
                }
                .background(Color.white.opacity(0.0001))
            }
            .frame(width: 100, height: 100)
        }
        
        private var isSelected: Bool {
            selectedTab == tab
        }
    }
}


struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.Home))
    }
}

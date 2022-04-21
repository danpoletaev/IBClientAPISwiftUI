//
//  NavigationBar.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI

struct NavigationBar: View {
    var title = ""
    
    var body: some View {
        
        HStack {
            NavigationLink(destination: SearchView(searchViewModel: nil, searchText: ""), label: {
                Image(systemName: "magnifyingglass.circle")
                    .resizable()
                    .foregroundColor(Color.white)
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding(.leading)
            })

            NavigationLink(destination: EmptyView()) {
                EmptyView()
            }
            
            
            Spacer()
            
            Text(title)
                .font(.title.weight(.bold))
                .foregroundColor(Color.white)
                .frame(alignment: .leading)
            
            Spacer()
            
            Button(action: {

            }, label: {
                Image(systemName: "bell.badge")
                    .resizable()
                    .opacity(0.5)
                    .foregroundColor(Color.white)
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding(.trailing)
            })
                .disabled(true)
        }
        .frame(width: UIScreen.screenWidth, height: 60)
        .background(CustomColor.lightBg)
    }
}

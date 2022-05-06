//
//  TicketNavigationBar.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI

struct TicketNavigationBar: View {
    var title: String
    var subTitle: String
    var body: some View {
        HStack {
            
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 12, height: 12, alignment: .center)
                    Text(title)
                        .font(.system(size: 18))
                }
                Text(subTitle)
                    .foregroundColor(Color(.secondaryLabel))
                    .font(.system(size: 14))
                    .padding(.top, -15)
            }
            
        }
        .frame(width: UIScreen.screenWidth, height: 60)
        .padding(.leading, -30)
    }
}

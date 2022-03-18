//
//  SearchNavigationBar.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI

struct SearchNavigationBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            
            VStack {
                Text("Search for symbol/name")
            }
            
        }
        .frame(width: UIScreen.screenWidth, height: 60)
        .padding(.leading, -30)
    }
}

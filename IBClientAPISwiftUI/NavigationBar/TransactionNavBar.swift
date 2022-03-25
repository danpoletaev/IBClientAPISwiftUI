//
//  TransactionNavBar.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 21.03.2022.
//

import SwiftUI

struct TransactionNavBar: View {
    var buying: Bool
    
    var body: some View {
        HStack {
            
            VStack {
                Text(buying ?  "Buy Order" : "Sell order")
            }
            
        }
        .edgesIgnoringSafeArea(.all)
        .frame(width: UIScreen.screenWidth, height: 300)
        .padding(.leading, -30)
    }
}

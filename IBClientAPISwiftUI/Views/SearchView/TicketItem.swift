//
//  TicketItem.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI

struct TicketItem: View {
    var title: String
    var exchange: String
    var conid: Double
    
    var body: some View {
        NavigationLink(destination: {
            TicketView(tickerTitle: title, exchange: exchange, conid: Int(conid))
        }, label: {
            VStack {
                HStack{
                    VStack(alignment: .leading){
                        Text(title)
                            .font(.system(size: 16))
                        Text(exchange)
                            .font(.system(size: 20))
                            .foregroundColor(Color(.secondaryLabel))
                    }
                    Spacer()
                }
            }
        })
    }
}

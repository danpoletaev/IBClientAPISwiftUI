//
//  CustomerScreenItem.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI

import SwiftUI

struct CustomScreenerItem: View {
    var ticker: String
    var price: String
    var percentChange: Double
    var conid: Int
    var listingExchange: String
    var name: String
    
    var body: some View {
        NavigationLink(destination: {
            TicketView(tickerTitle: name, exchange: listingExchange, conid: conid)
        }, label: {
            HStack {
                Image(systemName: percentChange < 0 ? "arrowtriangle.down.fill" : "arrowtriangle.up.fill" )
                    .resizable()
                    .frame(width: 15, height: 15, alignment: .leading)
                    .foregroundColor(percentChange < 0 ? Color.red : Color.green)
                VStack(alignment: .leading) {
                    Text(ticker)
                    Text("\(percentChange, specifier: "%.2f")%")
                        .foregroundColor(percentChange < 0 ? Color.red : Color.green)
                    Text("\(price)$")
                }
            }
            .padding()
            .background(CustomColor.darkBg)
            .cornerRadius(8)
        })
    }
}

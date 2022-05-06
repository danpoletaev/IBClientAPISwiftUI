//
//  TradeItem.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 06.05.2022.
//

import Foundation
import SwiftUI

struct TradeItem: View {
    var ticker: String
    var listingExchange: String
    var tradeTime: String
    var action: String
    var status: String
    var quantity: String
    var avgPrice: String
    
    var body: some View {
        HStack {
            HStack {
                Text(ticker)
                Text(listingExchange)
                    .foregroundColor(Color(.secondaryLabel))
                    .font(.system(size: 10))
            }
            .frame(minWidth: 120, maxWidth: .infinity)
            
            Text(Helpers().parseTime(time: tradeTime))
                .frame(minWidth: 100, maxWidth: .infinity)
            
            Text(action)
                .foregroundColor(action == "BUY" ? Color.green : Color.red)
                .frame(minWidth: 70, maxWidth: .infinity)

            Text(status)
                .frame(minWidth: 70, maxWidth: .infinity)

            Text("\(quantity)")
                .frame(minWidth: 70, maxWidth: .infinity)

            Text(avgPrice)
                .frame(minWidth: 70, maxWidth: .infinity)
        }
        .frame(minWidth: UIScreen.screenWidth, alignment: .leading)
        .padding(.horizontal, 10)
    }
}


struct TradeItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TradeItem(ticker: "Ticker", listingExchange: "Listing exchange", tradeTime: "21212121212", action: "Buy", status: "Filled", quantity: "1.5", avgPrice: "0.5")
                .background(CustomColor.lightBg)
                .environment(\.colorScheme, .dark)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            
            TradeItem(ticker: "Ticker", listingExchange: "Listing exchange", tradeTime: "21212121212", action: "Buy", status: "Filled", quantity: "1.5", avgPrice: "0.5")
                .background(CustomColor.lightBg)
                .environment(\.colorScheme, .dark)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
        }
    }
}

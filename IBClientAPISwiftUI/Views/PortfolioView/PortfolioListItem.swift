//
//  PortfolioListItem.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI

struct PortfolioListItem: View {
    var ticker: String
    var last: Double
    var listingExchange: String
    var position: Double
    var unrealizedPnl: Double
    var changeFromLastPrice: String
    
    var body: some View {
        HStack {
            HStack {
                Text(ticker)
                Text(listingExchange)
                    .foregroundColor(Color(.secondaryLabel))
                    .font(.system(size: 10))
            }
            .frame(width: 100, alignment: .leading)
            Text("\(last, specifier: "%.2f")")
                .frame(width: 100, alignment: .center)
            Text("\(Double(changeFromLastPrice) ?? 0, specifier: "%.2f")")
                .foregroundColor(Double(changeFromLastPrice) ?? 0 < 0 ? Color.red :Color.green)
                .frame(width: 70, alignment: .center)
            Text("\(position, specifier: "%.2f")")
                .frame(width: 70, alignment: .center)
            Text("\(unrealizedPnl, specifier: "%.2f")")
                .foregroundColor(unrealizedPnl < 0 ? Color.red : Color.green)
                .frame(width: 70, alignment: .center)
        }
        .padding(.horizontal, 10)
    }
}

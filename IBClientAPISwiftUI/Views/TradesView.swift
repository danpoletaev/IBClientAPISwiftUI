//
//  TradesView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 27.03.2022.
//

import SwiftUI

struct TradesView: View {
    
    @StateObject var tradesViewModel: TradesViewModel
    
    init(tradesViewModel: TradesViewModel?) {
        _tradesViewModel = StateObject(wrappedValue: tradesViewModel ?? TradesViewModel(repository: nil))
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Text("Instument")
                        .foregroundColor(Color(.secondaryLabel))
                        .font(.system(size: 14))
                        .frame(minWidth: 120, maxWidth: .infinity)
                    
                    Text("Trade Time")
                        .foregroundColor(Color(.secondaryLabel))
                        .font(.system(size: 14))
                        .frame(minWidth: 100, maxWidth: .infinity)

                    Text("Action")
                        .foregroundColor(Color(.secondaryLabel))
                        .font(.system(size: 14))
                        .frame(minWidth: 70, maxWidth: .infinity)

                    Text("Status")
                        .foregroundColor(Color(.secondaryLabel))
                        .font(.system(size: 14))
                        .frame(minWidth: 70, maxWidth: .infinity)

                    Text("Quantity")
                        .foregroundColor(Color(.secondaryLabel))
                        .font(.system(size: 14))
                        .frame(minWidth: 70, maxWidth: .infinity)
                    
                    Text("Avg Price")
                        .foregroundColor(Color(.secondaryLabel))
                        .font(.system(size: 14))
                        .frame(minWidth: 70, maxWidth: .infinity)
                }
                .frame(minWidth: UIScreen.screenWidth, alignment: .leading)
                .padding(.horizontal, 10)
                
                VStack {
                    ForEach(tradesViewModel.allTrades.orders, id: \.orderId) { trade in
                        Divider()
                        TradeItem(ticker: trade.ticker, listingExchange: trade.listingExchange, tradeTime: trade.lastExecutionTime, action: trade.side, status: trade.status, quantity: trade.sizeAndFills, avgPrice: trade.avgPrice ?? "0")
                    }
                    Divider()
                }
                .background(CustomColor.darkBg)
                
                Spacer()
            }
            .padding(.top, 20)
            .frame(width: UIScreen.screenWidth)
            .background(CustomColor.lightBg)
            .onAppear(perform: {
                tradesViewModel.getAllTrades()
            })
        }
    }
}

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
            
            Text(parseTime(time: tradeTime))
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

func parseTime(time: String) -> String {
    return "\(time[6])\(time[7]):\(time[8])\(time[9]):\(time[10])\(time[11])"
}

//struct TradesView_Previews: PreviewProvider {
//    static var previews: some View {
//        TradesView()
//    }
//}

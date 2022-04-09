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
                        .frame(width: 100, alignment: .leading)
                    Text("Trade Time")
                        .foregroundColor(Color(.secondaryLabel))
                        .font(.system(size: 14))
                        .frame(width: 100, alignment: .center)
                    Text("Action")
                        .foregroundColor(Color(.secondaryLabel))
                        .font(.system(size: 14))
                        .frame(width: 70, alignment: .center)
                    Text("Status")
                        .foregroundColor(Color(.secondaryLabel))
                        .font(.system(size: 14))
                        .frame(width: 70, alignment: .center)
                    Text("Quantity")
                        .foregroundColor(Color(.secondaryLabel))
                        .font(.system(size: 14))
                        .frame(width: 70, alignment: .center)
                    
                    Text("Avg Price")
                        .foregroundColor(Color(.secondaryLabel))
                        .font(.system(size: 14))
                        .frame(width: 70, alignment: .center)
                }
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
            .frame(width: 100, alignment: .leading)
            Text(parseTime(time: tradeTime))
                .frame(width: 100, alignment: .center)
            Text(action)
                .foregroundColor(action == "BUY" ? Color.green : Color.red)
                .frame(width: 70, alignment: .center)
            Text(status)
                .frame(width: 70, alignment: .center)
            Text("\(quantity)")
                .frame(width: 70, alignment: .center)
            Text(avgPrice)
                .frame(width: 70, alignment: .center)
        }
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

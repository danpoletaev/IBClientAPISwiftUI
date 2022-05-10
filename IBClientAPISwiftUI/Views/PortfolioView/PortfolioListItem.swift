//
//  PortfolioListItem.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI

struct PortfolioListItem: View {
    var ticker: String
    var listingExchange: String
    var conid: Int
    var last: Double
    var position: Double
    var unrealizedPnl: Double
    var changeFromLastPrice: String
    
    @StateObject var ticketViewModel: TicketViewModel
    
    init(ticketViewModel: TicketViewModel?, ticker: String, listingExchange: String, conid: Int, last: Double, position: Double, unrealizedPnL: Double, changeFromLastPrice: String) {
        _ticketViewModel = StateObject(wrappedValue: ticketViewModel ?? TicketViewModel(repository: nil))
        self.ticker = ticker
        self.listingExchange = listingExchange
        self.conid = conid
        self.last = round(last * 100) / 100.0
        self.position = round(position * 100) / 100.0
        self.unrealizedPnl = unrealizedPnL
        self.changeFromLastPrice = changeFromLastPrice
    }
    
    var body: some View {
        HStack {
            HStack {
                Text(ticker)
                Text(listingExchange)
                    .foregroundColor(Color(.secondaryLabel))
                    .font(.system(size: 10))
            }
            .frame(minWidth: 100, maxWidth: .infinity, alignment: .leading)
            Text(ticketViewModel.tickerInfo?.bid ?? "\(last)")
                .frame(minWidth: 100, maxWidth: .infinity)
            Text(ticketViewModel.tickerInfo?.changeFromLastPrice ?? changeFromLastPrice)
                .foregroundColor(ticketViewModel.tickerInfo?.changeFromLastPricePercentage ?? Double(changeFromLastPrice) ?? 0 < 0 ? Color.red :Color.green)
                .frame(minWidth: 70, maxWidth: .infinity)
            Text(ticketViewModel.tickerInfo?.positions ?? "\(position)")
                .frame(minWidth: 70, maxWidth: .infinity)
            Text(ticketViewModel.tickerInfo?.unrPnL ?? "\(unrealizedPnl)")
                .foregroundColor(Double(ticketViewModel.tickerInfo?.unrPnL ?? "\(unrealizedPnl)") ?? unrealizedPnl < 0 ? Color.red : Color.green)
                .frame(minWidth: 70, maxWidth: .infinity)
        }
        .frame(minWidth: UIScreen.screenWidth, alignment: .leading)
        .padding(.horizontal, 10)
        .onAppear(perform: {
            ticketViewModel.getTickerInfo(conid: conid)
        })
    }
}

struct PortfolioListItem_Previews: PreviewProvider {
    static var previews: some View {
        let ticketViewModel = TicketViewModel(repository: TicketRepository(apiService: MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil), acccountApiService: nil))
        
        
        Group {
            PortfolioListItem(ticketViewModel: ticketViewModel, ticker: "BIOL", listingExchange: "NASDAQ", conid: 1, last: 12.2, position: 1.2, unrealizedPnL: -0.5, changeFromLastPrice: "-32$")
                .environment(\.colorScheme, .dark)
                .background(CustomColor.lightBg)
                .onAppear(perform: {
                    ticketViewModel.getTickerInfo(conid: 1)
                })
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            
            PortfolioListItem(ticketViewModel: ticketViewModel, ticker: "BIOL", listingExchange: "NASDAQ", conid: 1, last: 12.2, position: 1.2, unrealizedPnL: -0.5, changeFromLastPrice: "-32$")
                .environment(\.colorScheme, .dark)
                .background(CustomColor.lightBg)
                .onAppear(perform: {
                    ticketViewModel.getTickerInfo(conid: 1)
                })
                .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
        }
    }
}

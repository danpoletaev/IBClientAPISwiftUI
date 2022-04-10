//
//  CustomerScreenItem.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI
import Foundation

struct CustomScreenerItem: View {
    var ticker: String
    var conid: Int
    var listingExchange: String
    var name: String
    
    @StateObject var ticketViewModel: TicketViewModel
    
    init(ticketViewModel: TicketViewModel?, ticker: String, conid: Int, listingExchange: String, name: String) {
        _ticketViewModel = StateObject(wrappedValue: ticketViewModel ?? TicketViewModel(repository: nil))
        self.ticker = ticker
        self.listingExchange = listingExchange
        self.conid = conid
        self.name = name
    }
    
    
    
    var body: some View {
        NavigationLink(destination: {
            TicketView(ticketViewModel: nil, tickerTitle: name, exchange: listingExchange, conid: conid)
        }, label: {
            HStack {
                Image(systemName: ticketViewModel.tickerInfo?.changeFromLastPricePercentage ?? 0 < 0 ? "arrowtriangle.down.fill" : "arrowtriangle.up.fill" )
                    .resizable()
                    .frame(width: 15, height: 15, alignment: .leading)
                    .foregroundColor(ticketViewModel.tickerInfo?.changeFromLastPricePercentage ?? 0 < 0 ? Color.red : Color.green)
                VStack(alignment: .leading) {
                    Text(ticker)
                    Text("\(ticketViewModel.tickerInfo?.changeFromLastPricePercentage ?? 0, specifier: "%.2f")%")
                        .foregroundColor(ticketViewModel.tickerInfo?.changeFromLastPricePercentage ?? 0 < 0 ? Color.red : Color.green)
                    Text(ticketViewModel.tickerInfo?.bid?.appending("$") ?? "")
                        .frame(alignment: .center)
                }
            }
            .padding()
            .background(CustomColor.darkBg)
            .cornerRadius(8)
        })
            .onAppear(perform: {
                ticketViewModel.getTickerInfo(conid: conid)
            })
    }
}

struct CustomScreenerItem_Preview: PreviewProvider {
    static var previews: some View {
        let ticketViewModel = TicketViewModel(repository: TicketRepository(apiService: MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil), acccountApiService: nil))
        
        CustomScreenerItem(ticketViewModel: ticketViewModel, ticker: "BIOL", conid: 1, listingExchange: "NASDAQ", name: "BIOL")
            .environment(\.colorScheme, .dark)
            .background(CustomColor.lightBg)
            .onAppear(perform: {
                ticketViewModel.getTickerInfo(conid: 1)
            })
    }
}

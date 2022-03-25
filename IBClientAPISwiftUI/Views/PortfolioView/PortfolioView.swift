//
//  PortfolioView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI

struct AccountSummaryString {
    let name: String
    let label: String
}

struct PortfolioView: View {
    
    @StateObject var portfolioViewModel = PortfolioViewModel()
    @EnvironmentObject var environmentModel: EnvironmentModel
    private var timer: Timer? = nil
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                VStack {
                    PortfolioHeader(accountSummary: portfolioViewModel.accountSummary, dailyPnL: portfolioViewModel.dailyPnL)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Text("Instument")
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 14))
                                .frame(width: 100, alignment: .leading)
                            Text("Last")
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 14))
                                .frame(width: 100, alignment: .center)
                            Text("Change")
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 14))
                                .frame(width: 70, alignment: .center)
                            Text("Position")
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 14))
                                .frame(width: 70, alignment: .center)
                            
                            Text("P&L")
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 14))
                                .frame(width: 70, alignment: .center)
                        }
                        .padding(.horizontal, 10)
                        
                        VStack {
                            Divider()
                            ForEach(portfolioViewModel.positions, id: \.conid) { position in
                                NavigationLink(destination: {
                                    TicketView(tickerTitle: position.name ?? "Ticker", exchange: position.listingExchange ?? "Exchange", conid: position.conid)
                                }, label: {
                                    PortfolioListItem(ticker: position.contractDesc ?? "Ticker", last: position.mktPrice ?? 1, listingExchange: position.listingExchange ?? "NASDAQ", position: position.position ?? 0, unrealizedPnl: position.unrealizedPnl ?? 0, changeFromLastPrice: position.priceChange ?? "0")
                                })
                                Divider()
                            }
                        }
                        .background(CustomColor.darkBg)
                    }
                    
                    if !(portfolioViewModel.assetClass?.long.isEmpty ?? true) {
                        CashBalances(isLong: true, assetList: portfolioViewModel.assetClass?.long ?? [:])
                    } else if !(portfolioViewModel.assetClass?.short.isEmpty ?? true) {
                        CashBalances(isLong: true, assetList: portfolioViewModel.assetClass?.short ?? [:])
                    }
                    
                }
                .background(CustomColor.lightBg)
            }
            .padding(.top, 20)
            .onAppear(perform: {
                portfolioViewModel.onAppear()
                environmentModel.fetchData()
            })
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}


//
//  PortfolioView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI
import ActivityIndicatorView

struct AccountSummaryString {
    let name: String
    let label: String
}

struct PortfolioView: View {
    
    @StateObject var portfolioViewModel: PortfolioViewModel
    @EnvironmentObject var environmentModel: EnvironmentModel
    
    init(portfolioViewModel: PortfolioViewModel?) {
        _portfolioViewModel = StateObject(wrappedValue: portfolioViewModel ?? PortfolioViewModel(repository: nil))
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
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
                                if portfolioViewModel.positions.count == 0 {
                                    Text("You don't have any positions yet")
                                        .foregroundColor(Color(.secondaryLabel))
                                        .frame(width: UIScreen.screenWidth)
                                        .padding(.horizontal, 30)
                                    
                                } else {
                                    Divider()
                                    ForEach(portfolioViewModel.positions, id: \.conid) { position in
                                        NavigationLink(destination: {
                                            TicketView(ticketViewModel: nil, tickerTitle: position.name ?? "Ticker", exchange: position.listingExchange ?? "Exchange", conid: position.conid)
                                        }, label: {
                                            PortfolioListItem(ticketViewModel: nil, ticker: position.contractDesc ?? "", listingExchange: position.listingExchange ?? "NASDAQ", conid: position.conid, last: position.mktPrice ?? 0, position: position.position ?? 0, unrealizedPnL: position.unrealizedPnl ?? 0, changeFromLastPrice: position.priceChange ?? "0")
                                        })
                                        Divider()
                                    }
                                }
                            }
                            .frame(minHeight: 200)
                            .background(CustomColor.darkBg)
                        }
                        
                        if !(portfolioViewModel.assetClass?.long.isEmpty ?? true) {
                            CashBalances(isLong: true, assetList: portfolioViewModel.assetClass?.long ?? [:])
                        } else if !(portfolioViewModel.assetClass?.short.isEmpty ?? true) {
                            CashBalances(isLong: true, assetList: portfolioViewModel.assetClass?.short ?? [:])
                        }
                        
                    }
                    .background(CustomColor.lightBg)
                    
                    Spacer()
                }
                .padding(.top, 20)
                .frame(minHeight: UIScreen.screenHeight)
                .opacity(portfolioViewModel.isLoading ? 0.5 : 1)
                .onAppear(perform: {
                    portfolioViewModel.onAppear()
                    environmentModel.fetchData()
                })
                ActivityIndicatorView(isVisible: $portfolioViewModel.isLoading, type: .scalingDots)
                    .foregroundColor(Color.white)
                    .frame(width: 80, height: 50, alignment: .center)
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        
        let environmentModel = MockedAccountModels.mockedEvnironmentModel
        
        let portfolioViewModel = PortfolioViewModel(repository: PortfolioRepository(portfolioApiService: MockPortfolioApiService(positions: nil), accountApiService: MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil), tickerApiService: MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)))
        
        PortfolioView(portfolioViewModel: portfolioViewModel)
            .environmentObject(environmentModel)
            .environment(\.colorScheme, .dark)
            .background(CustomColor.darkBg)
            .onAppear(perform: {
                portfolioViewModel.onAppear()
                environmentModel.fetchData()
            })
        
    }
}


//
//  HomeView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI
import StockCharts

struct HomeView: View {
    @EnvironmentObject var environmentModel: EnvironmentModel
    @StateObject var homeViewModel: HomeViewModel
    
    init(homeViewModel: HomeViewModel?) {
        _homeViewModel = StateObject(wrappedValue: homeViewModel ?? HomeViewModel(homeRepository: nil))
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                // graph
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            // acount number + amount
                            Text(environmentModel.accountViewModel.account?.accountId ?? "Fetching")
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 14))
                            Text("\(environmentModel.accountViewModel.account?.currency ?? "USD")\(environmentModel.accountViewModel.total?.endVal ?? "0")")
                                .foregroundColor(Color.white)
                                .font(.system(.title2))
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("Change(All Time)")
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 14))
                            Text("\(environmentModel.accountViewModel.account?.currency ?? "USD")\(String(format: "%.2f", homeViewModel.accountPerformance.moneyChange ?? 0))")
                                .foregroundColor(homeViewModel.accountPerformance.moneyChange ?? 0 < 0 ? Color.red : Color.green)
                                .font(.system(.title2))
                        }
                    }
                    if self.homeViewModel.accountPerformance.graphData.count < 1 {
                        Spacer()
                    } else {
                        LineChartView(
                            lineChartController:
                                LineChartController(
                                    prices: self.homeViewModel.accountPerformance.graphData, dates: self.homeViewModel.accountPerformance.dates, downtrendLineColor: CustomColor.graphBlue, dragGesture: true
                                )
                        )
                    }
                }
                .padding()
                .frame(width: UIScreen.screenWidth, height: 300, alignment: .center)
                .background(CustomColor.darkBg)
                .padding()
                
                VStack {
                    HStack(alignment: .firstTextBaseline) {
                        Text("Top Portfolio Positions")
                            .font(.system(.headline))
                        Spacer()
                        Button(action: {
                            self.environmentModel.tagSelection = 0
                        }, label: {
                            Image(systemName: "arrow.up.forward.app")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                        })
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
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
                            ForEach(homeViewModel.topPortfolio, id: \.conid) { position in
                                NavigationLink(destination: {
                                    TicketView(ticketViewModel: nil, tickerTitle: position.name ?? "Ticker", exchange: position.listingExchange ?? "Exchange", conid: position.conid)
                                }, label: {
                                    PortfolioListItem(ticker: position.contractDesc ?? "Ticker", last: position.mktPrice ?? 1, listingExchange: position.listingExchange ?? "NASDAQ", position: position.position ?? 0, unrealizedPnl: position.unrealizedPnl ?? 0, changeFromLastPrice: position.priceChange ?? "0")
                                })
                                Divider()
                            }
                        }
                        .background(CustomColor.darkBg)
                    }
                    
                    Divider()
                }
                .frame(width: UIScreen.screenWidth, alignment: .center)
                .background(CustomColor.darkBg)
                
                VStack {
                    HStack {
                        Text("Daily Gainers")
                            .font(.system(.headline))
                            .padding(.leading, 10)
                        Spacer()
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(self.homeViewModel.secDefConids, id: \.conid) { info in
                                CustomScreenerItem(ticker: info.ticker ?? "", price: info.lastPrice ?? "", percentChange: info.percentChange ?? 0, conid: info.conid, listingExchange: info.listingExchange ?? "", name: info.name ?? "")
                            }
                        }
                    }
                }
                .padding(.horizontal, 5)
                .frame(width: UIScreen.screenWidth)
                
                Spacer()
            }
        }
        .onAppear(perform: {
            environmentModel.fetchData()
            homeViewModel.onAppear()
        })
    }
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        let environmentModel = MockedAccountModels.mockedEvnironmentModel
        
        let homeViewModel = HomeViewModel(homeRepository: HomeRepository(homeApiService: MockHomeApiService(scannerResponse: nil), portfolioApiService: nil, tickerApiService: nil, accountApiService: MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil)))
        
        HomeView(homeViewModel: homeViewModel)
            .environmentObject(environmentModel)
            .environment(\.colorScheme, .dark)
            .background(CustomColor.lightBg)
            .onAppear(perform: {
                homeViewModel.onAppear()
            })
    }
}


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
    @StateObject var homeViewModel = HomeViewModel()
    @Binding var selection: Int
    
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
                            Text("CZK1,125")
                                .foregroundColor(Color.white)
                                .font(.system(.title2))
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("Change(1M)")
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 14))
                            Text("CZK-22")
                                .foregroundColor(Color.red)
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
                            self.selection = 0
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
                            Text("Instrument")
                                .frame(width: 150, alignment: .leading)
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 14))
                            Text("Last Price")
                                .frame(width: 100, alignment: .trailing)
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 14))
                            Text("Change")
                                .frame(width: 100, alignment: .trailing)
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 14))
                            Text("Market Value")
                                .frame(width: 100, alignment: .trailing)
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 14))
                        }
                        .padding(.horizontal)
                        Divider()
                        
                        ForEach(homeViewModel.topPortfolio, id: \.conid) { position in
                            NavigationLink(destination: {
                                TicketView(tickerTitle: position.contractDesc ?? "Ticker", exchange: position.listingExchange ?? "Exchange", conid: position.conid)
                            }, label: {
                                PortfolioListItem(ticker: position.contractDesc ?? "Ticker", last: position.mktPrice ?? 1, listingExchange: position.listingExchange ?? "NASDAQ", position: position.position ?? 0, unrealizedPnl: position.unrealizedPnl ?? 0)
                            })
                            Divider()
                        }
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

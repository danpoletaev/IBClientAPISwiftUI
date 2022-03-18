//
//  TicketView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI
import StockCharts

struct TicketView: View {
    @StateObject var ticketViewModel = TicketViewModel()
    
    var tickerTitle: String
    var exchange: String
    var conid: Int
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Text(tickerTitle)
                        Text(exchange)
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 14))
                        
                    }
                    .padding(.horizontal)
                    .frame(width: UIScreen.screenWidth, alignment: .leading)
                }
                
                HStack {
                    Text(ticketViewModel.tickerInfo?.bid ?? "0")
                        .font(.system(size: 40))
                    VStack {
                        Text("\(ticketViewModel.tickerInfo?.changeFromLastPrice ?? "") $")
                            .foregroundColor(ticketViewModel.tickerInfo?.changeFromLastPricePercentage ?? 0 < 0 ? Color.red : Color.green)
                            .font(.system(size: 14))
                        Text("\(ticketViewModel.tickerInfo?.changeFromLastPricePercentage ?? 0, specifier: "%.2f") %")
                            .foregroundColor(ticketViewModel.tickerInfo?.changeFromLastPricePercentage ?? 0 < 0 ? Color.red : Color.green)
                            .font(.system(size: 14))
                    }
                    Spacer()
                    
                    VStack {
                        HStack {
                            Text("High")
                                .foregroundColor(Color(.secondaryLabel))
                            Text(ticketViewModel.tickerInfo?.high ?? "0")
                        }
                        HStack {
                            Text("Low")
                                .foregroundColor(Color(.secondaryLabel))
                            Text(ticketViewModel.tickerInfo?.low ?? "0")
                        }
                    }
                }.padding(.horizontal)
                
                TicketGraph(tickerInfo: $ticketViewModel.tickerInfo, graphData: $ticketViewModel.graphData, dates: $ticketViewModel.dates)
                Divider()
                MarketData(tickerInfo: $ticketViewModel.tickerInfo)
                Divider()
                    .padding(.vertical, 10)
                PositionItem(tickerInfo: $ticketViewModel.tickerInfo)
                
                HStack {
                    Button(action: {
                        print("sell clicked")
                    }, label: {
                        Text("Sell")
                            .foregroundColor(Color.white)
                            .padding(5)
                            .frame(width: 160, alignment: .center)
                            .background(Color.red)
                            .cornerRadius(8)
                    })
                    Spacer()
                    Button(action: {
                        print("sell clicked")
                    }, label: {
                        Text("Buy")
                            .foregroundColor(Color.white)
                            .padding(5)
                            .frame(width: 160, alignment: .center)
                            .background(Color.blue)
                            .cornerRadius(8)
                    })
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
            .frame(width: UIScreen.screenWidth, alignment: .center)
            .background(CustomColor.darkBg)
            .navigationTitle("Bar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                TicketNavigationBar(title: tickerTitle, subTitle: exchange)
            }
        }
        .onAppear(perform: {
            ticketViewModel.onAppear(conid: conid, period: "1m")
        })
    }
}


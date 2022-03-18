//
//  PositionItem.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI

struct PositionItem: View {
    @Binding var tickerInfo: TickerInfo?
    
    var body: some View {
        if Double(tickerInfo?.positions ?? "0.00") ?? 0 > 0 {
            VStack {
                HStack {
                    Text("Position")
                        .foregroundColor(Color(.secondaryLabel))
                    Spacer()
                    HStack {
                        Text("Long")
                            .foregroundColor(Color(.secondaryLabel))
                        Text(tickerInfo?.positions ?? "")
                    }
                }
                .padding(.vertical, 10)
                
                //TODO use grid
                HStack {
                    VStack {
                        HStack{
                            Text("Mkt Val")
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 16))
                            Spacer()
                            Text(tickerInfo?.marketValue ?? "")
                        }
                        .padding(.vertical, 2)
                        .padding(.trailing, 5)
                        
                        HStack{
                            Text("Avg Price")
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 16))
                            Spacer()
                            Text(tickerInfo?.avgPrice ?? "")
                        }
                        .padding(.vertical, 2)
                        .padding(.trailing, 5)
                        
                        HStack{
                            Text("Cost Basis")
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 16))
                            Spacer()
                            Text(tickerInfo?.costBasis ?? "")
                        }
                        .padding(.vertical, 2)
                        .padding(.trailing, 5)
                    }
                    
                    Divider()
                    
                    VStack {
                        HStack{
                            Text("P&L")
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 16))
                            Spacer()
                            Text(tickerInfo?.dailyPnL ?? "")
                                .foregroundColor(Int(tickerInfo?.dailyPnL ?? "0") ?? 0 > 0 ? Color.green : Color.red)
                        }
                        .padding(.vertical, 2)
                        .padding(.trailing, 5)
                        
                        HStack{
                            Text("Rlz P&L")
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 16))
                            Spacer()
                            Text("")
                        }
                        .padding(.vertical, 2)
                        .padding(.trailing, 5)
                        
                        HStack{
                            Text("Unrl P&L")
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 16))
                            Spacer()
                            Text(tickerInfo?.unrPnL ?? "")
                                .foregroundColor(Int(tickerInfo?.unrPnL ?? "0") ?? 0 > 0 ? Color.green : Color.red)
                        }
                        .padding(.vertical, 2)
                        .padding(.trailing, 5)
                    }
                }
                
            }
            .padding(.horizontal)
        }
    }
}

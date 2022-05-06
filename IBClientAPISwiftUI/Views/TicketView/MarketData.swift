//
//  MarketData.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI

struct MarketData: View {
    @Binding var tickerInfo: TickerInfo?
    
    var body: some View {
        VStack {
            HStack {
                Text("Market Data")
                    .foregroundColor(Color(.secondaryLabel))
                Spacer()
                HStack {
                    Text("Hist Vol")
                        .foregroundColor(Color(.secondaryLabel))
                    Text(tickerInfo?.historyVolume ?? "")
                }
            }
            .padding(.vertical, 10)
            
            //TODO use grid
            HStack {
                VStack {
                    HStack{
                        Text("Open")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 16))
                        Spacer()
                        Text(tickerInfo?.open ?? "")
                    }
                    .padding(.vertical, 2)
                    .padding(.trailing, 5)
                    
                    HStack{
                        Text("Close")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 16))
                        Spacer()
                        Text(tickerInfo?.close ?? "")
                    }
                    .padding(.vertical, 2)
                    .padding(.trailing, 5)
                    
                    HStack{
                        Text("52w. High")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 16))
                        Spacer()
                        Text(tickerInfo?.weekHigh52 ?? "")
                    }
                    .padding(.vertical, 2)
                    .padding(.trailing, 5)
                    
                    HStack{
                        Text("52w. Low")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 16))
                        Spacer()
                        Text(tickerInfo?.weekLow52 ?? "")
                    }
                    .padding(.vertical, 2)
                    .padding(.trailing, 5)
                    
                    HStack{
                        Text("Vlm Today")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 16))
                        Spacer()
                        Text(tickerInfo?.dayVolume ?? "")
                    }
                    .padding(.vertical, 2)
                    .padding(.trailing, 5)
                    
                    HStack{
                        Text("Vlm Avg")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 16))
                        Spacer()
                        Text(tickerInfo?.avgDailyVolume ?? "")
                    }
                    .padding(.vertical, 2)
                    .padding(.trailing, 5)
                }
                
                Divider()
                
                VStack {
                    HStack{
                        Text("EPS")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 16))
                        Spacer()
                        Text(tickerInfo?.eps ?? "")
                    }
                    .padding(.vertical, 2)
                    .padding(.trailing, 5)
                    
                    HStack{
                        Text("P/E")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 16))
                        Spacer()
                        Text(tickerInfo?.pe ?? "")
                    }
                    .padding(.vertical, 2)
                    .padding(.trailing, 5)
                    
                    HStack{
                        Text("Dividend")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 16))
                        Spacer()
                        Text(tickerInfo?.dividend ?? "")
                    }
                    .padding(.vertical, 2)
                    .padding(.trailing, 5)
                    
                    HStack{
                        Text("DVD Yld")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 16))
                        Spacer()
                        Text(tickerInfo?.dividendYield ?? "")
                    }
                    .padding(.vertical, 2)
                    .padding(.trailing, 5)
                    
                    HStack{
                        Text("Mkt Cap")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 16))
                        Spacer()
                        Text(tickerInfo?.marketCap ?? "")
                    }
                    .padding(.vertical, 2)
                    .padding(.trailing, 5)
                    
                    HStack{
                        Text("Mrt Cap")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 16))
                        Spacer()
                        Text(tickerInfo?.marketValuePercent ?? "")
                    }
                    .padding(.vertical, 2)
                    .padding(.trailing, 5)
                }
            }
            
        }
        .padding(.horizontal)
    }
}

struct MarketData_Preview: PreviewProvider {
    @State static var tickerInfo: TickerInfo? = MockTickerModels.tickerInfo
    
    static var previews: some View {
        
        Group {
            MarketData(tickerInfo: $tickerInfo)
                .environment(\.colorScheme, .dark)
                .background(CustomColor.lightBg)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            
            MarketData(tickerInfo: $tickerInfo)
                .environment(\.colorScheme, .dark)
                .background(CustomColor.lightBg)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
        }
    }
}

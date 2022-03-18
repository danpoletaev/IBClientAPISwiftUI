//
//  TicketGraph.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI
import StockCharts

struct TicketGraph: View {
    @Binding var tickerInfo: TickerInfo?
    @Binding var graphData: [Double]
    @Binding var dates: [String]
    
    var body: some View {
        VStack {
            LineChartView(
                lineChartController:
                    LineChartController(
                        prices: self.graphData, dates: self.dates, downtrendLineColor: CustomColor.graphBlue, dragGesture: true
                    )
            )
        }
        .padding(.horizontal, 10)
        .frame(width: UIScreen.screenWidth, height: 200, alignment: .center)
        .background(CustomColor.lightBg)
    }
}

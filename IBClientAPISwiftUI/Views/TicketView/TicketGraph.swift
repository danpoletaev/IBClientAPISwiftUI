//
//  TicketGraph.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI
import StockCharts

struct TicketGraph: View {
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


struct TicketGraph_Previews: PreviewProvider {
    
    @State static var graphData = [1.1,2.2,3.3,4.4,5.5,6.6,7.7]
    @State static var dates = ["20-01-03", "20-01-04", "20-01-05", "20-01-06", "20-01-07", "20-01-08", "20-01-09"]
    
    static var previews: some View {
        
        Group {
            TicketGraph(graphData: $graphData, dates: $dates)
                .environment(\.colorScheme, .dark)
                .background(CustomColor.lightBg)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            
            
            TicketGraph(graphData: $graphData, dates: $dates)
                .environment(\.colorScheme, .dark)
                .background(CustomColor.lightBg)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
        }
    }
}



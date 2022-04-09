//
//  MockSearchModels.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 09.04.2022.
//

import Foundation

enum MockSeachModels {
    static let searchTickets: [SearchTicket] = Bundle.main.decode(type: [SearchTicket].self, from: "SearchTicketResponse.json")
}

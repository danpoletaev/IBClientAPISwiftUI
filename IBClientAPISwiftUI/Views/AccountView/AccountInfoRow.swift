//
//  AccountInfoRow.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 08.04.2022.
//

import SwiftUI

struct AccountInfoRow: View {
    var key: String
    var value: String
    var body: some View {
        HStack {
            Text(key)
                .foregroundColor(Color(.secondaryLabel))
                .font(.system(size: 14))
            Spacer()
            Text(value)
        }
        .padding()
    }
}

struct AccountInfoRow_Preview: PreviewProvider {
    static var previews: some View {
        AccountInfoRow(key: "key", value: "value")
            .background(CustomColor.lightBg)
            .environment(\.colorScheme, .dark)
    }
}

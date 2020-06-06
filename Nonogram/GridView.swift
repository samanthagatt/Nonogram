//
//  GridView.swift
//  Nonogram
//
//  Created by Samantha Gatt on 6/5/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let horizontalSpacing: CGFloat
    let verticalSpacing: CGFloat
    let content: (Int, Int) -> Content

    var body: some View {
        VStack(spacing: verticalSpacing) {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack(spacing: self.horizontalSpacing) {
                    ForEach(0 ..< self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }

    init(
        rows: Int,
        columns: Int,
        horizontalSpacing: CGFloat = 0,
        verticalSpacing: CGFloat = 0,
        @ViewBuilder content: @escaping (Int, Int) -> Content
    ) {
        self.rows = rows
        self.columns = columns
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.content = content
    }
}

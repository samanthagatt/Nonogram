//
//  PuzzleView.swift
//  Nonogram
//
//  Created by Samantha Gatt on 6/5/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct PuzzleView: View {
    @State private var rows: Int = 15
    @State private var columns: Int = 15
    @State private var cache: Set<String> = []
    
    private let outerBorderWidth: CGFloat = 2
    private let outerPadding: CGFloat = 16
    
    var body: some View {
        return GeometryReader { geometry in
            VStack {
                Spacer()
                
                GridStack(rows: self.rows, columns: self.columns) { row, col in
                    self.getColor(for: row, and: col)
                        .border(Color.black, width: 0.5)
                        .onTapGesture {
                            let str = "\(row),\(col)"
                            print(str)
                            if self.cache.contains(str) {
                                self.cache.remove(str)
                            } else {
                                self.cache.insert(str)
                            }
                        }
                }
                .padding(self.outerBorderWidth)
                .border(Color.black, width: self.outerBorderWidth)
                .padding(self.outerPadding)
                .makeSquare(with: geometry)
                
                Spacer()
            }
        }
    }
    
    private func getColor(for row: Int, and col: Int) -> some View {
        let str = "\(row),\(col)"
        let color: Color = self.cache.contains(str) ? .black : .clear
        return color
    }
}

struct PuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleView()
    }
}

struct MakeSquare: ViewModifier {
    let proxy: GeometryProxy
    func body(content: Content) -> some View {
        let minEdge = min(proxy.size.width,
                          proxy.size.height)
        return content
            .frame(width: minEdge, height: minEdge)
    }
}

extension View {
    func makeSquare(with proxy: GeometryProxy) -> some View {
        self.modifier(MakeSquare(proxy: proxy))
    }
}

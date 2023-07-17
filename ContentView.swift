//
//  ContentView.swift
//  TreeRange
//
//  Created by Dmitry Martynov on 14.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: TreeViewModel
    
    var body: some View {
        
        VStack {
            
            Picker("Input:", selection: $viewModel.inputIndex) {
                ForEach(viewModel.input.indices, id: \.self) { index in           Text(viewModel.input[index])
                        .font(.subheadline)
                }
            }.pickerStyle(.wheel)
            
            Text(viewModel.input[viewModel.inputIndex])
                .padding(.vertical, 10)
            
            ForEach(viewModel.treeData) { node in
                
                HStack {
                    
                    Text(node.value)
                        .font(.bold(.body)())
                        .padding(.leading, CGFloat(node.spacing * 10))
                    Spacer()
                }
            }
        }
        Spacer()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}

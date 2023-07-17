//
//  TreeViewModel.swift
//  TreeRange
//
//  Created by Dmitry Martynov on 16.07.2023.
//

import SwiftUI
import Combine

class TreeViewModel: ObservableObject {
    
    @Published var treeData: [Item] = []
    @Published var input: [String]
    @Published var inputIndex: Int = 0
    
    private var model = Model()
    private var bindings = Set<AnyCancellable>()
    
    init() {
       
        self.input = model.input.map { $0.description }
        bind()
    }
    
    struct Item :Identifiable {
        
        let id = UUID()
        let value: String
        let spacing: Int
    }
    
    func bind() {
        
        $inputIndex
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] index in
                
                treeData = []
                self.model.reduce(self.model.input[index])
                self.model.tree.forEachDepth { node in
                    withAnimation(Animation.easeInOut(duration: 1)) {
                        treeData.append(.init(value: node.value, spacing: node.level))
                    }
                }
            }.store(in: &bindings)  
    }
}

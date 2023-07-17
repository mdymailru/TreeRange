//
//  Model.swift
//  TreeRange
//
//  Created by Dmitry Martynov on 16.07.2023.
//

struct Model {
    
    let input =  [
                    ["B2,E5,F6", "A1,B2,C3,D4", "D4,G7,I9", "G7,H8"],
                    ["G7,H8", "B2,E5,F6", "A1,B2,C3,D4", "D4,G7,I9"],
                    ["G7,H8", "B2,E5,F6", "A1,B2,C3,D4", "D4,G7,I9", "A0,U0"],
                    ["G7,H8", "B2,E5,F6", "A1,B2,C3,D4", "D4,G7,I9", "H8,U0"]
    ]
    
    let tree: TreeNode<String> = .init(value: "root")
    
    mutating func reduce(_ input: [String]) {
        
        tree.children = []
    
        for element in input {
            
            let division = element.components(separatedBy: ",")
            
            if let chef = division.first {
            
                let chefNode = TreeNode<String>(value: chef)
                                                    
                division.dropFirst().forEach {
                    let child = TreeNode<String>(value: $0)
                    chefNode.addChild(child)
                }
                
                tree.addChild(chefNode)
                tree.children.sort { $0.value < $1.value }
            }
        }
        
        print(tree)
        
        let chefs = tree.children.filter { !$0.children.isEmpty }
        
        for chef in chefs {
            
            if let node = tree.search(chef.value, withChildren: false) {
                
                chef.children.forEach { node.addChild($0) }
                chef.parent?.children.removeAll { $0 === chef }
                chef.children = []
            }
        }
        
        print(tree)
        
    }
}

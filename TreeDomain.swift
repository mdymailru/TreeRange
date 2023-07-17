//
//  TreeDomain.swift
//  TreeRange
//
//  Created by Dmitry Martynov on 17.07.2023.
//

import Foundation

public class TreeNode<T> where T: Equatable {
    public var value: T

    public weak var parent: TreeNode?
    public var children = [TreeNode<T>]()
    public var level: Int = 0

    public init(value: T) {
        self.value = value
    }

    public func forEachDepth(work: (TreeNode) -> Void) {
        
        work(self)
        children.forEach { $0.forEachDepth(work: work) }
    }
        
    public func forEachLevel(work: (TreeNode) -> Void) {
        
        work(self)
        var queue = children
        
        while let node = queue.first {
            work(node)
            queue.append(contentsOf: node.children)
            queue = Array(queue.dropFirst())
        }
    }
    
    public func search(_ value: T, withChildren: Bool) -> TreeNode? {
        var result: TreeNode?
        forEachLevel { node in
            if node.value == value,
               node.children.isEmpty != withChildren { result = node }
        }
        return result
    }
    
  public func addChild(_ node: TreeNode<T>) {
      children.append(node)
      node.parent = self
      node.forEachLevel {
          $0.level = ($0.parent?.level ?? 0) + 1
      }
  }
    
}

extension TreeNode: CustomStringConvertible {
  public var description: String {
    var s = "\(value)"
    if !children.isEmpty {
        s += " {" + children.map { $0.description + "-\($0.level)" }.joined(separator: ", ") + "}"
    }
    return s
  }
}

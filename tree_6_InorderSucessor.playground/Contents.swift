//: Playground - noun: a place where people can play

// Inorder Successor of an BST node //

import UIKit

class Node {

    var data : Int?
    var left : Node?
    var right : Node?
    var parent : Node?
    
    init(val : Int) {
        data = val
        left = nil
        right = nil
        parent = nil
    }
}

class BST {
    var root : Node?
    
    // insert to BST 
    
    public func insert(val : Int, root : Node?) -> Node {
    
        if let root = root, let rootVal = root.data {
            
            if val < rootVal {
                root.left = insert(val: val, root: root.left)
                root.left?.parent = root
            
            } else if val > rootVal {
                root.right = insert(val: val, root: root.right)
                root.right?.parent = root
            }
            return root
            
        } else {
            return Node(val: val)
        }
    }
    
    // inorder 
    
    public func inorder(root : Node?) {
        guard let root = root else { return }
        inorder(root: root.left)
        print(root.data ?? -1 , terminator : " ")
        inorder(root: root.right)
        
    }
    
    // find min 
    public func findMin(root : Node?) -> Int? {
        guard let root = root else { return nil }
        
        var tempRoot : Node? = root
        while tempRoot?.left != nil {
            tempRoot = tempRoot?.left
        }
        return tempRoot?.data
    }
    
    // find ancestor so that node is the right child of ancestor
    public func ancestor(node : Node?) -> Node? {
        guard let node = node else { return nil }
        
        var tempNode : Node? = node
        while true {
            if let parentVal = tempNode?.parent?.data , let nodeVal = node.data , parentVal < nodeVal {
                 tempNode = tempNode?.parent
            } else {
                break
            }
        }
        return tempNode?.parent
    }

    // search
    public func search(root : Node? , val : Int) -> Node? {
        if let root = root, let rootval = root.data {
            if val < rootval {
               return search(root: root.left, val: val)
            } else if val > rootval {
                return search(root:root.right, val: val)
            } else {
                return root
            }
        }
        return nil
    }
    
    // do inorder successor
    
    public func inorderSuccessor(root : Node?, val : Int) -> Int? {
        guard let root = root else { return nil }
        
        // find node first 
        if let node = search(root: root, val: val) {
            
            // check right tree is present or not
            
            if node.right != nil {
                if let minVal = findMin(root: node.right) {
                    return minVal
                }
            } else { // find out in ancestor
                if let ancestorNode = ancestor(node: node) {
                    return ancestorNode.data
                }
            }
        }
        return nil
    }
}

let bst = BST()
bst.root = nil

bst.root = bst.insert(val: 20, root: bst.root)
bst.insert(val: 8, root: bst.root)
bst.insert(val: 22, root: bst.root)
bst.insert(val: 4, root: bst.root)
bst.insert(val: 12, root: bst.root)
bst.insert(val: 10, root: bst.root)
bst.insert(val: 14, root: bst.root)

bst.inorder(root: bst.root)

// testing
if let successor = bst.inorderSuccessor(root: bst.root, val: 8) {
    print("\nInorder Successor of 8 = \(successor)")
} else {
    print("No Successor")
}

if let successor = bst.inorderSuccessor(root: bst.root, val: 10) {
    print("\nInorder Successor of 10 = \(successor)")
} else {
    print("No Successor")
}

if let successor = bst.inorderSuccessor(root: bst.root, val: 22) {
    print("\nInorder Successor of 14 = \(successor)")
} else {
    print("No Successor of 22")
}

if let successor = bst.inorderSuccessor(root: bst.root, val: 14) {
    print("\nInorder Successor of 14 = \(successor)")
} else {
    print("No Successor")
}


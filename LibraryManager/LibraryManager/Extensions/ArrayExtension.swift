//
//  ArrayExtension.swift
//  Sổ Y Bạ
//
//  Created by Nam Phong on 7/16/15.
//  Copyright (c) 2015 Phong Nguyen Nam. All rights reserved.
//

import Foundation


internal extension Array {
    /**
    Checks if self contains a list of items.
    
    - parameter items: Items to search for
    - returns: true if self contains all the items
    */
    func contains <T: Equatable> (items: T...) -> Bool {
        return items.all { self.indexOf($0) >= 0 }
    }
    
 
    
    /**
    Checks if test returns true for all the elements in self
    
    - parameter test: Function to call for each element
    - returns: True if test returns true for all the elements in self
    */
    func all (test: (Element) -> Bool) -> Bool {
        for item in self {
            if !test(item) {
                return false
            }
        }
        
        return true
    }
    
    /**
    Index of the first occurrence of item, if found.
    
    - parameter item: The item to search for
    - returns: Index of the matched item or nil
    */
    func indexOf <U: Equatable> (item: U) -> Int? {
        if item is Element {
            return unsafeBitCast(self, [U].self).indexOf(item)
        }
        
        return nil
    }
    
    /**
    Index of the first item that meets the condition.
    
    - parameter condition: A function which returns a boolean if an element satisfies a given condition or not.
    - returns: Index of the first matched item or nil
    */
    func indexOf (condition: Element -> Bool) -> Int? {
        for (index, element) in self.enumerate() {
            if condition(element) {
                return index
            }
        }
        
        return nil
    }
    
    /**
    First element of the array.
    
    - returns: First element of the array if not empty
    */
    @available(*, unavailable, message="use the 'first' property instead") func first () -> Element? {
        return first
    }
    
    /**
    Last element of the array.
    
    - returns: Last element of the array if not empty
    */
    @available(*, unavailable, message="use the 'last' property instead") func last () -> Element? {
        return last
    }
    
    /**
    Gets the object at the specified index, if it exists.
    
    - parameter index:
    - returns: Object at index in self
    */
    func get (index: Int) -> Element? {
        
        return index >= 0 && index < count ? self[index] : nil
        
    }
    
    /**
    Iterates on each element of the array.
    
    - parameter call: Function to call for each element
    */
    func each (call: (Element) -> ()) {
        
        for item in self {
            call(item)
        }
        
    }
    
    /**
    Iterates on each element of the array with its index.
    
    - parameter call: Function to call for each element
    */
    func each (call: (Int, Element) -> ()) {
        
        for (index, item) in self.enumerate() {
            call(index, item)
        }
        
    }
    
    /**
    Deletes all the items in self that are equal to element.
    
    - parameter element: Element to remove
    */
    mutating func remove <U: Equatable> (element: U) {
        let anotherSelf = self
        
        removeAll(keepCapacity: true)
        
        anotherSelf.each {
            (index: Int, current: Element) in
            if (current as! U) != element {
                self.append(current)
            }
        }
    }
    

}
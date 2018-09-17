//
//  Functions.swift
//  Koray Birand Digital
//
//  Created by Koray Birand on 4/6/15.
//  Copyright (c) 2015 Koray Birand. All rights reserved.
//

import Foundation

class koray {
    
    
    
    
    class func leftString(_ theString: String, charToGet: Int) ->String{
        
        var indexCount = 0
        let strLen = theString.count
        
        if charToGet > strLen { indexCount = strLen } else { indexCount = charToGet }
        if charToGet < 0 { indexCount = 0 }
        
        let index: String.Index = theString.index(theString.startIndex, offsetBy: indexCount)
        let mySubstring:String = String(theString[..<index])
        
        return mySubstring
        
    }
    
    class func rightString(_ theString: String, charToGet: Int) ->String{
        
        var indexCount = 0
        let strLen = theString.count
        let charToSkip = strLen - charToGet
        
        if charToSkip > strLen { indexCount = strLen } else { indexCount = charToSkip }
        if charToSkip < 0 { indexCount = 0 }
        let index: String.Index = theString.index(theString.startIndex, offsetBy: indexCount)
        let mySubstring:String = String(theString[index...])
        
        
        return mySubstring
    }
    
    class func midString(_ theString: String, startPos: Int, charToGet: Int) ->String{
        
        let strLen = theString.count
        let rightCharCount = strLen - startPos
        var mySubstring = koray.rightString(theString, charToGet: rightCharCount)
        mySubstring = koray.leftString(mySubstring, charToGet: charToGet)
        
        return mySubstring
        
    }
    
    

    
    
}

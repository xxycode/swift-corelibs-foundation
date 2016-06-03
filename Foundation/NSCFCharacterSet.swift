//
//  NSCFCharacterSet.swift
//  Foundation
//
//  Created by Philippe Hausler on 6/3/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import CoreFoundation

internal class _NSCFCharacterSet : NSMutableCharacterSet {
    
    required init(coder aDecoder: NSCoder) {
        fatalError("Coding is not supported for bridge classes")
    }
    
    override func characterIsMember(_ aCharacter: unichar) -> Bool {
        return CFCharacterSetIsCharacterMember(_cfObject, UniChar(aCharacter))
    }
    
    override var bitmapRepresentation: Data {
        return CFCharacterSetCreateBitmapRepresentation(kCFAllocatorSystemDefault, _cfObject)._swiftObject
    }
    
    override var inverted: CharacterSet {
        return CFCharacterSetCreateInvertedSet(kCFAllocatorSystemDefault, _cfObject)._swiftObject
    }
    
    override func longCharacterIsMember(_ theLongChar: UTF32Char) -> Bool {
        return CFCharacterSetIsLongCharacterMember(_cfObject, theLongChar)
    }
    
    override func isSuperset(of theOtherSet: CharacterSet) -> Bool {
        return CFCharacterSetIsSupersetOfSet(_cfObject, theOtherSet._cfObject)
    }
    
    override func hasMember(inPlane plane: UInt8) -> Bool {
        return CFCharacterSetHasMemberInPlane(_cfObject, CFIndex(plane))
    }
    
    override func copy() -> AnyObject {
        return copy(with: nil)
    }
    
    override func copy(with zone: NSZone? = nil) -> AnyObject {
        return CFCharacterSetCreateCopy(kCFAllocatorSystemDefault, self._cfObject)
    }
    
    override func mutableCopy(with zone: NSZone? = nil) -> AnyObject {
        return CFCharacterSetCreateMutableCopy(kCFAllocatorSystemDefault, _cfObject)._nsObject
    }
    
    
    override func addCharacters(in aRange: NSRange) {
        CFCharacterSetAddCharactersInRange(_cfMutableObject , CFRangeMake(aRange.location, aRange.length))
    }
    
    override func removeCharacters(in aRange: NSRange) {
        CFCharacterSetRemoveCharactersInRange(_cfMutableObject , CFRangeMake(aRange.location, aRange.length))
    }
    
    override func addCharacters(in aString: String) {
        CFCharacterSetAddCharactersInString(_cfMutableObject, aString._cfObject)
    }
    
    override func removeCharacters(in aString: String) {
        CFCharacterSetRemoveCharactersInString(_cfMutableObject, aString._cfObject)
    }
    
    override func formUnion(with otherSet: CharacterSet) {
        CFCharacterSetUnion(_cfMutableObject, otherSet._cfObject)
    }
    
    override func formIntersection(with otherSet: CharacterSet) {
        CFCharacterSetIntersect(_cfMutableObject, otherSet._cfObject)
    }
    
    override func invert() {
        CFCharacterSetInvert(_cfMutableObject)
    }
}

internal  func _CFSwiftCharacterSetExpandedCFCharacterSet(_ cset: CFTypeRef) -> Unmanaged<CFCharacterSet>? {
    return nil
}

internal  func _CFSwiftCharacterSetRetainedBitmapRepresentation(_ cset: CFTypeRef) -> Unmanaged<CFData> {
    NSUnimplemented()
}

internal  func _CFSwiftCharacterSetCharacterIsMember(_ cset: CFTypeRef, _ ch: UniChar) -> Bool {
    return (cset as! NSCharacterSet).characterIsMember(ch)
}

internal  func _CFSwiftCharacterSetMutableCopy(_ cset: CFTypeRef) -> Unmanaged<CFMutableCharacterSet> {
    return Unmanaged.passRetained((cset as! NSCharacterSet).mutableCopy() as! CFMutableCharacterSet)
}

internal  func _CFSwiftCharacterSetLongCharacterIsMember(_ cset: CFTypeRef, _ ch:UTF32Char) -> Bool {
    return (cset as! NSCharacterSet).longCharacterIsMember(ch)
}

internal  func _CFSwiftCharacterSetHasMemberInPlane(_ cset: CFTypeRef, _ plane: UInt8) -> Bool {
    return (cset as! NSCharacterSet).hasMember(inPlane: plane)
}

internal  func _CFSwiftCharacterSetInverted(_ cset: CFTypeRef) -> Unmanaged<CFCharacterSet> {
    return Unmanaged.passRetained((cset as! NSCharacterSet).inverted._cfObject)
}

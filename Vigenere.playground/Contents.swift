//: Playground - noun: a place where people can play

import UIKit

class Cipher
{
    static let shared = Cipher()
    private init() {}
    
    enum Action {
        case Encryption
        case Decryption
    }
    
    func perform(action: Action, text: String, keyword: String) -> String
    {
        let text = text.lowercaseString
        let key = self.key(text, keyword: keyword).lowercaseString
        let map = self.map(self.alphabet)
        var output = String()
        
        for (index, character) in text.characters.enumerate() {
            if character == self.space {
                output.append(character)
            }
                
            else {
                if let textCharIndex = map.forward[String(character)], keyCharIndex = map.forward[String(key[key.startIndex.advancedBy(index)])] {
                    let outputIndex = (action == .Encryption) ? (textCharIndex + keyCharIndex + map.lastCharacterIndex) % map.lastCharacterIndex : (textCharIndex - keyCharIndex + map.lastCharacterIndex) % map.lastCharacterIndex
                    if let encryptedCharacter = map.reversed[outputIndex] {
                        output.appendContentsOf(encryptedCharacter)
                    }
                }
            }
        }
        
        return (action == .Encryption) ? output.uppercaseString : output
    }
    
    // MARK: Private Variables
    
    private let alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    private let space: Character = " "
    
    // MARK: Private Functions
    
    private func key(text: String, keyword: String) -> String
    {
        var key = String()
        var count = 0
        
        for character in text.characters {
            if character == self.space {
                key.append(character)
            }
                
            else {
                key.append(keyword[keyword.startIndex.advancedBy(count)])
                count = (count == keyword.characters.count.predecessor()) ? 0 : count + 1
            }
        }
        
        return key
    }
    
    private func map(alphabet: [String]) -> (forward: [String : Int], reversed: [Int : String], lastCharacterIndex: Int)
    {
        var forward = [String : Int]()
        var reversed = [Int : String]()
        var lastCharacterIndex = 0
        
        for (index, letter) in alphabet.enumerate() {
            forward[letter] = index
            reversed[index] = letter
            lastCharacterIndex = index
        }
        
        return (forward: forward, reversed: reversed, lastCharacterIndex: lastCharacterIndex)
    }
}

let text = "Whenever you find yourself on the side of the majority it is time to pause and reflect."
let key = "MarkTwain"

let encrypted = Cipher.shared.perform(.Encryption, text: text, keyword: key)
let decrypted = Cipher.shared.perform(.Decryption, text: "JHVXXSEA MBU WSHA YWIESVVY LN CUQ SANX LF CUQ MRTIOICM UT AD NFMM HB PRFMB AVQ EEWVXYT", keyword: key)

print(" Original: \(text)")
print("      Key: \(key)")
print("Encrypted: \(encrypted)")
print("Decrypted: \(decrypted)")

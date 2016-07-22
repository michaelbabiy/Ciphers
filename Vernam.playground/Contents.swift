//: Playground - noun: a place where people can play

import UIKit

class Cipher
{
    static let shared = Cipher()
    private init() {}
    
    func encrypt(text: String) -> (text: String, key: [Int])
    {
        let text = text.lowercased()
        let key = self.key(count: text.characters.count)
        let map = self.map()
        var output = String()
        
        for (index, character) in text.characters.enumerated() {
            if character == " " {
                output.append(character)
            }
            
            else {
                if let letterIndex = map.forward[String(character)] {
                    let keyIndex = key[index]
                    let outputIndex = (letterIndex + keyIndex + map.lastCharacterIndex) % map.lastCharacterIndex
                    if let outputCharacter = map.reversed[outputIndex] {
                        output.append(outputCharacter)
                    }
                }
            }
        }
        
        return (text: output.uppercased(), key: key)
    }
    
    func decrypt(text: String, key:[Int]) -> String
    {
        let text = text.lowercased()
        let map = self.map()
        var output = String()
        
        for (index, character) in text.characters.enumerated() {
            
            if character == " " {
                output.append(character)
            }
                
            else {
                if let letterIndex = map.forward[String(character)] {
                    let keyIndex = key[index]
                    let outputIndex = (letterIndex - keyIndex + map.lastCharacterIndex) % map.lastCharacterIndex
                    if let outputCharacter = map.reversed[outputIndex] {
                        output.append(outputCharacter)
                    }
                }
            }
            
        }
        
        return output
    }
    
    // MARK: Helper Functions
    
    private let alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    
    private func key(count: Int) -> [Int]
    {
        var key = [Int]()
        
        for _ in 0..<count {
            key.append(Int(arc4random() % 26))
        }
        
        return key
    }
    
    private func map() -> (forward: [String : Int], reversed: [Int : String], lastCharacterIndex: Int)
    {
        var forward = [String : Int]()
        var reversed = [Int : String]()
        var lastCharacterIndex = 0
        
        for (index, letter) in self.alphabet.enumerated() {
            forward[letter] = index
            reversed[index] = letter
            lastCharacterIndex = index
        }
        
        return (forward: forward, reversed: reversed, lastCharacterIndex: lastCharacterIndex)
    }
}

let text = "The day you think there is no improvements to be made is a sad one for any player." // L. Messi
let encrypted = Cipher.shared.encrypt(text: text)
let decrypted = Cipher.shared.decrypt(text: encrypted.text, key: encrypted.key)

print(" Original: \(text)")
print("Encrypted: \(encrypted.text)")
print("Decrypted: \(decrypted)")

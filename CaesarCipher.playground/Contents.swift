//: Playground - noun: a place where people can play

import UIKit

class Cipher
{
    func encrypt(text: String, keyword: String) -> String
    {
        let text = text.lowercaseString
        let key = self.key(keyword)
        let alphabet = self.alphabet(key)
        let map = self.map(alphabet).encryption
        
        var encrypted = String()
        
        for character in text.characters {
            if character == " " { encrypted.appendContentsOf(":") }
            if let string = map[String(character)] {
                encrypted.appendContentsOf(string)
            }
        }
        
        return encrypted.uppercaseString
    }
    
    func decrypt(text: String, keyword: String) -> String
    {
        let text = text.lowercaseString
        let key = self.key(keyword)
        let alphabet = self.alphabet(key)
        let map = self.map(alphabet).decryption
        
        var decrypted = String()
        
        for character in text.characters {
            if character == ":" {
                decrypted.appendContentsOf(" ")
            }
            
            else if let string = map[String(character)] {
                decrypted.appendContentsOf(string)
            }
        }
        
        return decrypted
    }
    
    // Get all unique letter from the entered keyword...
    
    private func key(keyword: String) -> String
    {
        var string = String()
        for character in keyword.characters {
            if !string.containsString(String(character)) {
                string.append(character)
            }
        }
        
        return string.lowercaseString
    }
    
    // MARK: Encryption / decryption map based on the key.
    
    private func map(reversed: [String]) -> (encryption: [String : String], decryption: [String : String])
    {
        var encryption = [String : String]()
        var decryption = [String : String]()
        
        for (index, letter) in reversed.enumerate() {
            encryption[self.alphabet[index]] = letter
            decryption[letter] = self.alphabet[index]
        }
        
        return (encryption: encryption, decryption: decryption)
    }
    
    private let alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    
    // MARK: Helper functions.
    
    private func alphabet(key: String) -> [String]
    {
        var alphabet = self.alphabet
        
        for (idx, char) in key.characters.enumerate() {
            if let index = alphabet.indexOf(String(char)) {
                let element = alphabet.removeAtIndex(index)
                alphabet.insert(element, atIndex: idx)
            }
        }
        
        return self.reversed(alphabet)
    }
    
    private func reversed(alphabet: [String]) -> [String]
    {
        var alphabet = alphabet
        var startIndex = alphabet.startIndex
        var endIndex = alphabet.endIndex.predecessor()
        
        for _ in 0..<alphabet.count / 2 {
            
            let sString = alphabet[startIndex]
            let eString = alphabet[endIndex]
            
            alphabet.removeAtIndex(startIndex)
            alphabet.insert(eString, atIndex: startIndex)
            
            alphabet.removeAtIndex(endIndex)
            alphabet.insert(sString, atIndex: endIndex)
            
            startIndex = startIndex.successor()
            endIndex = endIndex.predecessor()
        }
        
        return alphabet
    }
}

let cipher = Cipher()
let encrypted = cipher.encrypt("When can I buy new shoes, honey?", keyword: "shoes")
print(encrypted)

let decrypted = cipher.decrypt("ERVK:XZK:Q:YBH:KVE:DRJVD:RJKVH", keyword: "shoes")
print("\n\(decrypted)")


//: Playground - noun: a place where people can play

import UIKit

class Cipher
{
    func encrypt(text: String, keyword: String) -> String
    {
        let text = text.lowercased()
        let key = self.key(keyword: keyword)
        let alphabet = self.alphabet(key: key)
        let map = self.map(reversed: alphabet).encryption
        
        var encrypted = String()
        
        for character in text.characters {
            if character == " " { encrypted.append(":") }
            if let string = map[String(character)] {
                encrypted.append(string)
            }
        }
        
        return encrypted.uppercased()
    }
    
    func decrypt(text: String, keyword: String) -> String
    {
        let text = text.lowercased()
        let key = self.key(keyword: keyword)
        let alphabet = self.alphabet(key: key)
        let map = self.map(reversed: alphabet).decryption
        
        var decrypted = String()
        
        for character in text.characters {
            if character == ":" {
                decrypted.append(" ")
            }
            
            else if let string = map[String(character)] {
                decrypted.append(string)
            }
        }
        
        return decrypted
    }
    
    // Get all unique letter from the entered keyword...
    
    private func key(keyword: String) -> String
    {
        var string = String()
        for character in keyword.characters {
            if !string.contains(String(character)) {
                string.append(character)
            }
        }
        
        return string.lowercased()
    }
    
    // MARK: Encryption / decryption map based on the key.
    
    private func map(reversed: [String]) -> (encryption: [String : String], decryption: [String : String])
    {
        var encryption = [String : String]()
        var decryption = [String : String]()
        
        for (index, letter) in reversed.enumerated() {
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
        
        for (idx, char) in key.characters.enumerated() {
            if let index = alphabet.index(of: String(char)) {
                let element = alphabet.remove(at: index)
                alphabet.insert(element, at: idx)
            }
        }
        
        return self.reversed(alphabet: alphabet)
    }
    
    private func reversed(alphabet: [String]) -> [String]
    {
        var alphabet = alphabet
        var startIndex = alphabet.startIndex
        var endIndex = alphabet.endIndex - 1
        
        for _ in 0..<alphabet.count / 2 {
            
            let sString = alphabet[startIndex]
            let eString = alphabet[endIndex]
            
            alphabet.remove(at: startIndex)
            alphabet.insert(eString, at: startIndex)
            
            alphabet.remove(at: endIndex)
            alphabet.insert(sString, at: endIndex)
            
            startIndex = startIndex + 1
            endIndex = endIndex - 1
        }
        
        return alphabet
    }
}

let cipher = Cipher()
let encrypted = cipher.encrypt(text: "When can I buy new shoes, honey?", keyword: "shoes")
print(encrypted)

let decrypted = cipher.decrypt(text: "ERVK:XZK:Q:YBH:KVE:DRJVD:RJKVH", keyword: "shoes")
print(decrypted)

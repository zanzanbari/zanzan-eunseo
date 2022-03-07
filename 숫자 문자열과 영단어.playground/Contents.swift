import Foundation

func solution(_ s:String) -> Int {
    let englishWord = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    var result = s
    
    for number in 0...englishWord.count-1 {
        result = result.replacingOccurrences(of: englishWord[number], with: "\(number)")
    }
    
    return Int(result)!
}

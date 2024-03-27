//
//  EjerciciosPracticos.swift
//  ClipInterview
//
//  Created by Sergio Andres Rodriguez Castillo on 27/03/24.
//

import Foundation

class EjerciciosPracticos {
    /*
     Ejercicio practico 1
     Dados cinco números enteros positivos, se deberan encontrar los valores mínimo y máximo que se puedan calcular sumando exactamente cuatro de los cinco números enteros. Luego se deberán imprimir los valores mínimo y máximo respectivos como una sola línea de dos enteros largos separados por espacios.
     
     Ejemplo 1: [1,3,5,7,9] imprimira: 16 24
     
     Ejemplo 2: 1 2 3 4 5 imprimira: 10 14
     */
    
    func maxAndMinSumForNumberSeries(_ series: [Int]) {
        var minSum = 0
        var maxSum = 0
        var currentIndex = 0
        
        repeat {
            minSum += series[currentIndex]
            currentIndex += 1
        } while currentIndex < series.count - 1
        
        currentIndex = series.count - 1
        
        repeat {
            maxSum += series[currentIndex]
            currentIndex -= 1
        } while currentIndex >= 1
        
        print("\(minSum) \(maxSum)")
    }
    
    func maxAndMinSumForNumberSeriesSecondSolution(_ series: [Int]) {
        var minSum = 0
        var maxSum = 0
        let maxSumArr = series.sorted().dropFirst()
        let minSumArr = series.sorted().dropLast()
        
        for number in maxSumArr {
            maxSum += number
        }
        
        for number in minSumArr {
            minSum += number
        }
        
        print("\(minSum) \(maxSum)")
    }
    
    
    /*
     Ejercicio practico 2
     Se considera una cadena de caracteres válida si todos los caracteres de la cadena aparecen el mismo número de veces. También es válida si se elimina solo un caracter en un índice de la cadena y los caracteres restantes aparecerán la misma cantidad de veces. Dada una cadena, se deberá determinar si la misma es válida. Si es así, se devolverá el string YES; de lo contrario, se deberá devoler el string NO.
     
     Ejemplo 1: s = abc devuelve YES
     
     Ejemplo 2: s = abcc devuelve YES
     
     Ejemplo 3: s = abccc devuelve NO
     */
    
    func validateString(_ string: String) -> String {
        var isValidString = true
        
        for char in string {
            if numberOfOccurrencesOfCharacter(char, inString: string) > 2 {
                isValidString = false
            }
        }
        
        return isValidString ? "YES" : "NO"
    }
    
    private func numberOfOccurrencesOfCharacter(_ char: Character, inString string: String) -> Int {
        var count = 0
        
        for ocurrentCharacter in string {
            if ocurrentCharacter == char {
                count += 1
            }
        }
        return count
    }
}

import UIKit

// Задание 1. Квадратное уравнение
let a: Double = 1
let b: Double = 2
let c: Double = 1
var x1: Double
var x2: Double
let D: Double = b * b - 4 * a * c

if D < 0 {
    print( "Уравнение не имеет корней!")
} else if D == 0
        {
            x1 = (-b / (2 * a))
            print("Уравнение имеет один корень x=", x1)
} else {
    x1 = (-b + sqrt(D)) / (a * 2)
    x2 = (-b - sqrt(D)) / (a * 2)
    print ("Уравнение имеет два корня x1=", x1, "; x2=", x2)
        }

//Задание 2. Прямоугольный треугольник
let katet1 = 50
let katet2 = 120

let gipotenuza: Double = sqrt(Double(katet1 * katet1) + Double(katet1 * katet1))
let s: Double = (Double(katet1) * Double(katet2)) / 2
let p: Double = Double(katet1) + Double(katet2) + gipotenuza
print("В треугольнике с катетом один - ", katet1, " и катетом два - ", katet2, ":")
print("Гипотенуза равна: ", gipotenuza)
print("Площадь равна: ", s)
print("Перимитр равен: ", p)

//Задание 3. Банковский вклад

let depozit = 5005
let stavka = 1.5
var vklad1: Double = Double(depozit)
var vklad2: Double = Double(depozit)
var i = 0
while i < 5 {
    i+=1
    vklad1 = Double(vklad1) + Double(depozit) * (Double(stavka) / 100)
    vklad2 = Double(vklad2) + Double(vklad2) * (Double(stavka) / 100)
}

print("За 5 лет на счету будет(Простой процент): ", vklad1)
print("За 5 лет на счету будет(Cложный процент): ", vklad2)


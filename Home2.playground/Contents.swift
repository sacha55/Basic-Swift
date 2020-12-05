import UIKit

var str = "Hello, playground"

func delto2(a: Int) ->  Bool // Функция для определения деления на 2
{
    let b = a % 2
    if b == 0
    {
        return true
    }
    else
    {
        return false
    }
}

func delto3(a: Int) ->  Bool // Функция для определения деления на 3
{
    let b = a % 3
    if b == 0
    {
        return true
    }
    else
    {
        return false
    }
}

func SampleFillingArray(index: Int, step: Int) -> [Int] // Функция формирует массив от 1 до n с шагом Step
{
    var newArray: [Int] = [1]
    for n in 1...index-1
    {
        newArray.append(newArray[n-1]+step)
    }
    return newArray
}

func deletedelto2(Array: [Int]) -> [Int] // Функция удаляет все четные числа из массива числа
{
    var newArray = Array
    var n = 0
    var check: Bool
    while n < newArray.count
    {
        check = delto2(a: newArray[n])
        if check == true
        {
            newArray.remove(at: n)
        }
        else
        {
            n += 1
        }
    }
    return newArray
}

func notdeletedelto3(Array: [Int]) -> [Int] //Функция удаляет все числа которые не делятся на 3
{
    var newArray = Array
    var n = 0
    var check: Bool
    while n < newArray.count
    {
        check = delto3(a: newArray[n])
        if check == false
        {
            newArray.remove(at: n)
        }
        else
        {
            n += 1
        }
    }
    return newArray
}

func SummSting (Sx: String, Sy: String) -> String // Функция для сложение двух чисел записанных в типе String
{
    var x = Sx
    var y = Sy
    let xlenght = x.count
    let ylenght = y.count
    var n: Int
    var temp_xy_int = 0
    var temp_xy: Character
    var temp_xy_str: String

    // Проверяем разные ли длины чисел. За основу берем понимание что разница в длине может быть только на один символ. Возникшей излишек прибавим в конце функции
    if xlenght == ylenght
    {
        n = xlenght-1
    }
    else if xlenght < ylenght
        {
            n = xlenght-1
            temp_xy = y.first!
            temp_xy_str = String(temp_xy)
            temp_xy_int = Int(temp_xy_str)!
        }
        else
        {
            n = ylenght-1
            temp_xy = x.first!
            temp_xy_str = String(temp_xy)
            temp_xy_int = Int(temp_xy_str)!
        }
    var temp_x: Character
    var temp_x_str: String
    var temp_x_int: Int
    var temp_y: Character
    var temp_y_str: String
    var temp_y_int: Int
    var temp_summ: Int
    var z = 0 // Храним десяток
    var summ: String = ""
    for _ in 0...n
    {
        // Забираем последние символы и делаем из них цифры
        temp_x = x.last!
        temp_x_str = String(temp_x)
        temp_x_int = Int(temp_x_str)!
        temp_y = y.last!
        temp_y_str = String(temp_y)
        temp_y_int = Int(temp_y_str)!
        
        //Складываем и отделяем десяток
        temp_summ = temp_x_int + temp_y_int + z
        if temp_summ > 9
        {
            temp_summ %= 10
            z = 1
        }
        else
        {
            z = 0
        }
        // Добавляем остаток от деления к результируещему числу (вперед)
        summ = String(temp_summ) + summ
        x.removeLast()
        y.removeLast()
    }
    // Проверяем итоговый десяток и добавляем вперед вместе с изначальным излишком (разница длины двух чисел)
    if (z + temp_xy_int) != 0
    {
        summ = String(z + temp_xy_int) + summ
    }

    return summ
}


func FiboFillingArray93(index: Int) -> [UInt64] // Функция формирует массив числами фибоначи от 1 до n (макс значение n - 93)
{
    var newArray: [UInt64] = [0]
    if index == 1
    {
        return newArray
    }
    else if index == 2
        {
        newArray.append(1)
        return newArray
        }
        else
        {
            newArray.append(1)
            for n in 2...index
            {
                newArray.append(newArray[n-2]+newArray[n-1])
            }
        }
    return newArray
}

func FiboFillingArray100(index: Int) -> [String] // Функция формирует массив числами фибоначи от 1 до n типа String
{
    var newArray: [String] = ["0"]
    if index == 1
    {
        return newArray
    }
    else if index == 2
        {
        newArray.append("1")
        return newArray
        }
        else
        {
            newArray.append("1")
            for n in 2...index
            {
                newArray.append(SummSting(Sx: newArray[n-2], Sy: newArray[n-1]))
            }
        }
    return newArray
}

func SimpleNumber (x: Int) -> [Int]  // Функция формирует массив простых чисел из масcива от 2 до X
{
    var SimpleNumberArray = Array(2...x)
    var n = SimpleNumberArray.count-1
    var n2 = 0
    var p = SimpleNumberArray[n2]

    while n != n2
    {
        while n != n2
        {
            if SimpleNumberArray[n]%p == 0
            {
                SimpleNumberArray.remove(at: n)
            }
            n -= 1
        }
        n = SimpleNumberArray.count-1
        n2 += 1
        p = SimpleNumberArray[n2]
    }
    return SimpleNumberArray
}


// проверка задания №1
let a = 6
var b = delto2(a: a)
print(b)

// проверка задания №2
b = delto3(a: a)
print(b)

// проверка задания №3
var SimpleArray = SampleFillingArray(index: 100, step: 1)
print(SimpleArray)

let SimpleArray2 = Array(1...100) // Ну или простой способ
print(SimpleArray2)

// проверка задания №4
SimpleArray = deletedelto2(Array: SimpleArray)
print(SimpleArray)

SimpleArray = notdeletedelto3(Array: SimpleArray)
print(SimpleArray)

// проверка задания №5

let FiboArray = FiboFillingArray93(index: 93)
let FiboArrayStr = FiboFillingArray100(index: 200)
print(FiboArray)
print(FiboArrayStr)

// проверка задания №6
let SimpleNumberArray = SimpleNumber(x: 541)
print(SimpleNumberArray)

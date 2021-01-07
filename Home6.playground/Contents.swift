import UIKit

var str = "Hello, playground"

struct NameCar {
    var model: String
    var classCar: Character
}

extension NameCar: CustomStringConvertible {
    var description : String {
        return " \n Модель и марка: \(model), Класс: \(classCar)"
    }
}

struct queue <T> {
    private var elements: [T] = []
    
    public var isEmpty: Bool {
        return elements.count == 0
    }
    
    mutating func add (element: T) {
        elements.append(element)
    }
    mutating func delete() -> T {
        return elements.removeLast()
    }
    
    var first: T? {
        if isEmpty {
            print("Массив пуст!")
            return nil
        } else {
            print("Первый экземпляр: \(elements.first!)")
            return elements.first
        }
    }
    
    var last: T? {
        if isEmpty {
            print("Массив пуст!")
            return nil
        } else {
            print("Последний экземпляр: \(elements.last!)")
            return elements.last
        }
    }
    
    func filter(predicate:(T) -> Bool) -> [T] {
        var result = [T]()
        for i in elements {
            if predicate(i) {
                result.append(i)
            }
        }
        return result
    }
    
    func printQueue() {
        print(elements)
    }
    
    func count () -> Int {
        return self.elements.count
    }
    
}

extension queue {
    subscript(index: Int) -> T?
    {
        if index > self.elements.count {
            return nil
        } else {
            return elements[index]
        }
        
    }
}

var cars = queue<NameCar>()
cars.printQueue()
cars.first
cars.add(element: .init(model: "Kia Picanto", classCar: "A"))
cars.add(element: .init(model: "Volkswagen Polo", classCar: "B"))
cars.add(element: .init(model: "Audi A3", classCar: "C"))
cars.add(element: .init(model: "BMW 745", classCar: "F"))
cars.add(element: .init(model: "Audi A4", classCar: "D"))
cars.add(element: .init(model: "Honda Civic", classCar: "C"))
cars.add(element: .init(model: "Audi A6", classCar: "E"))
cars.add(element: .init(model: "Mercedes-Benz S600", classCar: "F"))

cars.printQueue()
cars.first
cars.last
cars


let premiumCars = cars.filter(predicate: {$0.classCar == "F"})
print(premiumCars)

let index = cars.count() + 1
cars[5]
cars[index]

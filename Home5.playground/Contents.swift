import UIKit

enum Actions
{
    enum Doors
    {
        case open, close
    }
    enum Windows
    {
        case open, close
    }
    enum Engine
    {
        case start, stop
    }
    
    enum Trailer
    {
        case hitch(maxCargoWeight: Int, trailerLenght: Int, trailerWeight: Int), unhook
    }
    
    enum Cargo
    {
        enum Car {
            case putInCar(volume: Int), putInTrunk(volume: Int), remove(volume: Int), empty
        }
        enum TrailerTunk {
            case put(volume: Int), remove(volume: Int), empty
        }
    }
}

protocol Car
{
    var brend: String {get}
    var year: String {get}
    var doorsStatus: Actions.Doors {get set}
    var windowsStatus: Actions.Windows {get set}
    var engineStatus: Actions.Engine {get set}
    var weightCargo: Int {get}
    
    func printStatus ()
    func printCarParametr ()
}

extension Car // Добавляем действие с окном
{
   mutating func doors(Status:Actions.Doors)
   {
       switch Status
       {
       case .open:
           self.doorsStatus = .open
           print("\(brend): Было открыто окно машины!")
       case .close:
           self.doorsStatus = .close
        print("\(brend): Было открыто окно машины!")
       }
   }
}

extension Car // Добавляем действие с дверью
{
   mutating func windows (status:Actions.Windows)
   {
       switch status
       {
       case .open:
           self.windowsStatus = .open
        print("\(brend): Была открыта дверь машины!")
       case .close:
           self.windowsStatus = .close
        print("\(brend): Была закрыта дверь машины!")
       }
   }
}

extension Car // Добавляем действие с двигателем
{
   mutating func engine (status:Actions.Engine)
   {
       switch status
       {
       case .start:
           self.engineStatus = .start
        print("\(brend): Был запущен двигатель машины!")
       case .stop:
           self.engineStatus = .stop
        print("\(brend): Была заглушен двигатель машины!")
       }
   }
}

class SportCar: Car
{
    var brend: String
    var year: String
    var doorsStatus: Actions.Doors = .close
    var windowsStatus: Actions.Windows = .close
    var engineStatus: Actions.Engine = .stop
    var weightCargo: Int = 0
    
    var maxVolumeCar: Int = 0
    var weightCar: Int = 0
    var maxWeightCargo: Int = 0
    var positionCargo: Actions.Cargo.Car = .empty
    var weightWithCargo: Int
    {
        get
        {
            return self.weightCar + self.weightCargo
        }

    }
    func printStatus()
        {
        print("\(brend): Двери в машине: ", doorsStatus)
        print("\(brend): Окна в машине: ", windowsStatus)
        print("\(brend): Двигатель в машине: ",engineStatus)
        }
    
    func printCarParametr()
    {
        print("Марка машины: ", brend)
        print("Год выпуска машины: ", year)
        print ("Вес машины: \(weightCar)")
        print ("Максимальный разрешеный вес машины: \(maxVolumeCar)")
        switch positionCargo
        {
            case .empty:
                print ("Машина без груза!")
            default:
                print ("В машину загруженно: \(weightCargo). Общий вес Машины с грузом составляет: \(weightCar + weightCargo)")
        }
    }
    
    init(brend: String, year: String, maxVolumeCar: Int, weightCar: Int, maxWeightCargo: Int)
    {
        self.brend = brend
        self.year = year
        self.maxVolumeCar = maxVolumeCar
        self.weightCar = weightCar
        self.maxWeightCargo = maxWeightCargo
    }
    

    func cargo (position: Actions.Cargo.Car)
    {
            switch position
            {
                case .putInCar(let volume):
                    switch (weightCargo + volume)
                    {
                        case 0...maxWeightCargo:
                            weightCargo += volume
                            print("\(brend): В машину был положен груз весом: \(volume) Общий вес груза составляет \(weightCargo)")
                            positionCargo = position
                        default:
                            print ("\(brend): Вес груза превышает допустимый!")
                    }
                case .putInTrunk(let volume):
                    switch (weightCargo + volume)
                    {
                        case 0...maxWeightCargo:
                            weightCargo += volume
                            print("\(brend): В багажник был положен груз весом: \(volume) Общий вес груза составляет: \(weightCargo)")
                            positionCargo = position
                        default:
                            print ("\(brend): Вес груза превышает допустимый!")
                    }
                case .remove(let volume):
                    switch volume
                    {
                        case 0..<weightCargo:
                            weightCargo -= volume
                            print("\(brend): Был убран груз весом: \(volume). Общий вес оставшегося груза составляет: \( weightCargo)")
                        case weightCargo:
                            weightCargo = 0
                            print("\(brend): Был убран груз весом: \(volume). В машине и багажнике нет груза")
                            positionCargo = .empty
                        case ..<0:
                            print("\(brend): Вы ввели отрицательно значение!")
                        default:
                            print("\(brend): В машине нет столько груза!")
                    }
                case .empty:
                    print("\(brend): В машине и багажнике нет груза!")
                    positionCargo = .empty
                }
        }
    
 
}

class TruckCar: Car
{
    var brend: String
    var year: String
    var doorsStatus: Actions.Doors = .close
    var windowsStatus: Actions.Windows = .close
    var engineStatus: Actions.Engine = .stop
    var weightCargo: Int = 0
    
    var statusCargo: Actions.Cargo.TrailerTunk  = .empty
    var statusTrailler: Actions.Trailer = .unhook
    var maxCargoWeight: Int = 0
    var trailerLenght: Int = 0
    var trailerWeight: Int = 0

    func printStatus()
    {
        print("\(brend): Двери в машине: ", doorsStatus)
        print("\(brend): Окна в машине: ", windowsStatus)
        print("\(brend): Двигатель в машине: ",engineStatus)
    }
    func printCarParametr()
   {
        print("Марка машины: ", brend)
        print("Год выпуска машины: ", year)
        switch statusTrailler
        {
        case .unhook:
            print("Машина без прицепа.")
        case .hitch( _, _,  _):
            print("К машине прицеплен прицеп длиной: \(trailerLenght), массой: \(trailerWeight) и общей грузоподьемностью: \(maxCargoWeight)")
            switch statusCargo
            {
                case .empty:
                    print("Прицеп пустой!")
                default:
                    print("В прицепе находиться груз весом: \(weightCargo)")
               }
       }
   }
    
    init(brend: String, year: String)
    {
        self.brend = brend
        self.year = year
    }
    
    func trailler (status: Actions.Trailer)
    {
        switch status
        {
            case .hitch(let _maxCargoWeight,let _trailerLenght, let _trailerWeight):
                switch statusTrailler
                {
                    case .hitch (_, _, _):
                        print("\(brend): У вас уже есть прицеп!")
                    case .unhook:
                        maxCargoWeight = _maxCargoWeight
                        trailerLenght = _trailerLenght
                        trailerWeight = _trailerWeight
                        print("\(brend): Вы приципили прицеп длиной: \(trailerLenght), массой: \(trailerWeight) и общей грузоподьемностью: \(maxCargoWeight)")
                        statusTrailler = status
                }
            case .unhook:
                switch statusTrailler
                {
                    case .hitch (_, _, _):
                        print("\(brend): Вы отцепили прицеп!")
                        maxCargoWeight = 0
                        trailerLenght = 0
                        trailerWeight = 0
                        statusTrailler = status
                    case .unhook:
                        print("\(brend): У вас нет прицепа! Отцеплять нечего.")
                }
        }
    }

    func cargo(position: Actions.Cargo.TrailerTunk)
    {
        switch position
        {
        case .put(let volume):
            switch statusTrailler
            {
            case .unhook:
                print("\(brend): У вас нет прицепа.")
            case .hitch( _, _,  _):
                if (volume + weightCargo) > maxCargoWeight
                {
                    print("\(brend): Слишком большой груз!")
                }
                else
                {
                    weightCargo += volume
                    print("\(brend): В прицеп загружен груз весом: \(volume)")
                    statusCargo = position
                }
            }
        case .remove(let volume):
            switch volume
            {
            case 0..<weightCargo:
                weightCargo -= volume
                print("\(brend): Из прицепа было выгруженно: \(volume) В прицепе осталось: \(weightCargo)")
            case weightCargo:
                weightCargo = 0
                statusCargo = Actions.Cargo.TrailerTunk.empty
                print("\(brend): Из прицепа было выгруженно: \(volume) Прицеп пустой!")
            default:
                print("\(brend): В прицепе нет столько груза!")
            }
        case .empty:
            print("\(brend): Из прицепа выгрузили весь груз. Он пустой.")
        }
    }
}

extension SportCar: CustomStringConvertible
{
    var description: String {
        return "Состояние в машине \(brend): Дверей - \(doorsStatus), Окон -  \(windowsStatus), Двигателя - \(engineStatus)"
    }
}

extension TruckCar: CustomStringConvertible
{
    var description: String
    {
        switch statusTrailler {
        case .unhook:
            return "У грузовика \(brend) нет прицепа"
        case .hitch(maxCargoWeight: _, trailerLenght: _, trailerWeight: _):
            return "В прицеп грузовика \(brend) загружено \(weightCargo) кг."
        }
    }
}

func printCar (Car: Car)
{
    print(Car)
}

var lexus = SportCar(brend: "Lexus", year: "2000", maxVolumeCar: 2000, weightCar: 1500, maxWeightCargo: 500)
lexus.doors(Status: .open)
lexus.printStatus()
lexus.cargo(position: .putInCar(volume: 300))
lexus.cargo(position: .putInTrunk(volume: 200))
lexus.cargo(position: .remove(volume: 50))
lexus.printCarParametr()
print("")

var volvo = SportCar(brend: "Volvo", year: "2000", maxVolumeCar: 2000, weightCar: 1500, maxWeightCargo: 500)
volvo.windows(status: .close)
var audi = SportCar(brend: "Audi", year: "2000", maxVolumeCar: 2000, weightCar: 1500, maxWeightCargo: 500)
audi.engine(status: .start)
let sportCar = [lexus, volvo, audi]
print("")
for i in sportCar
{
    printCar(Car: i)
}
print("")
var kamaz = TruckCar(brend: "Камаз", year: "2000")
kamaz.trailler(status: .hitch(maxCargoWeight: 2000, trailerLenght: 1500, trailerWeight: 1500))
kamaz.cargo(position: .put(volume: 1000))
kamaz.cargo(position: .put(volume: 1000))
kamaz.printCarParametr()
print("")
kamaz.cargo(position: .remove(volume: 2000))
kamaz.printCarParametr()
print("")
kamaz.cargo(position: .put(volume: 1000))
kamaz.printCarParametr()
print("")
var maz = TruckCar(brend: "Маз", year: "1998")
maz.trailler(status: .hitch(maxCargoWeight: 2000, trailerLenght: 1500, trailerWeight: 1500))
var man = TruckCar(brend: "Man", year: "2010")
man.cargo(position: .put(volume: 1000))
let truckCar = [kamaz, maz, man]
print("")
for i in truckCar
{
    printCar(Car: i)
}

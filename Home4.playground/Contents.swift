import UIKit

var str = "Hello, playground"

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

class Car
{
    var marka: String
    var year: String
    var doorsStatus: Actions.Doors = .close
    var windowsStatus: Actions.Windows = .close
    var engineStatus: Actions.Engine = .stop
    var weightCargo: Int = 0
    
    init(marka: String, year: String)
    {
        self.marka = marka
        self.year = year
    }

     func doors(Status:Actions.Doors)
    {
        switch Status
        {
        case .open:
            self.doorsStatus = .open
            print("Было открыто окно машины!")
        case .close:
            self.doorsStatus = .close
            print("Было открыто окно машины!")
        }
    }
    
     func windows (status:Actions.Windows)
    {
        switch status
        {
        case .open:
            self.windowsStatus = .open
            print("Была открыта дверь машины!")
        case .close:
            self.windowsStatus = .close
            print("Была закрыта дверь машины!")
        }
    }
    
     func engine (status:Actions.Engine)
    {
        switch status
        {
        case .start:
            self.engineStatus = .start
            print("Был запущен двигатель машины!")
        case .stop:
            self.engineStatus = .stop
            print("Была заглушен двигатель машины!")
        }
    }
    
    func printStatus ()
    {
        print("Двери в машине: ", doorsStatus)
        print("Окна в машине: ", windowsStatus)
        print("Двигатель в машине: ",engineStatus)
    }
    
    func printCarParametr ()
    {
        print("Марка машины: ", marka)
        print("Год выпуска машины: ", year)
    }
    
   func cargo(position: Actions.Cargo) {}
}

class SportCar: Car
{
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
    init(marka: String, year: String, maxVolumeCar: Int, weightCar: Int, maxWeightCargo: Int)
    {
        super.init(marka: marka, year: year)
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
                            print("В машину был положен груз весом: \(volume) Общий вес груза составляет \(weightCargo)")
                            positionCargo = position
                        default:
                            print ("вес груза превышает допустимый!")
                    }
                case .putInTrunk(let volume):
                    switch (weightCargo + volume)
                    {
                        case 0...maxWeightCargo:
                            weightCargo += volume
                            print("В багажник был положен груз весом: \(volume) Общий вес груза составляет: \(weightCargo)")
                            positionCargo = position
                        default:
                            print ("вес груза превышает допустимый!")
                    }
                case .remove(let volume):
                    switch volume
                    {
                        case 0..<weightCargo:
                            weightCargo -= volume
                            print("Был убран груз весом: \(volume). Общий вес оставшегося груза составляет: \( weightCargo)")
                        case weightCargo:
                            weightCargo = 0
                            print("Был убран груз весом: \(volume). В машине и багажнике нет груза")
                            positionCargo = .empty
                        case ..<0:
                            print("Вы ввели отрицательно значение!")
                        default:
                            print("В машине нет столько груза!")
                    }
                case .empty:
                    print("В машине и багажнике нет груза!")
                    positionCargo = .empty
                }
        }
    
    override func printCarParametr()
    {
        super.printCarParametr()
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
}

class TruckCar: Car
{
    var statusCargo: Actions.Cargo.TrailerTunk  = .empty
    var statusTrailler: Actions.Trailer = .unhook
    var maxCargoWeight: Int = 0
    var trailerLenght: Int = 0
    var trailerWeight: Int = 0
    
    func trailler (status: Actions.Trailer)
    {
        switch status
        {
            case .hitch(let _maxCargoWeight,let _trailerLenght, let _trailerWeight):
                switch statusTrailler
                {
                    case .hitch (_, _, _):
                        print("У вас уже есть прицеп!")
                    case .unhook:
                        maxCargoWeight = _maxCargoWeight
                        trailerLenght = _trailerLenght
                        trailerWeight = _trailerWeight
                        print("Вы приципили прицеп длиной: \(trailerLenght), массой: \(trailerWeight) и общей грузоподьемностью: \(maxCargoWeight)")
                        statusTrailler = status
                }
            case .unhook:
                switch statusTrailler
                {
                    case .hitch (_, _, _):
                        print("Вы отцепили прицеп!")
                        maxCargoWeight = 0
                        trailerLenght = 0
                        trailerWeight = 0
                        statusTrailler = status
                    case .unhook:
                        print("У вас нет прицепа! Отцеплять нечего.")
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
                print("У вас нет прицепа.")
            case .hitch( _, _,  _):
                if (volume + weightCargo) > maxCargoWeight
                {
                    print("Слишком большой груз!")
                }
                else
                {
                    weightCargo += volume
                    print("В прицеп загружен груз весом: \(volume)")
                    statusCargo = position
                }
            }
        case .remove(let volume):
            switch volume
            {
            case 0..<weightCargo:
                weightCargo -= volume
                print("Из прицепа было выгруженно: \(volume) В прицепе осталось: \(weightCargo)")
            case weightCargo:
                weightCargo = 0
                statusCargo = Actions.Cargo.TrailerTunk.empty
                print("Из прицепа было выгруженно: \(volume) Прицеп пустой!")
            default:
                print("В прицепе нет столько груза!")
            }
        case .empty:
            print("Из прицепа выгрузили весь груз. Он пустой.")
        }
    }
    override func printCarParametr()
    {
        super.printCarParametr()
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


}

var lexus = SportCar(marka: "Lexus", year: "2000", maxVolumeCar: 2000, weightCar: 1500, maxWeightCargo: 500)
lexus.doors(Status: .open)
lexus.printStatus()
lexus.cargo(position: .putInCar(volume: 300))
lexus.cargo(position: .putInTrunk(volume: 200))
lexus.cargo(position: .remove(volume: 50))
lexus.printCarParametr()
print("")

var kamaz = TruckCar(marka: "Камаз", year: "2000")
kamaz.trailler(status: .hitch(maxCargoWeight: 2000, trailerLenght: 1500, trailerWeight: 1500))
kamaz.cargo(position: .put(volume: 1000))
kamaz.cargo(position: .put(volume: 1000))
kamaz.printCarParametr()
print("")
kamaz.cargo(position: .remove(volume: 2000))
kamaz.printCarParametr()
print("")
kamaz.trailler(status: .unhook)
kamaz.trailler(status: .unhook)
kamaz.cargo(position: .put(volume: 1000))
kamaz.printCarParametr()

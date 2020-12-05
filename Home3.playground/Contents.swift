import UIKit

var str = "Hello, playground"

enum Status
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
        case hitch, unhook
    }
}

enum LoadCargo
{
    enum Car
    {
        case putInTrunk, putInCar, empty
    }
    
    enum Track
    {
        case full, empty
    }
}

struct SportCar
{
    let marka: String
    let year: String
    var doorsStatus: Status.Doors = .close
    var windowStatus: Status.Windows = .close
    var engineStatus: Status.Engine = .stop
    let maxVolumeCar: Int
    let weightCar: Int
    let maxWeightTrunk: Int
    var weightCargo: Int = 0
    var positionCargo: LoadCargo.Car = .empty
    var weightWithCargo: Int {
        get
        {
            return self.weightCar + self.weightCargo
        }
//        set
//        {
//            self.weightWithCargo = newValue
//        }
    }

    mutating func Cargo (Position: LoadCargo.Car, weight: Int)
    {
        self.weightCargo = weight
        switch Position {
        case .putInCar:
            print("В машину был положен груз весом:", weight)
        case .putInTrunk:
            print("В багажник был положен груз весом:", weight)
        case .empty:
            print("Вы убрали груз!")
        }
    }
    
    mutating func OpenDoors ()
    {
        self.doorsStatus = .open
        print("Было открыто окно машины!")
    }
    
    mutating func CloseDoors ()
    {
        self.doorsStatus = .close
        print("Было закрыто окно машины!")
    }
    
    mutating func StartEngine ()
    {
        self.engineStatus = .start
        print("Был запущен двигатель машины!")
    }
    
    mutating func StopEngine ()
    {
        self.engineStatus = .stop
        print("Был заглушен двигатель машины!")
    }
    mutating func OpenWindow ()
    {
        self.windowStatus = .open
        print("Была открыта дверь машины!")
    }
    
    mutating func CloseWindow ()
    {
        self.windowStatus = .close
        print("Была закрыта дверь машины!")
    }

    func PrintStatus ()
    {
        print("Двери в машине: ", doorsStatus)
        print("Окна в машине: ", windowStatus)
        print("Двигатель в машине: ",engineStatus)
        print("Общий вес машины с грузом: ", weightWithCargo)
    }
    
    func PrintCarParametr ()
    {
        print("Марка машины: ", marka)
        print("Год выпуска машины: ", year)
        print("Масса машины: ", weightCar)
        print("Максимальная разрешенная масса машины: ", maxVolumeCar)
    }

}

struct TruckCar
{
    let marka: String
    let year: String
    var doorsStatus: Status.Doors = .close
    var windowStatus: Status.Windows = .close
    var engineStatus: Status.Engine = .stop
    let weightTruck: Int
    var weightCargo: Int = 0
    var statusCargo: LoadCargo.Track = .empty
    var statusTrailler: Status.Trailer = .unhook
    var trailerTonnage: Int = 0
    var trailerLenght: Int = 0
    var trailerWeight: Int = 0
   
    mutating func Trailler (Status: Status.Trailer, weight: Int, lenght: Int, tonnage: Int)
    {
        switch Status {
        case .hitch:
            trailerTonnage = tonnage
            trailerLenght = lenght
            trailerWeight = weight
            print("К грузовику прицеплен прицеп с параметрами:")
            print("Вес прицепа: ", trailerWeight)
            print("Грузоподъемность прицепа: ", trailerTonnage)
            print("Длина прицепа: ",trailerLenght)
            statusTrailler = Status
        case .unhook:
            print("Тягач без прицепа")
        }
    }
    
    mutating func Cargo (Status: LoadCargo.Track, weight: Int)
    {
        switch Status
        {
        case .full:
            switch statusTrailler
            {
            case .unhook:
                print("У вас нет прицепа!!!")
            case .hitch:
                if (weightCargo + weight) > trailerTonnage
                {
                    print("Слишком большой груз!")
                }
                else
                {
                    weightCargo += weight
                    statusCargo = LoadCargo.Track.full
                    print("В трайлер загружен груз весом: ", weight)
                }
            }
        case .empty:
            switch weight
            {
            case 0..<weightCargo:
                weightCargo -= weight
                print("Из прицепа было выгруженно: ", weight , " В прицепе осталось: ", weightCargo)
                statusCargo = LoadCargo.Track.full
            case weightCargo:
                weightCargo = 0
                statusCargo = LoadCargo.Track.empty
                print("Из прицепа было выгруженно: ", weight , " Прицеп пустой!")
            default:
                print("В прицепе нет столько груза!")
                statusCargo = LoadCargo.Track.full
            }
            
        
        }
    }
    
    mutating func OpenDoors ()
    {
        self.doorsStatus = .open
        print("Было открыто окно машины!")
    }
    
    mutating func CloseDoors ()
    {
        self.doorsStatus = .close
        print("Было закрыто окно машины!")
    }
    
    mutating func StartEngine ()
    {
        self.engineStatus = .start
        print("Был запущен двигатель машины!")
    }
    
    mutating func StopEngine ()
    {
        self.engineStatus = .stop
        print("Был заглушен двигатель машины!")
    }
    mutating func OpenWindow ()
    {
        self.windowStatus = .open
        print("Была открыта дверь машины!")
    }
    
    mutating func CloseWindow ()
    {
        self.windowStatus = .close
        print("Была закрыта дверь машины!")
    }

    func PrintStatus ()
    {
        print("Двери в машине: ", doorsStatus)
        print("Окна в машине: ", windowStatus)
        print("Двигатель в машине: ",engineStatus)
    }
    
    func PrintCarParametr ()
    {
        print("Марка машины: ", marka)
        print("Год выпуска машины: ", year)
    }
    
    func PrintCargoParametr ()
    {
        switch statusTrailler
        {
        case .unhook:
            print("Прицеп не присоеден!")
        case .hitch:
            print("Характеристики прицепа:")
            print("Вес прицепа: ", trailerWeight)
            print("Грузоподъемность прицепа: ", trailerTonnage)
            print("Длина прицепа: ",trailerLenght)
            switch statusCargo
            {
            case .empty:
                print("Прицеп пустой.")
            case .full:
                print("В прицепе груз весом: ", weightCargo)
            }
        }
    }
    
}




var Volvo = SportCar(marka: "Volvo S40", year: "2000", maxVolumeCar: 2500, weightCar: 1500, maxWeightTrunk: 500)
Volvo.PrintStatus()
Volvo.PrintCarParametr()
Volvo.OpenWindow()
Volvo.OpenDoors()
Volvo.PrintStatus()
let vesGruza = 300
Volvo.Cargo(Position: .putInCar, weight: vesGruza)
Volvo.PrintStatus()

var Kamaz = TruckCar(marka: "Kamaz", year: "1998", weightTruck: 3500)
Kamaz.PrintCarParametr()
Kamaz.PrintStatus()
Kamaz.PrintCargoParametr()
Kamaz.Cargo(Status: .full, weight: 500)
Kamaz.Trailler(Status: .hitch, weight: 1500, lenght: 10, tonnage: 20000)
Kamaz.Cargo(Status: .full, weight: 50000)
Kamaz.Cargo(Status: .full, weight: 15000)
Kamaz.Cargo(Status: .full, weight: 5000)
Kamaz.Cargo(Status: .full, weight: 15000)
Kamaz.Cargo(Status: .empty, weight: 121000)
Kamaz.PrintCargoParametr()
Kamaz.Cargo(Status: .empty, weight: 10000)
Kamaz.Cargo(Status: .empty, weight: 10000)
Kamaz.PrintCargoParametr()

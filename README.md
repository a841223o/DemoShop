# Demo Shop

swift 5 / xcode 13.2.1

## 圖示

<table>
    <tr>
        <td>商品列表</td>
        <td>購物車</td>
        <td>訂單</td>
    </tr>
    <tr>
        <td ><img src="https://media.giphy.com/media/K1r1ZxmOJrNXFDHlEN/giphy.gif" ></td>
        <td ><img src="https://media.giphy.com/media/5sutPppQjzlZkzJODz/giphy.gif"  ></td>
        <td ><img src="https://media.giphy.com/media/5z8g9BckArghwHsESb/giphy.gif" ></td>
    </tr>
    
</table>


## 架構

- MVVM
```
PageFolder --|--- Model
             |
             |--- View
             |
             |--- ViewModel

Service

Extension

```


## Design Pattern 

### 購物車
- Singleton
    ```swift
    class ShoppingCart {
        static let shared = ShoppingCart()
    }
    ```
- Observer
    ```swift
        protocol ObserverProtocol {
            var observerId : Int {get  set }
            func onValueChanged(_ value: Any?)
        }
        protocol ObservableProtocol : class {
            var observers : [ObserverProtocol] { get set }
            func addObserver(_ observer: ObserverProtocol)
            func removeObserver(_ observer: ObserverProtocol)
            func notifyObservers(_ observers: [ObserverProtocol])
        }

        class Observable<T> : ObservableProtocol {

            var value : T {
                didSet {
                    self.notifyObservers(self.observers)
                }
            }

            internal var observers : [ObserverProtocol] = []

            init(value: T) {
                self.value = value
            }

            func addObserver(_ observer: ObserverProtocol) {
        
                self.observers.append(observer)
            }

            func removeObserver(_ observer: ObserverProtocol) {
                guard let index = self.observers.firstIndex(where: { $0.observerId == observer.observerId }) else {
                    return
                }
                self.observers.remove(at: index)
            }

            func notifyObservers(_ observers: [ObserverProtocol]) {
                observers.forEach({ $0.onValueChanged(value)})
            }

            deinit {
                observers.removeAll()
            }
    }

    ```
    use
    ```swift
     var numberOfItems = Observable.init(value: 0)
    ```

### 訂單

- Strategy
    ```swift 
        protocol CalculatorMethod {
            func calculator(items:[Item])->Int
        }

        class NormalCalculatorMethod : CalculatorMethod {
            
            func calculator(items:[Item])->Int{
                var total = 0
                items.forEach { item in
                    total += item.price
                }
                return total
            }
            
        }

        class TaxCalculatorMethod : CalculatorMethod {
            
            func calculator(items:[Item])->Int{
                let tax = 20
                return tax
            }
            
        }

    ```
    use
    ```swift
    //提供不同計價策略例如折扣、税金、運費等等
    //利用 priceList 列出計費清單

    var priceList : [Int] {
        var priceList : [Int] = []
        calculatorMethods.forEach { method in
            priceList.append(method.calculator(items: items))
        }
        return priceList
    }
    ```

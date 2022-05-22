//
//  ShoppingCart.swift
//  DemoShop
//
//  Created by leo on 2022/5/22.
//

import Foundation
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


class ShoppingCart {
    static let shared = ShoppingCart()
    private var items = [Item]()
    var numberOfItems = Observable.init(value: 0)
    
    func add(item:Item){
        items.append(item)
        numberOfItems.value = items.count
    }
    
    func remove(index : Int){
        items.remove(at: index)
        numberOfItems.value = items.count
    }
    
    func remove(item : Item){
        let index = items.firstIndex { value in
            value.id == item.id
        }
        guard let index = index else {
            return
        }
        items.remove(at: index)
        numberOfItems.value = items.count
    }
    
    func getItems()->[Item]{
        return items
    }
    
    func clearItemInOrder(order : Order){
        order.items.forEach { item in
            remove(item: item)
        }
        numberOfItems.value = items.count
    }
    
}

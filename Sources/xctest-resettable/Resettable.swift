@propertyWrapper
public class Resettable<Value> {
    
    public typealias ResetMethodReference = (Value) -> () -> ()
    
    public var wrappedValue: Value?
    private var resetMethodReference: ResetMethodReference?
    
    public init(wrappedValue: Value? = nil, onReset resetReference: ResetMethodReference? = nil) {
        self.wrappedValue = wrappedValue
        self.resetMethodReference = resetReference
    }
    
    fileprivate var resetMethod: (() -> Void)? {
        self.wrappedValue.flatMap { resetMethodReference?($0) }
    }
}

extension Resettable: ResettableProtocol {
    func reset() {
        if wrappedValue != nil {
            resetMethod?()
            self.wrappedValue = nil
            self.resetMethodReference = nil
        }
    }
}

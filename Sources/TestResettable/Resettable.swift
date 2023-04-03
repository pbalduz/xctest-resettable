@propertyWrapper
public class Resettable<Value> {
    public static subscript<InstanceType: ResettableTestCase>(
        _enclosingInstance instance: InstanceType,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<InstanceType, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<InstanceType, Resettable>
    ) -> Value? {
        get { instance[keyPath: storageKeyPath].value }
        set { instance[keyPath: storageKeyPath].value = newValue }
    }
    
    @available(*, unavailable, message: "@Resettable can only be applied to classes")
    public var wrappedValue: Value? {
        get { fatalError() }
        set { fatalError() }
    }
    
    fileprivate var value: Value?
    
    public init(wrappedValue: Value?) {
        self.value = wrappedValue
    }
}

extension Resettable: ResettableProtocol {
    func reset() {
        if self.value != nil {
            self.value = nil
        }
    }
}

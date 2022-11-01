import XCTest

class ResettableTestCase: XCTestCase {
    
    override func tearDown() {
        let resettableChildren = Mirror(reflecting: self).children.compactMap {
            $0.value as? ResettableProtocol
        }
        for resettable in resettableChildren {
            resettable.reset()
        }
        super.tearDown()
    }
}

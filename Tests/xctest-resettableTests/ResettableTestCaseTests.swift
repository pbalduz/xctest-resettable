import XCTest
@testable import xctest_resettable

class ResettableTestCaseTests: XCTestCase {
    
    func testResettableValueIsSetToNilOnTearDown() {
        let sut = TestCaseStub()
        XCTAssertEqual(sut.resettableString, "resettable")
        XCTAssertEqual(sut.nonResettableString, "non resettable")
        sut.tearDown()
        XCTAssertNil(sut.resettableString)
        XCTAssertEqual(sut.nonResettableString, "non resettable")
    }
    
    func testResettableResetMethodInvokedOnTearDown() {
        let sut = TestCaseStub()
        XCTAssertFalse(sut.resetWasCalled)
        sut.setUp()
        sut.tearDown()
        XCTAssertTrue(sut.resetWasCalled)
    }
}

private class TestCaseStub: ResettableTestCase {
    @Resettable var resettableString = "resettable"
    var nonResettableString = "non resettable"
    
    struct TestValue {
        let resetClosure: () -> Void
        
        func reset() {
            resetClosure()
        }
    }
    
    @Resettable(onReset: TestValue.reset)
    var resettableValue: TestValue!
    
    var resetWasCalled = false
    
    override func setUp() {
        super.setUp()
        self.resettableValue = TestValue(resetClosure: { self.resetWasCalled = true })
    }
}

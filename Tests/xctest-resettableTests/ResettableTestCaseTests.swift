import XCTest
@testable import xctest_resettable

class ResettableTestCaseTests: XCTestCase {
    
    func testResettableValueIsSetToNilOnTearDown() {
        let sut = TestCaseStub()
        XCTAssertEqual(sut.resettableValue, "resettable")
        XCTAssertEqual(sut.nonResettableValue, "non resettable")
        sut.tearDown()
        XCTAssertNil(sut.resettableValue)
        XCTAssertEqual(sut.nonResettableValue, "non resettable")
    }
}

private class TestCaseStub: ResettableTestCase {
    @Resettable var resettableValue = "resettable"
    var nonResettableValue = "non resettable"
}

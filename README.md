# 🪶 xctest-resettable

[![CI](https://github.com/pbalduz/xctest-resettable/actions/workflows/ci.yml/badge.svg)](https://github.com/pbalduz/xctest-resettable/actions/workflows/ci.yml)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fpbalduz%2Fxctest-resettable%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/pbalduz/xctest-resettable)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fpbalduz%2Fxctest-resettable%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/pbalduz/xctest-resettable)

A framework to help keep your unit tests lightweight.

## Motivation
In large projects with a big test suite it's easy to see how the memory consumption keeps increasing while running the tests. This is due to the `XCTestCase` workflow.
When an `XCTestCase` class runs its tests a new test case is instantiated, one for each test method it has and if it's not released, a new instance of the test subject will keep being added to memory. These objects should be released when the test is finished and the proper way to do it is in the `tearDown()` method the test case provides.
The solution would look like the following:
```
var sut: SUT! = SUT()

override func tearDown() {
    sut = nil
    super.tearDown()
}
```
This framework, based on this principle, implements additional logic so that this process is done under the hood by simply adding a property wrapper to your test objects.

## Usage
The property wrapper that enables the release of your test objects is `@Resettable` and it works under a `ResettableTestCase` subclass.
These are the different ways you can use the `@Resettable` property wrapper:

### Lazy init
```
@Resettable var sut: SUT!

override func setUp() {
    super.setUp()
    sut = SUT()
}
```

### Init with reset method
It's also possible to add a method to the property wrapper that will be executed in the `tearDown()` method right before releasing the object. 
```
class SUT {
    func reset() { ... }
}

@Resettable(onReset: SUT.reset)
var sut: SUT! = SUT()
```
> Note: The reset method must be declared within the test object.

The code above will be translated to the following using `tearDown()`:
```
override func tearDown() {
    sut.reset()
    sut = nil
    super.tearDown()
}
```


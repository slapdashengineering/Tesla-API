import XCTest
@testable import TeslaAPI

extension TeslaAPITests {
    func testLock() {
        let waitExpectation = expectation(description: "Lock")

        LockRequest(
            accessToken: accessToken(),
            vehicleIdentifier: vehicleIdentifier(),
            state: .lock).execute { result in
                XCTAssert(Thread.isMainThread)
                switch result {
                case .success(let result):
                    print(result)
                    waitExpectation.fulfill()
                case .failure(let error):
                    print(error)
                    XCTFail()
                }
        }
        waitForExpectations(timeout: 30, handler: nil)
    }

    func testUnlock() {
        let waitExpectation = expectation(description: "Unlock")

        LockRequest(
            accessToken: accessToken(),
            vehicleIdentifier: vehicleIdentifier(),
            state: .unlock).execute { result in
                XCTAssert(Thread.isMainThread)
                switch result {
                case .success(let result):
                    print(result)
                    waitExpectation.fulfill()
                case .failure(let error):
                    print(error)
                    XCTFail()
                }
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
}

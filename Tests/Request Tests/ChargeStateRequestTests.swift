import XCTest
@testable import TeslaAPI

extension TeslaAPITests {
    func testChargeState() {
        let waitExpectation = expectation(description: "Charge state")
        ChargeStateRequest(
            accessToken: TeslaAPITests.accessToken,
            vehicleIdentifier: TeslaAPITests.vehicleIdentifier).execute { result in
                switch result {
                case .success(_):
                    waitExpectation.fulfill()
                case .failure(_):
                    XCTFail()
                }
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
}

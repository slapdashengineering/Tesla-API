import Foundation

public struct SetHVACTempsRequest: RequestProtocol {
    typealias CompletionType = Bool
    var path: String {
        return "/api/1/vehicles/\(vehicleIdentifier)/command/set_temps?driver_temp=\(driver_temp)&passenger_temp=\(passenger_temp)"
    }
    let method = WebRequest.RequestMethod.post
    let accessToken: String
    let vehicleIdentifier: String
    let driver_temp: Double //Degrees, in Celcius.
    let passenger_temp: Double //Degrees, in Celcius.
    
    public init(accessToken: String, vehicleIdentifier: String, driver_temp: Double, passenger_temp: Double) {
        self.accessToken = accessToken
        self.vehicleIdentifier = vehicleIdentifier
        self.driver_temp = driver_temp
        self.passenger_temp = passenger_temp
    }
    
    public func execute(completion: @escaping (Result<Bool>) -> Void) {
        WebRequest.request(
            path: path,
            method: method,
            accessToken: accessToken) { response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(Result.failure(error))
                    }
                } else if let response = response as? [String: [String: Any]],
                    let resultBool = response["response"]?["result"] as? Bool {
                    DispatchQueue.main.async {
                        completion(Result.success(resultBool))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(Result.failure(APIError()))
                    }
                }
        }
    }
}

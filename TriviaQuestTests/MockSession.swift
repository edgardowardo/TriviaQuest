import Foundation

private final class MockURLProtocol: URLProtocol {
    nonisolated(unsafe) static var testData: Data?
    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    override func startLoading() {
        if let data = MockURLProtocol.testData {
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    override func stopLoading() {}
}

func getMockSession(from data: Data?) -> URLSession {
    let config = URLSessionConfiguration.ephemeral
    config.protocolClasses = [MockURLProtocol.self]
    MockURLProtocol.testData = data
    return URLSession(configuration: config)
}

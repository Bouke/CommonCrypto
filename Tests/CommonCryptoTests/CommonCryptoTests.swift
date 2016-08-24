import XCTest
@testable import CommonCrypto

class CommonCryptoTests: XCTestCase {
    func testDigest() {
        let actual = Digest.MD5.hash("password".data(using: .utf8)!)
        let expected = Data(hex: "5f4dcc3b5aa765d61d8327deb882cf99")!
        XCTAssertEqual(actual.hex, expected.hex)
    }

    func testHMAC() {
        let actual = HMAC(algorithm: .SHA1, key: "secret".data(using: .utf8)!).update(Data()).final()
        let expected = Data(hex: "25af6174a0fcecc4d346680a72b7ce644b9a88e8")!
        XCTAssertEqual(actual.hex, expected.hex)
    }

    func testRandom() {
        XCTAssertEqual(generateRandomBytes(count: 64).count, 64)
    }

    static var allTests : [(String, (CommonCryptoTests) -> () throws -> Void)] {
        return [
            ("testDigest", testDigest),
            ("testHMAC", testHMAC),
            ("testRandom", testRandom),
        ]
    }
}

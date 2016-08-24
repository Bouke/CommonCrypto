import CCommonCrypto
import Foundation

public enum Digest {
    case MD5
    case SHA1
    case SHA512

    public var length: Int {
        switch self {
        case .MD5: return Int(CC_MD5_DIGEST_LENGTH)
        case .SHA1: return Int(CC_SHA1_DIGEST_LENGTH)
        case .SHA512: return Int(CC_SHA512_DIGEST_LENGTH)
        }
    }

    var f: (UnsafeRawPointer, CC_LONG, UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8>! {
        switch self {
        case .MD5: return CC_MD5
        case .SHA1: return CC_SHA1
        case .SHA512: return CC_SHA512
        }
    }

    public func hash(_ data: Data) -> Data {
        var digest = Data(count: length)
        _ = data.withUnsafeBytes { pData in
            digest.withUnsafeMutableBytes { pDigest in
                f(pData, CC_LONG(data.count), pDigest)
            }
        }
        return digest
    }
}

import XCTest
import SnapshotTesting
import SDWebImageMockPlugin
@testable import SDWebImageMockPlugin_Example

// swiftlint:disable implicitly_unwrapped_optional

class Tests: XCTestCase {

    var imageMocker: ImageCacheMocker!

    override func setUp() {
        super.setUp()
        imageMocker = ImageCacheMocker()
        imageMocker.registerProvider(.bundleImageProvider(
            bundlesWithIdentifiers: ["testBundle": Bundle(for: Tests.self)])
        )
        imageMocker.setupSDWebImageMocking()
    }

    func testViewController() throws {
        let viewController = SDWebImageMockPlugin_Example.ViewController()

        viewController.configure(with: URL(string: "http://127.0.0.1"))

        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
    }

    func testMultipleImagesViewController() throws {
        let viewController = SDWebImageMockPlugin_Example.MultipleImagesViewController()

        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
    }

    func testConfiguredMultipleImagesViewController() throws {
        let viewController = SDWebImageMockPlugin_Example.MultipleImagesViewController()

        viewController.loadViewIfNeeded()
        viewController.configure(with: [
            (.imageMock(forWidth: 500, height: 100), .scaleAspectFit),
            (.imageMock(forWidth: 50, height: 500), .scaleAspectFill),
            (.imageMock(withRatio: Double(16) / Double(9)), .scaleAspectFit),
            (.imageMock(withRatio: Double(3) / Double(2)), .scaleAspectFit),
            (.imageMock(named: "sampleImage1", inBundleID: "testBundle"), .scaleAspectFit),
            (.imageMock(named: "sampleImage2", inBundleID: "testBundle"), .scaleAspectFit),
            (URL(string: "http://127.0.0.1"), .scaleToFill)
        ])

        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
    }
}

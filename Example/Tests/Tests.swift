import XCTest
import SnapshotTesting
import SDWebImageMockPlugin
@testable import SDWebImageMockPlugin_Example

class Tests: XCTestCase {

    var imageMocker: ImageCacheMocker!

    override func setUp() {
        super.setUp()
        imageMocker = ImageCacheMocker()
        imageMocker.setupSDWebImageMocking()
    }
    
    func testViewController() throws {
        let viewController = SDWebImageMockPlugin_Example.ViewController()

        viewController.configure(with: URL(string: "sample://testImageByName"))

        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
    }

    func testMultipleImagesViewController() throws {
        let viewController = SDWebImageMockPlugin_Example.MultipleImagesViewController()

        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
    }
}

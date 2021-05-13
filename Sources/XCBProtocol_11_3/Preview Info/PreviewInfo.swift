import Foundation
import MessagePack
import XCBProtocol

public struct PreviewInfo {
    public let sdkVariant: SDKVariant // Called `sdkRoot` by Xcode. e.g. "macosx10.14"
    public let unknown: MessagePackValue
    public let buildVariant: String // Might be named wrong. e.g. "normal"
    public let architecture: String // e.g. "x86_64"
    public let compileCommandLine: [String] // e.g. ["/Applications/Xcode-11.3.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swiftc", "-enforce-exclusivity=checked", ...]
    public let linkCommandLine: [String] // e.g. ["/Applications/Xcode-11.3.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang", "-target", ...]
    public let thunkSourceFile: String // e.g. "/Users/USER/Library/Developer/Xcode/DerivedData/PROJECT-hash/Build/Intermediates.noindex/Previews/TARGET_NAME/Intermediates.noindex/PROJECT_NAME.build/Debug-iphonesimulator/TARGET_NAME.build/Objects-normal/x86_64/SOURCE_FILE.__XCPREVIEW_THUNKSUFFIX__.preview-thunk.swift"
    public let thunkObjectFile: String // e.g. "/Users/USER/Library/Developer/Xcode/DerivedData/PROJECT-hash/Build/Intermediates.noindex/Previews/TARGET_NAME/Intermediates.noindex/PROJECT_NAME.build/Debug-iphonesimulator/TARGET_NAME.build/Objects-normal/x86_64/SOURCE_FILE.__XCPREVIEW_THUNKSUFFIX__.preview-thunk.o"
    public let thunkLibrary: String // e.g. "/Users/USER/Library/Developer/Xcode/DerivedData/PROJECT-hash/Build/Intermediates.noindex/Previews/TARGET_NAME/Intermediates.noindex/PROJECT_NAME.build/Debug-iphonesimulator/TARGET_NAME.build/Objects-normal/x86_64/SOURCE_FILE.__XCPREVIEW_THUNKSUFFIX__.preview-thunk.dylib"
    public let pifGUID: String
    
    public init(
        sdkVariant: SDKVariant,
        buildVariant: String,
        architecture: String,
        compileCommandLine: [String],
        linkCommandLine: [String],
        thunkSourceFile: String,
        thunkObjectFile: String,
        thunkLibrary: String,
        pifGUID: String
    ) {
        self.sdkVariant = sdkVariant
        self.unknown = .nil
        self.buildVariant = buildVariant
        self.architecture = architecture
        self.compileCommandLine = compileCommandLine
        self.linkCommandLine = linkCommandLine
        self.thunkSourceFile = thunkSourceFile
        self.thunkObjectFile = thunkObjectFile
        self.thunkLibrary = thunkLibrary
        self.pifGUID = pifGUID
    }
}

// MARK: - Decoding

extension PreviewInfo: Decodable {}

// MARK: - Encoding

extension PreviewInfo: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [
            sdkVariant.encode(),
            unknown,
            .string(buildVariant),
            .string(architecture),
            .array(compileCommandLine.map(MessagePackValue.string)),
            .array(linkCommandLine.map(MessagePackValue.string)),
            .string(thunkSourceFile),
            .string(thunkObjectFile),
            .string(thunkLibrary),
            .string(pifGUID),
        ]
    }
}

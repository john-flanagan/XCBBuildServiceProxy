import Foundation
import MessagePack
import XCBProtocol

public struct BuildRequest {
    public let parameters: BuildParameters
    public let configuredTargets: [ConfiguredTarget]
    public let continueBuildingAfterErrors: Bool
    public let hideShellScriptEnvironment: Bool
    public let useParallelTargets: Bool
    public let useImplicitDependencies: Bool
    public let useDryRun: Bool
    public let showNonLoggedProgress: Bool
    public let buildPlanDiagnosticsDirPath: String?
    public let buildCommand: BuildCommand
    public let schemeCommand: SchemeCommand
    public let buildOnlyTheseFiles: MessagePackValue
    public let buildOnlyTheseTargets: MessagePackValue
    public let buildDescriptionID: MessagePackValue
    public let enableIndexBuildArena: Bool
    public let unknown: MessagePackValue // comes back as `.nil`, so it's unclear what this is or what type it is
    public let useLegacyBuildLocations: Bool
    public let shouldCollectMetrics: Bool
    public let jsonRepresentation: String?
}

// MARK: - Decoding

extension BuildRequest: Decodable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()

        self.parameters = try container.decode()
        self.configuredTargets = try container.decode()
        self.continueBuildingAfterErrors = try container.decode()
        self.hideShellScriptEnvironment = try container.decode()
        self.useParallelTargets = try container.decode()
        self.useImplicitDependencies = try container.decode()
        self.useDryRun = try container.decode()
        self.showNonLoggedProgress = try container.decode()
        self.buildPlanDiagnosticsDirPath = try container.decode()
        self.buildCommand = try container.decode()
        self.schemeCommand = try container.decode()
        self.buildOnlyTheseFiles = try container.decode()
        self.buildOnlyTheseTargets = try container.decode()
        self.buildDescriptionID = try container.decode()
        self.enableIndexBuildArena = try container.decode()
        self.unknown = try container.decode()
        self.useLegacyBuildLocations = try container.decode()
        self.shouldCollectMetrics = try container.decode()

        if let jsonRepresentationBase64String = try container.decode(String?.self) {
            guard let base64Data = Data(base64Encoded: jsonRepresentationBase64String),
                  let decodedString = String(data: base64Data, encoding: .utf8) else {
                throw MessagePackUnpackError.invalidData
            }
            self.jsonRepresentation = decodedString
        } else {
            self.jsonRepresentation = nil
        }
        
        try container.throwIfNotAtEnd()
    }
}

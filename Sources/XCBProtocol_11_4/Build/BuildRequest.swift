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
    public let enableIndexBuildArena: Bool
    public let useLegacyBuildLocations: Bool
    public let shouldCollectMetrics: Bool
}

// MARK: - Decoding

extension BuildRequest: Decodable {}

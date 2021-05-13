import Foundation
import MessagePack
import XCBProtocol

public struct BuildOperationTaskStarted {
    public struct TaskDetails {
        public let taskName: String // e.g. "Swift Compiler", "Shell Script Invocation"
        public let signature: Data // Used in `BuildOperationTaskUpToDate`. Seems to be consistent.
        public let ruleInfo: String // e.g. "CompileSwift normal x86_64 /Users/USER/Desktop/BazelXCBuildServer/Sources/XCBProtocol/Response.swift", "PhaseScriptExecution SwiftLint /Users/USER/Library/Developer/Xcode/DerivedData/PROJECT-HASH/Build/Intermediates.noindex/PROJECT.build/Debug-iphonesimulator/SCRIPT.build/Script-9A635388D017DF17C1E0081A.sh"
        public let executionDescription: String // e.g. "Compile /Users/USER/Desktop/BazelXCBuildServer/Sources/XCBProtocol/Response.swift", "Run custom shell script 'SwiftLint'"
        public let commandLineDisplayString: String // e.g. "    cd /Users/USER/Desktop/BazelXCBuildServer\n/Applications/Xcode-11.3.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift -frontend -c ..."
        public let interestingPath: String? // e.g. "/Users/USER/Desktop/BazelXCBuildServer/Sources/XCBProtocol/Response.swift"
        public let serializedDiagnosticsPaths: [String]

        public init(
            taskName: String,
            signature: Data,
            ruleInfo: String,
            executionDescription: String,
            commandLineDisplayString: String,
            interestingPath: String?,
            serializedDiagnosticsPaths: [String]
        ) {
            self.taskName = taskName
            self.signature = signature
            self.ruleInfo = ruleInfo
            self.executionDescription = executionDescription
            self.commandLineDisplayString = commandLineDisplayString
            self.interestingPath = interestingPath
            self.serializedDiagnosticsPaths = serializedDiagnosticsPaths
        }
    }
    
    public let taskID: Int64 // Starts from 1 within a build
    public let targetID: Int64
    public let parentTaskID: Int64?
    public let taskDetails: TaskDetails
    
    public init(
        taskID: Int64,
        targetID: Int64,
        parentTaskID: Int64?,
        taskDetails: TaskDetails
    ) {
        self.taskID = taskID
        self.targetID = targetID
        self.parentTaskID = parentTaskID
        self.taskDetails = taskDetails
    }
}

// MARK: - ResponsePayloadConvertible

extension BuildOperationTaskStarted: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .buildOperationTaskStarted(self) }
}

// MARK: - Decoding

extension BuildOperationTaskStarted: Decodable {}

extension BuildOperationTaskStarted.TaskDetails: Decodable {}

// MARK: - Encoding

extension BuildOperationTaskStarted: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [
            .int64(taskID),
            .int64(targetID),
            parentTaskID.flatMap { .int64($0) } ?? .nil,
            .array(taskDetails.encode()),
        ]
    }
}

extension BuildOperationTaskStarted.TaskDetails: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [
            .string(taskName),
            .binary(signature),
            .string(ruleInfo),
            .string(executionDescription),
            .string(commandLineDisplayString),
            interestingPath.flatMap { .string($0) } ?? .nil,
            .array(serializedDiagnosticsPaths.map(MessagePackValue.string)),
        ]
    }
}

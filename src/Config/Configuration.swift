import Foundation
import Yaml
import SwiftyJSON

public enum ConfigurationParserError: Error {
    case invalidYamlFile, noRuleDefined, ruleTypeMissing, unknownRuleType, ruleParsingError(errorInfo: String), noAdapterDefined, adapterIDMissing, adapterTypeMissing, adapterTypeUnknown, adapterParsingError(errorInfo: String)
}

/// The configuration file parser.
///
/// Note: It is not recommended to use this class in production app. This is merely used as a helper to build a toy app.
open class Configuration {
    var adapterFactoryManager: AdapterFactoryManager!
    open var proxyPort: Int?
    open var ruleManager: RuleManager!

    public init() {}

    open func load(fromConfigString configString: String) throws {
        
        
        
        let config = JSON(parseJSON: configString)
        loadConfig(config)
        adapterFactoryManager = try AdapterFactoryParser.parseAdapterFactoryManager(config["adapter"])
        ruleManager = try RuleParser.parseRuleManager(config["rule"], adapterFactoryManager: adapterFactoryManager)
    }

    open func load(fromConfigFile filepath: String) throws {
        let configString = try String(contentsOfFile: filepath)
        try load(fromConfigString: configString)
    }

    func loadConfig(_ config: JSON) {
        if let port = config["port"].int {
            proxyPort = port
        }
    }

}

extension JSON {
    var stringOrIntString: Swift.String? {
        return string ?? int?.description
    }
}

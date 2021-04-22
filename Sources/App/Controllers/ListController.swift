//
//  ListController.swift
//  
//
//  Created by Aaron Hinton on 4/11/21.
//

import Foundation
import Vapor

//List available devices, device types, runtimes, or device pairs.
//Usage: simctl list [-j | --json] [-v] [devices|devicetypes|runtimes|pairs] [<search term>|available]
//-j     Print as JSON
//-v     More verbose output
//
//Specify one of 'devices', 'devicetypes', 'runtimes', or 'pairs' to list only items of that type. If a type filter is specified you may also specify a search term. Search terms use a simple case-insensitive contains check against the item's description. You may use the search term 'available' to only list available items.
class ListController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get("list", use: listAll)
        routes.get("list", "devices", use: listDevices)
        routes.get("list", "devicetypes", use: listDeviceTypes)
        routes.get("list", "pairs", use: listPairs)
        routes.get("list", "runtimes", use: listRuntimes)
    }
    
    func listAll(_ req: Request) throws -> DeviceList {
        let output = shell("xcrun simctl list --json")
        guard let deviceList = try? JSONDecoder().decode(DeviceList.self, from: output) else {
            throw SimctlError.parseError(nil)
        }
        return deviceList
    }

    func listDevices(_ req: Request) throws -> [String: [Device]] {
        let output = shell("xcrun simctl list devices --json")
        guard let devicesJSON = try? JSONDecoder().decode([String: [String: [Device]]].self, from: output),
            let devices = devicesJSON["devices"] else {
            throw SimctlError.parseError(nil)
        }
        return devices
    }

    func listDeviceTypes(_ req: Request) throws -> [DeviceType] {
        let output = shell("xcrun simctl list devicetypes --json")
        guard let deviceTypesJSON = try? JSONDecoder().decode([String: [DeviceType]].self, from: output),
            let deviceTypes = deviceTypesJSON["devicetypes"] else {
            throw SimctlError.parseError(nil)
        }
        return deviceTypes
    }

    func listPairs(_ req: Request) throws -> [String: Pair] {
        let output = shell("xcrun simctl list pairs --json")
        guard let pairsJSON = try? JSONDecoder().decode([String: [String: Pair]].self, from: output),
            let pairs = pairsJSON["pairs"] else {
            throw SimctlError.parseError(nil)
        }
        return pairs
    }

    func listRuntimes(_ req: Request) throws -> [Runtime] {
        let output = shell("xcrun simctl list runtimes --json")
        guard let runtimesJSON = try? JSONDecoder().decode([String: [Runtime]].self, from: output),
            let runtimes = runtimesJSON["runtimes"] else {
            throw SimctlError.parseError(nil)
        }
        return runtimes
    }
}

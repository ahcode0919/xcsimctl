//
//  RuntimeController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// Locate, copy, mount, and unmount simulator runtime disk images.
// Usage: simctl runtime <operation> <arguments>
//
// Supported Operations:
//    mount <train-build> [--shadow <path>] [--internal | --customer] [--no-mount] [--no-copy] [--print-only] [--max-cache-size <size>]
//    [--cache-path <path>] [--mountpoint <mount location>]
//    Locate a Simulator Runtime for the given train and build, copy the disk image locally, then mount it to make the runtime available to CoreSimulator.
//
//    --shadow <path>
//         Manually specify a different shadow image. The main disk image is always mounted read-only and is compressed.
//         Decompressed and/or modified blocks are written to the shadow image.
//    --internal
//         (Default) Select the internal runtime.
//    --customer
//         Select the customer (public) runtime.
//    --use-nfa
//         Download the desired image from NFA. If this is not passed in, the image is copied down from the network.
//    --no-mount
//         Copy the image to the cache (if not present), but do not actually mount it. Prints the path of the image as the last line of output.
//    --no-copy
//         Do not copy the runtime disk image locally, mount it directly from the network. This degrades performance.
//         If --use-nfa is passed in, this has no effect.
//         If the network connection is lost simulator processes, Xcode, Console, Safari, and Simulator.app will abort with SIGBUS.
//    --print-only
//         Print the path to the image on the network but take no other action.
//
//
//    unmount <train-build> [--force]
//    Unmount the Simulator Runtime if it is mounted. Any booted simulators will be shut down first.
//    The alias 'all' will unmount all runtime disk images known to CoreSimulator.
//
//    --force
//         Force-unmount even if the disk is busy.
//
//
//    cache [list | clear [--dry-run]] [--cache-path <path>]
//    list
//         Lists cached runtime disk images
//
//    clear
//         Deletes all simulator runtime disk images (excludes runtimes bundled with Xcode or downloaded runtimes in /Library).
//         Any mounted runtimes are unmounted before deletion.
//
//    --dry-run
//         Run the clear command but print what would have been deleted, without actually deleting anything.
//
//
//    pin <device> [--latest | --build <train-version> | --path <path to runtime>]
//    Pin a device to use a specific runtime.
//
//    --latest
//         (Default) Use the latest build of the major.minor.revision runtime.
//    --build <train-version>
//         Pin the device to use a specific build of the runtime. If multiple runtimes match one is randomly chosen.
//    --path <path to runtime>
//         Pin the device to use a specific runtime by path.
//
//
//    info [path] [<platform> | <train-build>]
//    path
//         Lists the path to the runtime (the path may contain spaces!)
//         If no platform or train-build is specified then the iOS runtime bundled with the selected Xcode is chosen.
//         Platform may be iOS, tvOS, or watchOS to select the relevant Xcode-bundled runtime.
//
//
//    update_dyld_shared_cache (<platform> | <train-build>)
//    Update the dyld shared cache for a specific runtime.
//
//    platform | train-build
//         Platform may be iOS, tvOS, or watchOS to select the relevant Xcode-bundled runtime.
//         Otherwise the value is assumed to be a train-build and the relevant mounted disk image is used.
//         If using manually-mounted images or multiple mount points, pass the path to the mountpoint.
//
//         The dyld_sim shared caches are stored in ~/Library/Developer/CoreSimulator/Caches.
//         The cache is tied to the specific build of the runtime and the host macOS.
//         If you upgrade macOS, the caches will be re-built automatically by CoreSimulator in the background
//         at low priority. In all cases, caches for a macOS that isn't the current macOS will be automatically scheduled for deletion.
//
//
// A <train-version> means a train name (case-sensitive) and build number, such as 'Example10A101'.
// The only supported alias is 'Current', eg 'CurrentExample'.
//
// Unless a simulated device specifies an explicit build, it will boot with the newest build of the given platform
// and matching major.minor.revision. For example if a device was created with iOS 12.0, it will prefer the newest
// build of iOS 12.0 it can find. You can have as many builds of iOS 12 mounted as you like, but only devices pinned to
// a runtime will use any other build besides the latest. To change an existing device's pinning use pin (see above).
//
// To create a device pre-pinned to a runtime specify the runtime as a path to the mounted volume rather than an
// identifier, eg: simctl create <name> <devicetype> /Volumes/Example10A101

// Other commands that take a runtime identifier (such as simctl darwinup) also accept a <train-version> or path to the
// disk image mount point, so long as you specify enough information to uniquely identify a single runtime. If the
// specifier is ambiguous simctl will error rather than making any assumptions.
//
// By default up to 50 GB of runtime images are cached locally for greatly improved performance. Old images are deleted
// when the cache grows too large. The cache-path and max-cache-size default values can be modified by setting user
// defaults:
//  defaults write com.apple.CoreSimulator RuntimeImageCachePath '<path>'
//  defaults write com.apple.CoreSimulator RuntimeImageCacheMaxSizeGB 10
// All commands accept --cache-path <path> to override the user default.
// Only the mount command automatically prunes the cache and it accepts --max-cache-size <size in GB> to override the user default.
//
// The default paths searched on the network can be changed or expanded. This should be to the Images subdirectory:
//  defaults write com.apple.CoreSimulator RuntimeImageSearchPaths -array-add '/MountPoint/Team/Images'
//
// CoreSimulator monitors for disk mount and unmount notifications, so you can manually locate the image and mount it
// if simctl does not meet your needs, eg:
//  hdiutil attach <image> -mountpoint /Volumes/Example10A101 -shadow
//  hdiutil detach /Volumes/Example10A101

class RuntimeController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["runtime"], use: runtime)
    }
    
    func runtime(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}

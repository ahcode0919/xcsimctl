# xcsimctl ![](https://github.com/ahcode0919/xcsimctl/actions/workflows/swift.yml/badge.svg?branch=main)

A xcrun simctl API server built in Swift + Vapor. Currently under development.

## Setup

- Requires XCode 11.2+
- Requires Homebrew
- Install Vapor - `brew install vapor`
- Run application - `vapor run`

## Usage

- Can be run via terminal or Xcode build scripts
- Default base address is:  `http://127.0.0.1:8080`
- Postman collection provided for testing endpoints [Collection](./xcximctl.postman_collection.json)
    * Get Postman [Postman](https://www.postman.com)

## Supported Endpoints

- `GET  /` - App information
- `POST /boot/:devicename` (`simctl boot :devicename`) - Boot simulator
- `POST /clone/:devicename/:newdevicename` (`simctl clone :devicename :newdevicename`) - Clone simulator
- `POST /create/:name/:devicetype`  (`simctl create :name :devicetype`) - Create simulator with specified devicetype
- `POST /create/:name/:devicetype/?runtime=`  (`simctl create :name :devicetype runtime`) - Create simulator with specified devicetype and runtime
- `POST /delete?devices={name,name2}`  (`simctl delete name name2`) - Delete one or more simulators by name (comma separated)
- `POST /delete/:devicename`  (`simctl delete :devicename`) - Erase single device
- `POST /delete/all`  (`simctl delete all`) - Delete all simulators
- `POST /delete/unavailable`  (`simctl delete unavailable`) - Delete all unavailable simulators
- `POST /erase?devices={name,name2}`  (`simctl erase name name2`) - Erase one or more simulators by name (comma separated)
- `POST /erase/:devicename`  (`simctl erase :devicename`) - Erase single device
- `POST /erase/all`  (`simctl erase all`) - Erase all simulators
- `GET  /list`  (`simctl list`) - list all devices, device types, pairs, and runtimes
- `GET  /list/devices` (`simctl list devices`) - list devices
- `GET  /list/devicetypes` (`simctl list devicetypes`) - list device types
- `GET  /list/pairs` (`simctl list pairs`) - list device pairs
- `GET  /list/runtimes` (`simctl list runtimes`) - list runtimes
- `GET  /ping` - Verify healthy server
- `POST /rename/:devicename/:newname` (`simctl rename :devicename :newname`) - Rename simulator
- `POST /shutdown/:devicename` (`simctl shutdown :devicename`) - Shutdown simulator
- `POST /shutdown/all` (`simctl shutdown all`) - Shutdown all simulators

## Roadmap

Project currently under development

```
Complete - create   Create a new device.
Complete - clone    Clone an existing device.
upgrade             Upgrade a device to a newer runtime.
Complete - delete   Delete spcified devices, unavailable devices, or all devices.
pair                Create a new watch and phone pair.
unpair              Unpair a watch and phone pair.
pair_activate       Set a given pair as active.
Complete - erase    Erase a device's contents and settings.
Complete - boot     Boot a device.
Complete - shutdown Shutdown a device.
Complete - rename   Rename a device.
getenv              Print an environment variable from a running device.
openurl             Open a URL in a device.
addmedia            Add photos, live photos, videos, or contacts to the library of a device.
install             Install an app on a device.
uninstall           Uninstall an app from a device.
get_app_container   Print the path of the installed app's container
launch              Launch an application by identifier on a device.
terminate           Terminate an application by identifier on a device.
spawn               Spawn a process by executing a given executable on a device.
Complete - list     List available devices, device types, runtimes, or device pairs.
icloud_sync         Trigger iCloud sync on a device.
pbsync              Sync the pasteboard content from one pasteboard to another.
pbcopy              Copy standard input onto the device pasteboard.
pbpaste             Print the contents of the device's pasteboard to standard output.
help                Prints the usage for a given subcommand.
io                  Set up a device IO operation.
diagnose            Collect diagnostic information and logs.
logverbose          enable or disable verbose logging for a device
status_bar          Set or clear status bar overrides
ui                  Get or Set UI options
push                Send a simulated push notification
privacy             Grant, revoke, or reset privacy and permissions
keychain            Manipulate a device's keychain
```

- `/list` - add search term query

- Implement GET endpoints
- Implement Post (string data) endpoints
- Implement "Upload" endpoints
- Add Log file handling
- Add Homebrew forumula
- Add Swift Package Manager support
- Add Open simulator automation (AppleScript)
- Add dummy iOS app to test functionality
- Add Simulator configuration manipulation

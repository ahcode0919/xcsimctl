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
- `POST /boot/:device` (`simctl boot :device`) - Boot simulator
- `POST /clone/:devicename/:newdevicename` (`simctl clone :devicename :newdevicename`) - Clone simulator
- `POST /create/:name/:devicetype`  (`simctl create :name :devicetype`) - Create simulator with specified devicetype
- `POST /create/:name/:devicetype/?runtime=`  (`simctl create :name :devicetype runtime`) - Create simulator with specified devicetype and runtime
- `POST /delete?devices={name,name2}`  (`simctl delete name name2`) - Delete one or more simulators by name (comma separated)
- `POST /delete/:device`  (`simctl delete :device`) - Erase single device
- `POST /delete/all`  (`simctl delete all`) - Delete all simulators
- `POST /delete/unavailable`  (`simctl delete unavailable`) - Delete all unavailable simulators
- `POST /erase?devices={name,name2}`  (`simctl erase name name2`) - Erase one or more simulators by name (comma separated)
- `POST /erase/:device`  (`simctl erase :device`) - Erase single device
- `POST /erase/all`  (`simctl erase all`) - Erase all simulators
- `GET  /list`  (`simctl list`) - list all devices, device types, pairs, and runtimes
- `GET  /list/devices` (`simctl list devices`) - list devices
- `GET  /list/devicetypes` (`simctl list devicetypes`) - list device types
- `GET  /list/pairs` (`simctl list pairs`) - list device pairs
- `GET  /list/runtimes` (`simctl list runtimes`) - list runtimes
- `POST /openurl/:device` (`simctl openurl :device :url`) - Open URL on device
- `GET  /ping` - Verify healthy server
- `POST /rename/:devicename/:newdevicename` (`simctl rename :devicename :newdevicename`) - Rename simulator
- `POST /shutdown/:device` (`simctl shutdown :device`) - Shutdown simulator
- `POST /shutdown/all` (`simctl shutdown all`) - Shutdown all simulators

## Roadmap

Project currently under development

```
addmedia            Add photos, live photos, videos, or contacts to the library of a device
addphoto            Add photo
addvideo            Add video
Complete - appinfo  Show application information
Complete - boot     Boot a device
bootstatus          Device boot status
Complete - create   Create a new device
Complete - clone    Clone an existing device
darwinup            Install a root for the specified simulator runtime
Complete - delete   Delete spcified devices, unavailable devices, or all devices
diagnose            Collect diagnostic information and logs
disk                Perform disk/volume operations
Complete - erase    Erase a device's contents and settings
get_app_container   Print the path of the installed app's container
getenv              Print an environment variable from a running device
help                Prints the usage for a given subcommand
icloud_sync         Trigger iCloud sync on a device
install             Install an app on a device
io                  Set up a device IO operation
keyboard            Specify keyboard locale
keychain            Manipulate a device's keychain
launch              Launch an application by identifier on a device
Complete - list     List available devices, device types, runtimes, or device pairs
listapps            List applications on device
logverbose          enable or disable verbose logging for a device
monitor             Print notifications as they are detected
notify_get_state    Get the state value of a darwin notification on a device
notify_post         Post a darwin notification on a device
notify_set_state    Set the state value of a darwin notification on a device
Complete - openurl  Open a URL in a device
pair                Create a new watch and phone pair
pair_activate       Set a given pair as active
pbcopy              Copy standard input onto the device pasteboard
pbinfo              pasteboard information
pbpaste             Print the contents of the device's pasteboard to standard output
pbsync              Sync the pasteboard content from one pasteboard to another
privacy             Grant, revoke, or reset privacy and permissions
push                Send a simulated push notification
register            Register a service from one bootstrap into another
Complete - rename   Rename a device
reset               Reset launch subsystems
runtime             Locate, copy, mount, and unmount simulator runtime disk images
Complete - shutdown Shutdown a device
spawn               Spawn a process by executing a given executable on a device
status_bar          Set or clear status bar overrides
terminate           Terminate an application by identifier on a device
ui                  Get or Set UI options
uninstall           Uninstall an app from a device
unpair              Unpair a watch and phone pair
unregister          Unregister a service from a device's bootstrap
upgrade             Upgrade a device to a newer runtime
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

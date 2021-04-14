# xcsimctl

A xcsimctl API server built in Swift. Currently under development.

## Setup

- Requires XCode 11.2+
- Requires Homebrew
- Install Vapor - `brew install vapor`
- Run application - `vapor run`

## Endpoints

- `/` - App information
- `/list`  (`simctl list`) - list devices and runtimes
- `/ping` - Verify healthy server

## Roadmap

Project currently under development

- Implement place holder endpoints
```
create              Create a new device.
clone               Clone an existing device.
upgrade             Upgrade a device to a newer runtime.
delete              Delete spcified devices, unavailable devices, or all devices.
pair                Create a new watch and phone pair.
unpair              Unpair a watch and phone pair.
pair_activate       Set a given pair as active.
erase               Erase a device's contents and settings.
boot                Boot a device.
shutdown            Shutdown a device.
rename              Rename a device.
getenv              Print an environment variable from a running device.
openurl             Open a URL in a device.
addmedia            Add photos, live photos, videos, or contacts to the library of a device.
install             Install an app on a device.
uninstall           Uninstall an app from a device.
get_app_container   Print the path of the installed app's container
launch              Launch an application by identifier on a device.
terminate           Terminate an application by identifier on a device.
spawn               Spawn a process by executing a given executable on a device.
X - list            List available devices, device types, runtimes, or device pairs.
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
- Add Build environment for testing
- Implement GET endpoints
- Implement Post (string data) endpoints
- Implement "Upload" endpoints
- Add Log file handling
- Add Homebrew forumula
- Add Swift Package Manager support
- Add Open simulator automation (AppleScript)
- Add dummy iOS app to test functionality
- Add Simulator configuration manipulation

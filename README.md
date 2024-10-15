# Payment Service Helper Script

This batch script automates several tasks related to the Payment Service, including checking for connected pinpads, required files, firmware presence, and journal logs. It also starts the Payment Service after performing these checks.

## Features

- **Pinpad Connection Check**: Scans specific COM ports to verify if a pinpad is connected.
- **File Existence Check**: Ensures required files (e.g., configuration files, marker files) are present in the working directory.
- **Firmware Handling**: Checks for firmware files and renames them for easy pinpad reload.
- **Journal Logs**: Searches for specific log files and pinpad serial numbers in the logs.
- **Service Management**: Stops the Payment Service and restarts it after performing all checks.

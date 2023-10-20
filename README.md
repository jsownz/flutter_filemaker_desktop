# Flutter FileMaker for Desktop
 An open sourcce implementation of FileMaker for Desktop built in Flutter

---

## Initial Setup
### Appwrite
For a self-hosted solution, you will need to setup an Appwrite server. Local and cloud hosted solutions are planned for future releases. Self-hosted was chosen first because I believe it would handle most use-cases for this - locally maintained server for a small-ish business.
Install Appwrite from directions on their site: [Appwrite : Self-hosting](https://appwrite.io/docs/advanced/self-hosting).
Once installed, have your Appwrite Server URL and Appwrite Project ID available, you will be prompted for these on first launch of Flutter Filemaker for Windows. 

## Roadmap
Initial focus will be on Windows (>10), once the basic features are built out and working, additional platform support will be added (Linux, Android - MacOS and iOS last, unless someone decides to take that portion of the project.)

#### Main App
- Window
  - [ ] resizable
  - [ ] custom window controls
  - [ ] custom menu button
  - [ ] movable
- Create elements
  - [ ] label
  - [ ] text box
  - [ ] textarea
  - [ ] check box

#### Database
- Select Database Connector
  - [ ] SQLite3 (local)
  - [ ] Appwrite (Self-hosted)
  - [ ] Firebase (cloud hosted)
  - [ ] Other? (Maybe some other type of standard backend, MySQL, Postgresql, etc)
- Appwrite Support
  - [ ] connect to Appwrite DB
  - create initial database collections
    - [ ] layouts
    - [ ] layout_elements


### Build notes
#### Riverpod
- riverpod build_runner for generating providers with riverpod annotation: dart run build_runner watch
#### SQLite3
- Linux: sudo apt-get -y install libsqlite3-0 libsqlite3-dev
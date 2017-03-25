# GitFame
A Swift CLI that logs your GitHub Stars and Forks.

## Note
This tool performs **2** requests to GitHub's API without authentication. The end-user will be rate-limited at 60 reqs/hr.

## Installation
- Run `make` to install `gitfame` to `/usr/local/bin`.
- Run `make uninstall` to remove `gitfame` from `/usr/local/bin`,

```shell
$gitfame <GitHub_Username>
```

## Example

```
$gitfame artsabintsev
... Welcome to GitFame! ...
... Fetching Stars (★) and Forks (⑂) for GitHub user (artsabintsev) on Mar 25, 2017 3:14:07 PM ...

artsabintsev has 6591 ★ and 644 ⑂

Harpy                                             2248 ★ / 278 ⑂
Siren                                             1715 ★ / 134 ⑂
FontBlaster                                       777 ★ / 52 ⑂
Guitar                                            472 ★ / 18 ⑂
Zephyr                                            343 ★ / 23 ⑂
Magic                                             288 ★ / 11 ⑂
UIFloatLabelTextField                             265 ★ / 40 ⑂
Solarized-Dark-for-Xcode                          245 ★ / 44 ⑂
UIFloatLabelTextView                              140 ★ / 19 ⑂
Asynchronous-Freeloader                           20 ★ / 3 ⑂
ASPullToRefresh                                   14 ★ / 2 ⑂
UIDevice-SupportedDevices                         13 ★ / 3 ⑂
MaterialSwitch                                    11 ★ / 1 ⑂
UIView-AutoLayoutView                             9 ★ / 1 ⑂
UIColor-ColorWithHexAndAlpha                      6 ★ / 2 ⑂
MGSplitViewController                             6 ★ / 8 ⑂
Panhandler                                        4 ★ / 1 ⑂
JVFloatLabeledTextField                           2 ★ / 2 ⑂
GitFame                                           2 ★ / 0 ⑂
NSDate-DateFromBSONObjectID                       2 ★ / 0 ⑂
Swift-3-CocoaHeads-DC-Talk                        2 ★ / 0 ⑂
360iDevCodeAndSlides                              1 ★ / 0 ⑂
RealmResultsController                            1 ★ / 0 ⑂
Alamofire                                         1 ★ / 0 ⑂
Apple-Watch-WatchKit-CocoaHeads-DC-Talk-          1 ★ / 1 ⑂
artsabintsev.github.io                            1 ★ / 0 ⑂
swift-algorithm-club                              1 ★ / 1 ⑂
Simple-Class-Portraits                            1 ★ / 0 ⑂
Kitura-net                                        0 ★ / 0 ⑂
Dash-iOS                                          0 ★ / 0 ⑂
Perfect-Notifications                             0 ★ / 0 ⑂
PMKVObserver                                      0 ★ / 0 ⑂
Gamifying-the-News-360iDev-2016                   0 ★ / 0 ⑂
siesta                                            0 ★ / 0 ⑂
MUDRammer                                         0 ★ / 0 ⑂
Curassow                                          0 ★ / 0 ⑂
solar-theme-jekyll                                0 ★ / 0 ⑂
Commander                                         0 ★ / 0 ⑂
Specs                                             0 ★ / 0 ⑂
ssoper.github.io                                  0 ★ / 0 ⑂
swift                                             0 ★ / 0 ⑂
cocoapods-wholemodule                             0 ★ / 0 ⑂
MOB-DC-3                                          0 ★ / 0 ⑂
swift-corelibs-foundation                         0 ★ / 0 ⑂
swift-corelibs-xctest                             0 ★ / 0 ⑂
swift-evolution                                   0 ★ / 0 ⑂
swift-package-manager                             0 ★ / 0 ⑂
SwiftLint                                         0 ★ / 0 ⑂
SwiftPlate                                        0 ★ / 0 ⑂
basic-template                                    0 ★ / 0 ⑂
GeoTrackKit                                       0 ★ / 0 ⑂
homebrew-core                                     0 ★ / 0 ⑂
alcatraz-packages                                 0 ★ / 0 ⑂
ios-icon-generator                                0 ★ / 0 ⑂
AFWebViewController                               0 ★ / 0 ⑂
```

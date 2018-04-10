#!/usr/bin/env bash

sudo -v
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &
host=$(sudo scutil --get LocalHostName)
cat <<EOM

Warning! You are about to update preferences for Safari, Mail, Finder, Dock,
and other OS X apps.

Type-in a name for this computer (it is "${host}" now):
EOM
read -r host

open dark.terminal
sleep 1

defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "1" "d/M/yy "
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "2" "d MMM yyyy"
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "3" "d MMMM yyyy"
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "4" "EEEE, d MMMM yyyy"
defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "1" "H:mm "
defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "2" "H:mm:ss "
defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "3" "H:mm:ss  z"
defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "4" "H:mm:ss  z"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
defaults write NSGlobalDomain AppleLanguages -array "en"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.trackpad.threeFingerDragGesture -int 1
defaults write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 0
defaults write NSGlobalDomain com.apple.trackpad.threeFingerVertSwipeGesture -int 0
defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen 1
defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -bool true
defaults write com.apple.Safari HomePage -string "about:blank"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true \
  && defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true \
  && defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true \
  && defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true \
  && defaults write com.apple.TextEdit RichText -int 0
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock expose-group-by-app -bool false
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock persistent-apps -array ""
defaults write com.apple.dock pinning -string "middle"
defaults write com.apple.dock tilesize -int 72
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
defaults write com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool false
defaults write com.apple.iokit.AmbientLightSensor "Automatic Keyboard Enabled" -bool false
defaults write com.apple.iokit.AmbientLightSensor "Keyboard Dim Time" -int 5
defaults write com.apple.mail DisableInlineAttachmentViewing -bool yes
defaults write com.apple.menuextra.clock DateFormat -string 'EEEE d MMM HH:mm'
defaults write com.apple.screencapture location "${HOME}/Downloads/"
defaults write com.apple.terminal "AutoMarkPromptLines" -int 0
defaults write com.apple.terminal "Default Window Settings" -string "dark"
defaults write com.apple.terminal "Startup Window Settings" -string "dark"
defaults write com.apple.universalaccess reduceTransparency -bool true

find ~/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete

sudo defaults write /Library/Preferences/com.apple.driver.AppleIRController DeviceEnabled -int 0

sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

sudo pmset -a standbydelay 86400
sudo pmset displaysleep 5
sudo pmset hibernatemode 25
sudo pmset sleep 60

sudo scutil --set HostName "$host"
sudo scutil --set ComputerName "$host"
sudo scutil --set LocalHostName "$host"

sudo chflags hidden "${HOME}/Desktop" && echo 'Hide ~/Desktop'
sudo chflags hidden "${HOME}/Documents" && echo 'Hide ~/Documents'
sudo chflags hidden "${HOME}/Movies" && echo 'Hide ~/Movies'
sudo chflags hidden "${HOME}/Music" && echo 'Hide ~/Music'
sudo chflags hidden "${HOME}/Pictures" && echo 'Hide ~/Pictures'
sudo chflags hidden "${HOME}/Applications" && echo 'Hide ~/Applications'
sudo chflags hidden "${HOME}/Public" && echo 'Hide ~/Public'

duti duti.config
touch $HOME/.bash_sessions_disable

killall Dock
killall Finder
killall SystemUIServer

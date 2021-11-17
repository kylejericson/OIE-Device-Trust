#!/bin/bash
# Created by Kyle Ericson

NAME=$(scutil --get LocalHostName)
echo $NAME
loggedInUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! /loginwindow/ { print $3 }' )

DATA='<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>PayloadContent</key>
	<array>
		<dict>
			<key>PayloadContent</key>
			<dict>
				<key>AllowAllAppsAccess</key>
				<true/>
				<key>CertificateRenewalTimeInterval</key>
				<integer>14</integer>
				<key>Challenge</key>
				<string>Replacewithyourvalue</string>
				<key>Key Type</key>
				<string>RSA</string>
				<key>Key Usage</key>
				<integer>1</integer>
				<key>KeyIsExtractable</key>
				<false/>
				<key>Keysize</key>
				<integer>2048</integer>
				<key>Name</key>
				<string>Okta Device Trust</string>
				<key>Subject</key>
				<array>
					<array>
						<array>
							<string>O</string>
							<string>Replacewithyourvalue</string>
						</array>
					</array>
					<array>
						<array>
							<string>CN</string>
							<string>'"$NAME"'</string>
						</array>
					</array>
				</array>
				<key>URL</key>
				<string>Replacewithyourvalue</string>
			</dict>
			<key>PayloadDescription</key>
			<string></string>
			<key>PayloadDisplayName</key>
			<string>SCEP (Okta Device Trust)</string>
			<key>PayloadEnabled</key>
			<true/>
			<key>PayloadIdentifier</key>
			<string>Replacewithyourvalue</string>
			<key>PayloadOrganization</key>
			<string>Replacewithyourvalue</string>
			<key>PayloadType</key>
			<string>com.apple.security.scep</string>
			<key>PayloadUUID</key>
			<string>Replacewithyourvalue</string>
			<key>PayloadVersion</key>
			<integer>1</integer>
		</dict>
	</array>
	<key>PayloadDescription</key>
	<string></string>
	<key>PayloadDisplayName</key>
	<string>Okta Device Trust</string>
	<key>PayloadEnabled</key>
	<true/>
	<key>PayloadIdentifier</key>
	<string>Replacewithyourvalue</string>
	<key>PayloadOrganization</key>
	<string>Replacewithyourvalue</string>
	<key>PayloadRemovalDisallowed</key>
	<true/>
	<key>PayloadScope</key>
	<string>User</string>
	<key>PayloadType</key>
	<string>Configuration</string>
	<key>PayloadUUID</key>
	<string>Replacewithyourvalue</string>
	<key>PayloadVersion</key>
	<integer>1</integer>
</dict>
</plist>
'
echo "$DATA" > "/tmp/Double_Click_Me.mobileconfig"
mv /tmp/Double_Click_Me.mobileconfig /Users/$loggedInUser/Desktop/Double_Click_Me.mobileconfig

for wait_seconds in {1..300}; do
  if [[ -f "/Users/$loggedInUser/Desktop/Double_Click_Me.mobileconfig" ]]; then
    open -b com.apple.systempreferences /System/Library/PreferencePanes/Profiles.prefPane
    sleep 4
    break # Exit loop whenever the file exists to not always wait 5 minutes.
  else
    sleep 1 # Waiting 1 second up to 300 times is a maximum 5 minute wait time.
  fi
done
exit 0
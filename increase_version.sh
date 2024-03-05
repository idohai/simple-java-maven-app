#!/bin/bash
# Read the current version from your pom.xml or build.gradle
CURRENT_VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)

# Split the version string into parts
IFS='.' read -ra VERSION_PARTS <<< "$CURRENT_VERSION"

# Increase the patch version
((VERSION_PARTS[2]++))

# Join the version parts back together
NEW_VERSION="${VERSION_PARTS[0]}.${VERSION_PARTS[1]}.${VERSION_PARTS[2]}"

# Replace the version in your pom.xml or build.gradle
mvn versions:set -DnewVersion="$NEW_VERSION"

echo "Version bumped to $NEW_VERSION"

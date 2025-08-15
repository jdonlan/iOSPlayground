# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an iOS playground repository for experimenting with iOS development concepts. The repository is currently minimal but set up for iOS/Swift development.

## Development Commands

### Xcode Projects
- Build project: `xcodebuild -project ProjectName.xcodeproj -scheme SchemeName build`
- Run tests: `xcodebuild -project ProjectName.xcodeproj -scheme SchemeName test`
- Clean build: `xcodebuild -project ProjectName.xcodeproj -scheme SchemeName clean`

### Xcode Workspaces (when using CocoaPods or SPM)
- Build workspace: `xcodebuild -workspace ProjectName.xcworkspace -scheme SchemeName build`
- Run tests: `xcodebuild -workspace ProjectName.xcworkspace -scheme SchemeName test`

### Swift Package Manager (if Package.swift exists)
- Build: `swift build`
- Run tests: `swift test`
- Run specific target: `swift run TargetName`

### CocoaPods (if Podfile exists)
- Install dependencies: `pod install`
- Update dependencies: `pod update`

## Code Architecture Guidelines

### Project Structure
- Follow standard iOS project structure with separate folders for Views, Models, Controllers, and Services
- Use MARK: comments to organize code sections within files
- Group related files in Xcode groups that mirror folder structure

### Swift Conventions
- Use Swift's built-in naming conventions (camelCase for properties/methods, PascalCase for types)
- Prefer Swift's native types and protocols over Objective-C equivalents
- Use extensions to organize code and conform to protocols
- Leverage Swift's type safety and optionals appropriately

### iOS Development Patterns
- Follow MVC, MVVM, or other established architectural patterns
- Use delegation, closures, or Combine for communication between components
- Implement proper memory management and avoid retain cycles
- Use Auto Layout for UI that works across different screen sizes

## Testing
- Write unit tests in corresponding test targets
- Use XCTest framework for testing
- Test files should mirror the structure of source files
- Run tests frequently during development to catch regressions early
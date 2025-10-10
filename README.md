# app_image

A lightweight Flutter package for handling image loading with built-in caching, placeholders, and error handling. It simplifies displaying images from network or asset sources while ensuring smooth performance and reliability.

## Features

- ✅ Load images from network or local assets  
- 🧠 Built-in caching using `cached_network_image`  
- 🖼️ Display placeholders and error widgets gracefully  
- ⚡ Optimized for performance and low memory usage  
- 🪶 Simple, minimal API with easy integration  

## Getting started

To start using `app_image`, add it to your `pubspec.yaml`:

```bash
flutter pub add app_image
```

Make sure you also have internet permissions for Android and iOS if you plan to load images from the network.

## Usage

Here’s a simple example of how to use `AppImage`:

```dart
import 'package:app_image/app_image.dart';

AppImage(
  imageUrl: 'https://example.com/image.png',
  width: 120,
  height: 120,
  fit: BoxFit.cover,
  placeholder: const CircularProgressIndicator(),
  errorWidget: const Icon(Icons.broken_image),
);
```

This widget automatically caches images and displays a fallback widget in case of loading errors.

## Example

Check the `/example` folder for a full demo showing how to integrate `AppImage` in a Flutter app.

## Additional information

If you encounter issues, please open an issue on the GitHub repository.  
We welcome contributions — feel free to submit a PR for improvements or new features.

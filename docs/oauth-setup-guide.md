# OAuth Authentication Setup Guide for Sayu

## Overview
This guide will help you complete the OAuth authentication setup for Google and Apple Sign-In in the Sayu app.

## Current Implementation Status
✅ OAuth methods added to AuthRemoteDataSource
✅ OAuth methods added to AuthRepository
✅ OAuth use cases created (SignInWithGoogleUseCase, SignInWithAppleUseCase)
✅ AuthBloc updated with OAuth events and handlers
✅ Login screen updated with Google and Apple sign-in buttons
✅ Profile screen updated with authentication state handling
✅ Splash screen updated to check authentication state

## Required Setup Steps

### 1. Generate Dependency Injection Code
Run the following command to generate the updated dependency injection code:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 2. Google OAuth Setup

#### Google Cloud Console
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable Google Sign-In API
4. Create OAuth 2.0 credentials:
   - Web application (for Supabase)
   - iOS client (for iOS app)
   - Android client (for Android app)

#### Supabase Dashboard
1. Go to your Supabase project dashboard
2. Navigate to Authentication > Providers
3. Enable Google provider
4. Add your Google OAuth credentials:
   - Client ID (from web application credentials)
   - Client Secret
5. Add authorized redirect URLs:
   - `http://localhost:3000/auth/v1/callback` (for local development)
   - Your production URL

#### iOS Configuration
1. Add your iOS client ID to `ios/Runner/Info.plist`:
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <!-- Replace with your reversed client ID -->
            <string>com.googleusercontent.apps.YOUR_CLIENT_ID</string>
        </array>
    </dict>
</array>
```

#### Android Configuration
1. Add your SHA-1 fingerprint to Google Cloud Console
2. Download `google-services.json` and place in `android/app/`
3. Ensure the OAuth redirect activity is in `AndroidManifest.xml`

### 3. Apple OAuth Setup

#### Apple Developer Account
1. Sign in to [Apple Developer](https://developer.apple.com/)
2. Create an App ID with Sign in with Apple capability
3. Create a Service ID for web authentication
4. Create a private key for Sign in with Apple

#### Supabase Dashboard
1. Enable Apple provider in Authentication > Providers
2. Add your Apple OAuth credentials:
   - Service ID (Client ID)
   - Team ID
   - Key ID
   - Private Key

#### iOS Configuration
1. Enable Sign in with Apple capability in Xcode
2. Ensure capability is added to `ios/Runner/Info.plist`:
```xml
<key>com.apple.developer.applesignin</key>
<array>
    <string>Default</string>
</array>
```

### 4. Update Environment Variables
Add the OAuth credentials to `/supabase/.env.local`:
```bash
# Google OAuth
GOOGLE_CLIENT_ID=your_actual_google_client_id
GOOGLE_CLIENT_SECRET=your_actual_google_client_secret

# Apple OAuth
APPLE_CLIENT_ID=your_actual_apple_service_id
APPLE_CLIENT_SECRET=your_actual_apple_private_key
```

### 5. Update Deep Link Configuration

#### iOS
Update your app's URL scheme in `ios/Runner/Info.plist`:
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>io.supabase.sayu</string>
            <string>com.yourcompany.sayu</string>
        </array>
    </dict>
</array>
```

#### Android
Ensure the callback activity is properly configured in `android/app/src/main/AndroidManifest.xml`:
```xml
<activity
    android:name="com.linusu.flutter_web_auth_2.CallbackActivity"
    android:exported="true">
    <intent-filter android:label="flutter_web_auth_2">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="io.supabase.sayu" />
    </intent-filter>
</activity>
```

### 6. Test OAuth Flow

1. Start Supabase locally:
```bash
supabase start
```

2. Run the Flutter app:
```bash
flutter run
```

3. Test the OAuth flow:
   - Tap on Google/Apple sign-in button
   - Complete the OAuth flow
   - Verify user is redirected to main screen
   - Check profile screen shows correct user info

### 7. Remove Mock Data (After Testing)
Once OAuth is working correctly:
1. Set `USE_MOCK_DATA=false` in `.env`
2. Ensure all features work with real authentication

## Troubleshooting

### Common Issues

1. **OAuth redirect not working**
   - Verify URL schemes are correctly configured
   - Check Supabase redirect URLs match your configuration
   - Ensure deep links are properly set up

2. **Google Sign-In fails on iOS**
   - Verify reversed client ID is correct
   - Check bundle identifier matches Google Cloud Console

3. **Apple Sign-In not appearing**
   - Ensure Sign in with Apple capability is enabled
   - Verify provisioning profiles are updated

4. **"No session after OAuth sign in" error**
   - Check if cookies are enabled in web view
   - Verify Supabase URL and keys are correct
   - Try increasing the delay in `signInWithGoogle/Apple` methods

## Production Checklist
- [ ] Replace all development OAuth credentials with production ones
- [ ] Update redirect URLs for production domain
- [ ] Test OAuth flow on real devices
- [ ] Ensure all deep links work in production
- [ ] Remove any development-only configurations
- [ ] Test sign out functionality
- [ ] Verify user data is properly stored in database
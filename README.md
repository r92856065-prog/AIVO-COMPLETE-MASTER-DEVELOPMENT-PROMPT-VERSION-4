# JARVIS AI V3 — Android / Kotlin / Jetpack Compose

This is an update of the supplied V2 project. V3 adds Room-backed scheduled reminders, more resilient AI proxy communication, and a GitHub Actions Android build. Existing confirmation and Android-safety behavior is retained.

## Requirements
- Android Studio with JDK 17
- Android SDK Platform 36 and Build Tools 36.0.0 installed
- Gradle 8.13 (the included `gradlew` scripts bootstrap this version; the archive intentionally does not use the binary Gradle Wrapper JAR)

## Configure the AI proxy
1. Deploy `proxy/worker.js` to Cloudflare Workers.
2. Add your provider key as a Worker secret: `wrangler secret put ANTHROPIC_API_KEY`.
3. Optionally set the `ANTHROPIC_MODEL` Worker variable to a model currently enabled for your Anthropic account. The default in this project is `claude-sonnet-4-5-20250929`.
4. Optionally set `ENABLE_WEB_SEARCH` to `true` if web search is enabled for your provider account.
5. Copy `local.properties.example` to `local.properties` and set `JARVIS_PROXY_URL` to your HTTPS Worker endpoint, for example `https://your-worker.your-subdomain.workers.dev`.
6. Keep provider keys and `local.properties` out of Git. Never put the Anthropic key in the Android app.

## Build
Open the extracted `JARVIS-AI-Android-Project-V3` project folder in Android Studio and allow Gradle sync. For a command-line build, use the included bootstrap script (it downloads Gradle 8.13 on first run):

```bash
./gradlew --no-daemon assembleDebug
```

On Windows, use `gradlew.bat --no-daemon assembleDebug`.

The debug APK is created at `app/build/outputs/apk/debug/app-debug.apk`.

GitHub Actions runs the same debug build on pushes to `main` / `master`, pull requests, and manual workflow dispatch. The APK is uploaded as the `jarvis-ai-debug-apk` workflow artifact.

## V3 scheduled reminders
Say a command such as:
- `remind me to stretch in 10 minutes`
- `remind me to call Ali in 2 hours`

The reminder is stored in Room and scheduled with Android `AlarmManager`. Pending reminders are restored after device reboot. Android may defer non-exact alarms during Doze/battery-saving modes; exact-to-the-second delivery is not guaranteed. The reminder notification requires notification permission on Android 13+.

## Existing safety behavior retained
- WhatsApp and SMS messages are read back and require a spoken confirmation before the relevant app/composer is opened. JARVIS does not send them.
- Calls open the dialer; the user places the call.
- Alarms and timers are handed to the Clock app and must be checked there.
- The app does not claim to change restricted Android settings or operate other apps invisibly.
- Microphone capture starts only after an explicit user action. No always-on wake word is included.
- Conversation history remains opt-in.

## Release notes / limitations
- This source package has not been built or tested on a physical Android device in this environment. Run the CI workflow or build in Android Studio before installing/releasing.
- Configure and test your own Cloudflare Worker and provider account. Provider model availability can change.
- Complete and host the privacy policy template in `docs/PRIVACY_POLICY_TEMPLATE.md` before public release.
- For a Play Store release, verify current target API, foreground-service declarations, data safety, and signing requirements.
- Do not commit `local.properties`, signing keys, or provider secrets.

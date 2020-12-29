# Auth0 Example
## DOES NOT WORK - Cant get promptAsync binding right
<p>
  <!-- iOS -->
  <img alt="Supports Expo iOS" longdesc="Supports Expo iOS" src="https://img.shields.io/badge/iOS-4630EB.svg?style=flat-square&logo=APPLE&labelColor=999999&logoColor=fff" />
  <!-- Android -->
  <img alt="Supports Expo Android" longdesc="Supports Expo Android" src="https://img.shields.io/badge/Android-4630EB.svg?style=flat-square&logo=ANDROID&labelColor=A4C639&logoColor=fff" />
  <!-- Web -->
  <img alt="Supports Expo Web" longdesc="Supports Expo Web" src="https://img.shields.io/badge/web-4630EB.svg?style=flat-square&logo=GOOGLE-CHROME&labelColor=4285F4&logoColor=fff" />
</p>

## 🚀 How to use

- Install with `yarn` or `npm install`.
- Create your own app on [Auth0](https://auth0.com).
- Add the `AuthSession` auth URL to `Allowed Callback URLs` on Auth0.
- Open `App.js` and replace `auth0ClientId` and `auth0Domain` with your app settings.
- Run [`expo start`](https://docs.expo.io/versions/latest/workflow/expo-cli/), try it out.

#### AuthSession callback URL

The AuthSession helps you with browser authentication, without the need of an additional server or website. To use this with Auth0 authentication flows, we need to tell Auth0 that the callback URLs are allowed.

Each Expo user has it's own URL for different projects, the basic structure of this URL is `https://auth.expo.io/@your-username/your-expo-app-slug`. If you are signed in as `awesome-ppl`, and your app is called `meme-explorer`, your URL looks like `https://auth.expo.io/@awesome-ppl/meme-explorer`.

> [Read more about AuthSession here](https://docs.expo.io/versions/latest/sdk/auth-session/)

#### Auth0 app settings

Both the `auth0ClientId` and `auth0Domain` needs to match your Auth0 app settings.

![Application Settings](https://i.imgur.com/Io9I4qg.jpg)

## 📝 Notes

- [Expo AuthSession docs](https://docs.expo.io/versions/latest/sdk/auth-session/)
- [Auth0 React/SPA quickstart guide](https://auth0.com/docs/quickstart/spa/react)


## AuthO

You are downloading a working sample configured for  the application RescriptWithAuth0

To run the sample follow these steps:

1. Set the Allowed Callback URLs in the Application Settings so it works for both Android and iOS apps:

```bash
com.auth0samples://klik.eu.auth0.com/ios/com.auth0samples/callback,com.auth0samples://klik.eu.auth0.com/android/com.auth0samples/callback
# for expo its:
https://auth.expo.io/@idkjs/rescript-with-auth0
```

2. Set the Allowed Logout URLs in the Application Settings so it works for both Android and iOS apps:

```bash
com.auth0samples://klik.eu.auth0.com/ios/com.auth0samples/callback,com.auth0samples://klik.eu.auth0.com/android/com.auth0samples/callback
```

3. Make sure Node.JS LTS, Yarn and CocoaPods are installed.

4. Execute the following commands in the sample's directory:

```bash
yarn install # Install dependencies
cd ios && pod install # Install the iOS module Pod
yarn run ios # Run on iOS device
yarn run android # Run on Android device

```

```json
result:  {"type":"success","error":null,"url":"exp://127.0.0.1:19000/--/expo-auth-session#id_token=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik4wWTFOemMzTjBSRlJEYzBSRUpFTWtZMVEwWTFNekJGUmpnNE1UY3hSRUl4TnprMU1VUkROQSJ9.eyJnaXZlbl9uYW1lIjoiQWxhaW4iLCJmYW1pbHlfbmFtZSI6IkFybWFuZCIsIm5pY2tuYW1lIjoiYWFybWFuZC5pbmJveCIsIm5hbWUiOiJBbGFpbiBBcm1hbmQiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tLy1BblRXMzVtYjFnZy9BQUFBQUFBQUFBSS9BQUFBQUFBQUFBQS9BTVp1dWNrNnFmV2txQ0R1TWl5cmMzbEJzS2FQWHlMRWl3L3M5Ni1jL3Bob3RvLmpwZyIsImxvY2FsZSI6ImVuIiwidXBkYXRlZF9hdCI6IjIwMjAtMTItMjhUMTY6NTM6MjcuMDYwWiIsImlzcyI6Imh0dHBzOi8va2xpay5ldS5hdXRoMC5jb20vIiwic3ViIjoiZ29vZ2xlLW9hdXRoMnwxMTA1MDg2MTQzNzMxNzI4ODQ5MzYiLCJhdWQiOiJHRHVpcTR4MXJlSlhzOGE2eURYZ3FKY05BYzhRQk9qWCIsImlhdCI6MTYwOTE3NDQwNywiZXhwIjoxNjA5MjEwNDA3LCJub25jZSI6Im5vbmNlIn0.yM86ZvDrJnOV616iYbMOS7vYb6Pn2MVzgmwv2ngkL3pN-UEMDssDP8z3N3u0cwlYUxh0Qr8233x8yYzzDxduj_78TU3AgnD3uLmsiKvhnghro61jTCWTTWsrsb8tcF19wycvxFleELtf7qJfDx6-SL_FVTmsWR7vy2cTfjD7y9I0UajwBpMj82KdtaHD37UT9V0eokxD-4-E7VkiWVpwQBtubSFEgJ8BX6mPXVNN8l4RONzaJjacyQKmBFTJqxscV44YMueHtcGD0Zk1_X4ysbtZSEciZTBQt-sWi_LXAfdfMJuq7_xQrOTST5mQzBAfkVAnywRJE3fo55WETcL7iA&state=ieGcnyLXwo","params":{"exp://127.0.0.1:19000/--/expo-auth-session":"","id_token":"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik4wWTFOemMzTjBSRlJEYzBSRUpFTWtZMVEwWTFNekJGUmpnNE1UY3hSRUl4TnprMU1VUkROQSJ9.eyJnaXZlbl9uYW1lIjoiQWxhaW4iLCJmYW1pbHlfbmFtZSI6IkFybWFuZCIsIm5pY2tuYW1lIjoiYWFybWFuZC5pbmJveCIsIm5hbWUiOiJBbGFpbiBBcm1hbmQiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tLy1BblRXMzVtYjFnZy9BQUFBQUFBQUFBSS9BQUFBQUFBQUFBQS9BTVp1dWNrNnFmV2txQ0R1TWl5cmMzbEJzS2FQWHlMRWl3L3M5Ni1jL3Bob3RvLmpwZyIsImxvY2FsZSI6ImVuIiwidXBkYXRlZF9hdCI6IjIwMjAtMTItMjhUMTY6NTM6MjcuMDYwWiIsImlzcyI6Imh0dHBzOi8va2xpay5ldS5hdXRoMC5jb20vIiwic3ViIjoiZ29vZ2xlLW9hdXRoMnwxMTA1MDg2MTQzNzMxNzI4ODQ5MzYiLCJhdWQiOiJHRHVpcTR4MXJlSlhzOGE2eURYZ3FKY05BYzhRQk9qWCIsImlhdCI6MTYwOTE3NDQwNywiZXhwIjoxNjA5MjEwNDA3LCJub25jZSI6Im5vbmNlIn0.yM86ZvDrJnOV616iYbMOS7vYb6Pn2MVzgmwv2ngkL3pN-UEMDssDP8z3N3u0cwlYUxh0Qr8233x8yYzzDxduj_78TU3AgnD3uLmsiKvhnghro61jTCWTTWsrsb8tcF19wycvxFleELtf7qJfDx6-SL_FVTmsWR7vy2cTfjD7y9I0UajwBpMj82KdtaHD37UT9V0eokxD-4-E7VkiWVpwQBtubSFEgJ8BX6mPXVNN8l4RONzaJjacyQKmBFTJqxscV44YMueHtcGD0Zk1_X4ysbtZSEciZTBQt-sWi_LXAfdfMJuq7_xQrOTST5mQzBAfkVAnywRJE3fo55WETcL7iA","state":"ieGcnyLXwo"},"authentication":null,"errorCode":null}
```

// /**
//  * For requesting an authorization code as described by [Section 4.1.1](https://tools.ietf.org/html/rfc6749#section-4.1.1).
//  */
// Code = "code",
// /**
//  * For requesting an access token (implicit grant) as described by [Section 4.2.1](https://tools.ietf.org/html/rfc6749#section-4.2.1).
//  */
// Token = "token",
// /**
//  * A custom registered type for getting an `id_token` from Google OAuth.
//  */
// IdToken = "id_token"
%%raw(`import { getRedirectUrl } from 'expo-auth-session';`)

module ResponseType = {
  type t = string
  @bs.inline
  let code = "code"
  @bs.inline
  let token = "token"
  @bs.inline
  let idToken = "id_token"
}
module Scopes = {
  type t = string
  @bs.inline
  let openId = "openid"
  @bs.inline
  let profile = "profile"
}

type extraParams = {
  // ideally, this will be a random value
  nonce: string,
}

type authorizationEndpoint = string
type scopes = [#openid | #profile]
type authRequestConfig = {
  responseType: option<ResponseType.t>,
  clientId: string,
  redirectUri: string,
  scopes: option<array<Scopes.t>>,
  //   clientSecret: option<string>,
  //   codeChallengeMethod: option<CodeChallengeMethod.t>,
  //   codeChallenge: Js.Nullable.t<string>,
  //   prompt: option<Prompt.t>,
  //   state: option<string>,
  extraParams: option<extraParams>,
  //   usePKCE: option<bool>,
}
// type authSessionResult_1_errorCode = Js.Nullable.t<string>
// type authSessionResult_1_authentication = Js.Nullable.t<Js.Json.t>;
module AuthSessionResultError = {
  type rec t = {
    @bs.as("type")
    type_: [#error | #success],
    errorCode: Js.Nullable.t<string>,
    error: Js.Nullable.t<Js.Json.t>,
  }
  //   let notification = n => (string_of_int(n), "")
  let errorResult = n => n
}
// export declare type AuthSessionResult = {
//     type: 'cancel' | 'dismiss' | 'locked';
// } | {
//     type: 'error' | 'success';
//     errorCode: string | null;
//     error?: AuthError | null;
//     params: {
//         [key: string]: string;
//     };
//     authentication: TokenResponse | null;
//     url: string;
// };
type authSessionRedirectUriOptions = {
  native: Js.Nullable.t<string>,
  path: Js.Nullable.t<string>,
  useProxy: Js.Nullable.t<bool>,
  preferLocalhost: Js.Nullable.t<bool>,
}
module AuthSessionResult = {
  type t = {
    @bs.as("type")
    type_: [#cancel | #dismissed | #locked | #error | #success],
    errorCode: Js.Nullable.t<string>,
    authentication: Js.Nullable.t<Js.Json.t>,
    url: string,
  }
  //   let authSessionResult = (v: t) => t
}
type authSessionResult = AuthSessionResult.t
type authRequestPromptOptions = {
  url: option<string>,
  useProxy: option<bool>,
}
type useProxy = bool
// type promptAsync = (useProxy)=> Js.Promise.t<AuthSessionResult.t>
type authRequest = {
  request: authRequestConfig,
  authorizationEndpoint: authorizationEndpoint,
}
type authRequestResult = {
  url: Js.Nullable.t<string>,
  promptAsync: useProxy => Js.Promise.t<AuthSessionResult.t>,
  request: option<authRequestConfig>,
  result: authSessionResult,
}
// type asyncStorageState = {
//   getItem: unit => Js.Promise.t<Js.Null.t<string>>,
//   setItem: string => Js.Promise.t<unit>,
//   mergeItem: string => Js.Promise.t<unit>,
//   removeItem: unit => Js.Promise.t<unit>,
// }

// @bs.module("@react-native-async-storage/async-storage")
// external useAsyncStorage: string => asyncStorageState = "useAsyncStorage"
type t
@bs.module external authSession: t = "expo-auth-session"
@bs.send external _makeRedirectUri: (t, useProxy)=>unit => string = "makeRedirectUri"

let authSession = authSession
let makeRedirectUri = useProxy => _makeRedirectUri(authSession, useProxy)
let getRedirectUri =%raw(`getRedirectUrl()`)

// @bs.module("expo-auth-session")
// external makeRedirectUri: useProxy => string = "makeRedirectUri"
@bs.module("expo-auth-session")
external useAuthRequest: authRequest => authRequestResult = "useAuthRequest"

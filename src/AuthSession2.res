// // /**
// //  * For requesting an authorization code as described by [Section 4.1.1](https://tools.ietf.org/html/rfc6749#section-4.1.1).
// //  */
// // Code = "code",
// // /**
// //  * For requesting an access token (implicit grant) as described by [Section 4.2.1](https://tools.ietf.org/html/rfc6749#section-4.2.1).
// //  */
// // Token = "token",
// // /**
// //  * A custom registered type for getting an `id_token` from Google OAuth.
// //  */
// // IdToken = "id_token"
// %%raw(`import { getRedirectUrl } from 'expo-auth-session';`)

// module ResponseType = {
//   type t = string
//   @bs.inline
//   let code = "code"
//   @bs.inline
//   let token = "token"
//   @bs.inline
//   let idToken = "id_token"
// }
type responseType = string
module ResponseType = {
  @bs.module("expo-auth-session") @bs.scope("ResponseType")
  external code: responseType = "code"

  @bs.module("expo-auth-session") @bs.scope("ResponseType")
  external token: responseType = "token"

  @bs.module("expo-auth-session") @bs.scope("ResponseType")
  external idToken: responseType = "id_token"
}
// module Scopes = {
//   type t = string
//   @bs.inline
//   let openId = "openid"
//   @bs.inline
//   let profile = "profile"
// }
type scopes = string
module Scopes = {
  @bs.module("expo-auth-session") @bs.scope("Scopes")
  external openId: responseType = "openid"

  @bs.module("expo-auth-session") @bs.scope("Scopes")
  external profile: responseType = "profile"
}
type responseTypeVariant =
  | Code
  | Token
  | IdToken
  | Unknown
  | Invalid

type error = {code: option<responseType>}
external castError: Js.Promise.error => error = "%identity"

let convertError = x =>
  switch x {
  | {code: Some(code)} when code == ResponseType.code => Code
  | {code: Some(code)} when code == ResponseType.token => Token
  | {code: Some(code)} when code == ResponseType.idToken => IdToken
  | {code: Some(_)} => Unknown
  | _e => Invalid
  }

let convertError = (error: Js.Promise.error) => error |> castError |> convertError
type extraParams = {
  // ideally, this will be a random value
  nonce: string,
}

// type authorizationEndpoint = string
// type scopes = [#openid | #profile]
type authRequestConfig = {
  responseType: option<string>,
  clientId: string,
  redirectUri: string,
  scopes: option<array<string>>,
  //   clientSecret: option<string>,
  //   codeChallengeMethod: option<CodeChallengeMethod.t>,
  //   codeChallenge: Js.Nullable.t<string>,
  //   prompt: option<Prompt.t>,
  //   state: option<string>,
  extraParams: option<extraParams>,
  //   usePKCE: option<bool>,
}
// // type authSessionResult_1_errorCode = Js.Nullable.t<string>
// // type authSessionResult_1_authentication = Js.Nullable.t<Js.Json.t>;
// module AuthSessionResultError = {
//   type rec t = {
//     @bs.as("type")
//     type_: [#error | #success],
//     errorCode: Js.Nullable.t<string>,
//     error: Js.Nullable.t<Js.Json.t>,
//   }
//   //   let notification = n => (string_of_int(n), "")
//   let errorResult = n => n
// }
// // export declare type AuthSessionResult = {
// //     type: 'cancel' | 'dismiss' | 'locked';
// // } | {
// //     type: 'error' | 'success';
// //     errorCode: string | null;
// //     error?: AuthError | null;
// //     params: {
// //         [key: string]: string;
// //     };
// //     authentication: TokenResponse | null;
// //     url: string;
// // };
// type authSessionRedirectUriOptions = {
//   native: Js.Nullable.t<string>,
//   path: Js.Nullable.t<string>,
//   useProxy: Js.Nullable.t<bool>,
//   preferLocalhost: Js.Nullable.t<bool>,
// }
// module AuthSessionResult = {
//   type t = {
//     @bs.as("type")
//     type_: [#cancel | #dismissed | #locked | #error | #success],
//     errorCode: Js.Nullable.t<string>,
//     authentication: Js.Nullable.t<Js.Json.t>,
//     url: string,
//   }
//   //   let authSessionResult = (v: t) => t
// }
// type authSessionResult = AuthSessionResult.t
// // type authRequestPromptOptions = {
// //   url: option<string>,
// //   useProxy: option<bool>,
// // }
// type useProxy = {"useProxy": bool}
// // type promptAsync = (useProxy)=> Js.Promise.t<AuthSessionResult.t>
// type authRequest = {
//   request: authRequestConfig,
//   authorizationEndpoint: authorizationEndpoint,
// }
// @bs.obj
// external authRequestConfig: (
//   ~clientId: string=?,
//   ~redirectUri: string=?,
//   ~scopes: array<string>=?,
//   ~clientSecret: string=?,
//   ~codeChallengeMethod: CodeChallengeMethod.t=?,
//   ~codeChallenge: string=?,
//   ~prompt: Prompt.t=?,
//   ~state: string=?,
//   ~extraParams: ExtraParams.t=?,
//   ~usePKCE: bool=?,
//   unit,
// ) => AuthRequestConfig.t = ""
// type promptAsyncT = (. ~request: option<authRequestConfig>=?) => Js.Promise.t<AuthSessionResult.t>
// @bs.obj
// external promptAsync: (~authRequestConfig: authRequestConfig=?, unit) => promptAsyncT = ""
type promptOptions
@bs.obj
external promptOptions: (~url: string=?, ~useProxy: bool=?, unit) => promptOptions = ""

@bs.deriving(abstract)
type options = {
  authUrl: string,
  @bs.optional
  returnUrl: string,
}

@bs.deriving(abstract)
type result<'paramType, 'eventType> = {
  @bs.as("type")
  _type: [#error | #success | #cancel | #dismiss | #locked],
  @bs.optional
  params: 'paramType,
  @bs.optional
  event: 'eventType,
  @bs.optional
  errorCode: string,
}


@bs.module("expo-auth-session")
external startAsync: options => Js.Promise.t<result<'paramType, 'eventType>> = "startAsync"
@bs.module("expo-auth-session")
external useAuthRequest: options => Js.Promise.t<result<'paramType, 'eventType>> = "useAuthRequest"

@bs.module("expo-auth-session")
external 
dismiss: unit => unit = "dismiss"

@bs.module("expo-auth-session")
external 
getRedirectUrl: unit => string = "getRedirectUrl"

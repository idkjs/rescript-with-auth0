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
@genType.import("./PromptAsync")
external promptAsync: (
  ~options: AuthRequestPromptOptions.t=?,
  unit
) =>  Js.Promise.t<AuthSessionResult.t> =""

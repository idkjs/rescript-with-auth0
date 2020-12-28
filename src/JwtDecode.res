@bs.module external decode: string => Js.Json.t = "jwt-decode"

export jwtDecode = (token: string): Js.Promise.t<Js.Json.t> =>
  Js.Promise.make((~resolve, ~reject) =>
    switch token->decode {
    | json => resolve(. json)
    | exception e => reject(. e)
    }
  )

open ReactNative
module ImageBackgroundFromUri = {
  @react.component
  let make = (~uri, ~resizeMode=?, ~style=?, ~children, ()) => {
    // let uri = Image.uriSource(~uri)
    <ImageBackground
      ?resizeMode ?style source={Image.Source.fromUriSource(Image.uriSource(~uri, ()))}>
      children
    </ImageBackground>
  }
}
let styles = {
  open Style
  StyleSheet.create({
    "container": style(
      ~flex=1.,
      ~backgroundColor="#fff",
      ~alignItems=#center,
      ~justifyContent=#center,
      ~height=120.->dp,
      (),
    ),
    "title": style(~fontSize=20., ~textAlign=#center, ~marginTop=40.->dp, ()),
  })
}
let imageStyle = (i, dogs) => {
  open Style
  StyleSheet.create({
    "imageStyle": style(
      ~height=120.->dp,
      ~width=100.->pct,
      ~marginRight=i === Js.Array.length(dogs) - 1 ? 0.->dp : 8.->dp,
      ~borderRadius=8.,
      //   ~boxShadow="0px 4px 16px rgb(200, 200, 200)",
      //   ~resizeMode=#cover,
      // ~imageBackground=j`url($dog)`,
      // ~backgroundPosition=#center,
      (),
    ),
  })
}

type request
type response
@bs.new external makeXMLHttpRequest: unit => request = "XMLHttpRequest"
@bs.send
external addEventListener: (request, string, unit => unit) => unit = "addEventListener"
@bs.get external response: request => response = "response"
@bs.send external open_: (request, string, string) => unit = "open"
@bs.send external send: request => unit = "send"
@bs.send external abort: request => unit = "abort"

@bs.scope("JSON") @bs.val
external parseResponse: response => {"message": array<string>} = "parse"

type state =
  | LoadingDogs
  | ErrorFetchingDogs
  | LoadedDogs(array<string>)

@react.component
let make = () => {
  let (state, setState) = React.useState(() => LoadingDogs)

  // Notice that instead of `useEffect`, we have `useEffect0`. See
  // reasonml.github.io/reason-react/docs/en/components#hooks for more info
  React.useEffect0(() => {
    let request = makeXMLHttpRequest()
    // request->addEventListener("load", () =>
    //   setState(_previousState => LoadedDogs((request->response->parseResponse)["message"]))
    // )
    request->addEventListener("load", () => {
      Js.log2("(request->response->parseResponse))", (request->response->parseResponse)["message"])
      setState(_previousState => LoadedDogs((request->response->parseResponse)["message"]))
    })
    request->addEventListener("error", () => setState(_previousState => ErrorFetchingDogs))
    request->open_("GET", "https://dog.ceo/api/breeds/image/random/3")
    request->send

    // the return value is called by React's useEffect when the component unmounts
    Some(() => request->abort)
  })

  <View style={styles["container"]}>
    {switch state {
    | ErrorFetchingDogs =>
      <Text style={styles["title"]}> {"An error occurred!"->React.string} </Text>
    | LoadingDogs => <Text style={styles["title"]}> {"Loading..."->React.string} </Text>
    | LoadedDogs(dogs) =>
      dogs
      ->Belt.Array.mapWithIndex((i, dog) => {

        <ImageBackgroundFromUri
          uri=j`url($dog)`
          resizeMode=#cover
          style={imageStyle(i, dogs)["imageStyle"]}>
          <Text style={styles["title"]}> {"Inside"->React.string} </Text>
        </ImageBackgroundFromUri>
      })
      ->React.array
    }}
  </View>
}

let default = make


import App from './src/App.bs'
export default App
// import * as AuthSession from 'expo-auth-session';
// import jwtDecode from 'jwt-decode';
// import {jwtDecode as jwtDecode2} from './src/JwtDecode.bs';
// import * as React from 'react';

// import { Alert, Button, Platform, StyleSheet, Text, View } from 'react-native';
// import { redirectUri, responseType, scopes, authorizationEndpoint, auth0ClientId, extraParams, useProxy} from './src/AuthConfig.bs';
// import {authRequestConfig} from './src/AuthConfig.bs';

// export default function App() {
//   const [name, setName] = React.useState(null);

//   const [request, result, promptAsync] = AuthSession.useAuthRequest(
//     //   {authRequestConfig},
//     {
//       redirectUri,
//       clientId: auth0ClientId,
//       // id_token will return a JWT token
//       responseType,
//       // retrieve the user's profile
//       scopes,
//       extraParams,
//     //   extraParams: {
//     //     // ideally, this will be a random value
//     //     nonce: 'nonce',
//     //   },
//     },
//     { authorizationEndpoint }
//   );

//   // Retrieve the redirect URL, add this to the callback URL list
//   // of your Auth0 application.
//   console.log(`authRequestConfig: ${JSON.stringify(authRequestConfig)}`);

//   React.useEffect(() => {
//       console.log("state_name: " + name)
//       console.log("result: ", JSON.stringify(result))
//     if (result) {
//       if (result.error) {
//         Alert.alert(
//           'Authentication error',
//           result.params.error_description || 'something went wrong'
//         );
//         return;
//       }
//       if (result.type === 'success') {
//         // Retrieve the JWT token and decode it
//         const jwtToken = result.params.id_token;
//         console.log("jwtToken: " + jwtToken)
//         const decoded = jwtDecode(jwtToken)
//         console.log("jwtToken_decoded: " + JSON.stringify(decoded))
//         const { name } = decoded;
//         console.log("name_decoded: " + name)
//         setName(name);
//       }
//     }
//   }, [result]);

//   return (
//     <View style={styles.container}>
//       {name ? (
//         <>
//           <Text style={styles.title}>You are logged in, {name}!</Text>
//           <Button title="Log out" onPress={() => setName(null)} />
//         </>
//       ) : (
//         <Button
//           disabled={!request}
//           title="Log in with Auth0"
//           onPress={() => promptAsync({ useProxy })}
//         />
//       )}
//     </View>
//   );
// }

// const styles = StyleSheet.create({
//   container: {
//     flex: 1,
//     backgroundColor: '#fff',
//     alignItems: 'center',
//     justifyContent: 'center',
//   },
//   title: {
//     fontSize: 20,
//     textAlign: 'center',
//     marginTop: 40,
//   },
// });

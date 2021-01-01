/* TypeScript file generated from PromptAsync.res by genType. */
/* eslint-disable import/first */


import {promptAsync as promptAsyncNotChecked} from './PromptAsync';

// In case of type error, check the type of 'promptAsync' in 'PromptAsync.re' and './PromptAsync'.
export const promptAsyncTypeChecked: (_1:{ readonly options: AuthRequestPromptOptions_t }, _2:void) => Promise<IAuthSessionResult_t> = promptAsyncNotChecked;

// Export 'promptAsync' early to allow circular import from the '.bs.js' file.
export const promptAsync: unknown = function (Argoptions: any, Arg2: any) {
  const result = promptAsyncTypeChecked({options:Argoptions}, Arg2);
  return result
} as (_1:{ readonly options: AuthRequestPromptOptions_t }, _2:void) => Promise<IAuthSessionResult_t>;

import {Json_t as Js_Json_t} from '../src/shims/Js.shim';

import {It as IAuthRequestPromptOptions_t} from '../src/bindings/expo-auth-session/AuthRequestPromptOptions.gen';

export interface IAuthSessionResult_t {
  readonly type: 
    "error"
  | "locked"
  | "cancel"
  | "dismissed"
  | "success"; 
  readonly errorCode: (null | undefined | string); 
  readonly authentication: (null | undefined | Js_Json_t); 
  readonly url: string
};

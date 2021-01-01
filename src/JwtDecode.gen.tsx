/* TypeScript file generated from JwtDecode.res by genType. */
/* eslint-disable import/first */


// tslint:disable-next-line:no-var-requires
const JwtDecodeBS = require('./JwtDecode.bs');

import {Json_t as Js_Json_t} from '../src/shims/Js.shim';

export const jwtDecode: (token:string) => Promise<Js_Json_t> = JwtDecodeBS.jwtDecode;

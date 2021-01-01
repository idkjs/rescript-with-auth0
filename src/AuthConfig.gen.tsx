/* TypeScript file generated from AuthConfig.res by genType. */
/* eslint-disable import/first */


// tslint:disable-next-line:no-var-requires
const AuthConfigBS = require('./AuthConfig.bs');

import {IauthRequestConfig as IAuthSession_authRequestConfig} from './AuthSession.gen';

import {IextraParams as IAuthSession_extraParams} from './AuthSession.gen';

export const scopes: (null | undefined | string[]) = AuthConfigBS.scopes;

export const responseType: (null | undefined | string) = AuthConfigBS.responseType;

export const extraParams: (null | undefined | IAuthSession_extraParams) = AuthConfigBS.extraParams;

export const authRequestConfig: IAuthSession_authRequestConfig = AuthConfigBS.authRequestConfig;

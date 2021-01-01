import { AuthSessionResult, AuthRequestPromptOptions } from 'expo-auth-session';

type PromptAsync = (
  options?: AuthRequestPromptOptions
) => Promise<AuthSessionResult>;

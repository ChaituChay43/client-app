# Amplify Client Portal

## Layout
Obviously most of this is just boilerplate. 
I am laying out the important files to look at.
Please read the subsection for each :smile:

```
.
├── lib
│   ├── auth.dart 
│   ├── globals.dart
│   └── main.dart
└── web
    └── auth.html
```

## auth.dart

<strong>⚠️ Warning:</strong> Do not commit any changes to this file without first consulting Spencer Faith (sfaith@amppf.com) or David Hatfield (dhatfield@amppf.com). This is the most security critical code in the app.

Please treat this file as you would any other library.
As a tool to be used not necessarily to be tweaked.
Of course, this is still a very new thing, changes will have to be made that is expected!

### Persistent Values

All values that need to be accessed outside of this file assume access to the `globals.dart` file. 
I am currently using this as a central store.
We can easily change this around please just let me know what you guys would like.

### Useful functions

- authWrapper()
    - This function is the basic wrapper used for original authentication
    - Will set the:
        - `access_token`
        - `refresh_token`
        - `expires_in` (please note: this is a DateTime object of when the `access_token` expires)
    - Returns `true` on successful login and `false` in any other case

- handleRefresh()
    - Call this function in order to refresh the access token
    - It will refresh all of the same values as in `authWrapper()`

- isTokenExpired()
    - Returns `true` iff the current access token is expired

The rest of the functions are internal functions, you shouldn't have to worry about them.
If you believe a function should be made public, please let me know.


## globals.dart

As mentioned in `auth.dart` this file is just a store for variables to be shared across files.
I am open to moving it elsewhere, just let me know.

All variables are explained in the file!


## main.dart

This is just an example client app.
It is extremely barebones and I am expecting you to tear it out and place in your current work prototype.


### Important Functions

Please see:

- _launchURL
    - A very basic example of using the Auth library to login
- _exampleApiCall
    - An example of making an API call with the token given to us by Auth


## auth.html 

This file doesn't need to be modified much its what `flutter_web_auth_2` requires for handling redirection on web.
It allows the client to return back to the original state after signing in.

If you want to test on android or ios you will need to add extra helpers to make it work with `flutter_web_auth_2`.

Please see: https://pub.dev/packages/flutter_web_auth_2#setup for more information!

---

Finally if you have any questions do not hesitate to ask.

Happy hacking :beers:
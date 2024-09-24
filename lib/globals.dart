
String accessToken = ''; // handle API requests
String refreshToken = ''; // gain new access token after expiration
DateTime expirationTime = DateTime(0); // determine if access token is still good 
bool isAuthorized = false; // little helper bool to see if any accessToken has ever been written
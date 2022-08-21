const SERVER_API_URL = "192.168.31.244:8574/api/v1";
const SERVER_API_URL2 = "192.168.31.244:8574";
const JWTHeader = "Authorization";
var userHttps = false;

String authority() {
  if (userHttps) {
    return "https://$SERVER_API_URL";
  }

  return "http://$SERVER_API_URL";
}
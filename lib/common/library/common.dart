const SERVER_API_URL = "2password.worldlink.net.cn/api/v1";
const SERVER_API_URL2 = "2password.worldlink.net.cn";
const JWTHeader = "Authorization";
var userHttps = true;

String authority() {
  if (userHttps) {
    return "https://$SERVER_API_URL";
  }

  return "http://$SERVER_API_URL";
}
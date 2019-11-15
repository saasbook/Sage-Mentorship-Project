Geocoder.configure(
  # Geocoding options
  # timeout: 3,                 # geocoding service timeout (secs)
   lookup: :google,         # name of geocoding service (symbol)
   ip_lookup: :freegeoip,      # name of IP address geocoding service (symbol)
  # language: :en,              # ISO-639 language code
   use_https: true,           # use HTTPS for lookup requests? (if supported)
  # http_proxy: nil,            # HTTP proxy server (user:pass@host:port)
  # https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)

  api_key: 'AIzaSyBdNZOkgvGjSPl0F5gibQe56EF2Qs2KiL0'               # API key for geocoding serviceda60867b12b74818d1df0abdfa1c44dd115e4d71
  # cache: nil,                 # cache object (must respond to #[], #[]=, and #del)
   #cache_prefix:  # prefix (string) to use for all cache keys

  # Exceptions that should not be rescued by default
  # (if you want to implement custom error handling);
  # supports SocketError and Timeout::Error
  # always_raise: [],

  # Calculation options
  # units: :mi,                 # :km for kilometers or :mi for miles
  # distances: :linear          # :spherical or :linear
)

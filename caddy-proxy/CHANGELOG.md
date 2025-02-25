# Changelog

## 1.0.1

### Changed
- Remove print of Caddyfile in startup script
- Remove gzip encoding from Caddyfile configuration for Home Assistant reverse proxy

## 1.0.0

### Added
- Initial release of the Caddy Home Assistant SSL proxy add-on
- Support for SSL/TLS termination using custom certificates
- Support for multiple architectures (aarch64, amd64, armhf, armv7, i386)
- Configuration options for domain, certificate, and key files
- Support for trusted proxies configuration
- Integration with Home Assistant API
- SSL certificate mapping
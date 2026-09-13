import Foundation

/// Fill these in with your own credentials from the official developer
/// dashboards. Never commit real secrets to source control in a real project
/// — for production, load them from a secure config / keychain instead.
enum APIConfig {
    // https://developer.spotify.com/dashboard
    static let spotifyClientID = "YOUR_SPOTIFY_CLIENT_ID"
    static let spotifyClientSecret = "YOUR_SPOTIFY_CLIENT_SECRET"

    // https://developers.soundcloud.com/
    static let soundCloudClientID = "YOUR_SOUNDCLOUD_CLIENT_ID"
}

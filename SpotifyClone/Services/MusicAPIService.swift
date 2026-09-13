import Foundation

/// Combines both backends behind one simple interface for the ViewModels,
/// and also supplies the small set of demo tracks used to populate Home
/// before the user has searched for anything (with royalty-free/local demo
/// audio, not copied content).
final class MusicAPIService {
    static let shared = MusicAPIService()

    func search(query: String) async -> SearchResults {
        async let spotifyResults: SearchResults = (try? SpotifyAPIClient.shared.search(query: query)) ?? SearchResults()
        async let soundcloudTracks: [Track] = (try? SoundCloudAPIClient.shared.search(query: query)) ?? []

        var combined = await spotifyResults
        combined.tracks.append(contentsOf: await soundcloudTracks)
        return combined
    }

    /// Demo/sample content for the Home screen's "starter" sections, using
    /// Apple's freely licensed sample audio so the app is playable out of the
    /// box before any API keys are configured. Swap for real API results once
    /// keys are set (see `HomeViewModel`).
    func sampleHomeTracks() -> [Track] {
        [
            Track(id: "demo-1", title: "Morning Drive", artistName: "Ambient Collective", albumName: "Sunrise Sessions",
                  artworkURL: URL(string: "https://picsum.photos/seed/morning/400"),
                  streamURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
                  duration: 320, source: .local),
            Track(id: "demo-2", title: "Night Pulse", artistName: "Neon Skyline", albumName: "City Lights",
                  artworkURL: URL(string: "https://picsum.photos/seed/night/400"),
                  streamURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3"),
                  duration: 245, source: .local),
            Track(id: "demo-3", title: "Analog Waves", artistName: "Retro Circuit", albumName: "Waveforms",
                  artworkURL: URL(string: "https://picsum.photos/seed/waves/400"),
                  streamURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3"),
                  duration: 290, source: .local),
            Track(id: "demo-4", title: "Golden Hour", artistName: "Ambient Collective", albumName: "Sunrise Sessions",
                  artworkURL: URL(string: "https://picsum.photos/seed/golden/400"),
                  streamURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3"),
                  duration: 210, source: .local)
        ]
    }
}

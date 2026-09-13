import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var recentlyPlayed: [Track] = []
    @Published var madeForYou: [Track] = []
    @Published var newReleases: [Album] = []
    @Published var isLoading = false

    private let api = MusicAPIService.shared

    func load() async {
        isLoading = true
        defer { isLoading = false }

        let demo = api.sampleHomeTracks()
        recentlyPlayed = demo.shuffled()
        madeForYou = demo.reversed()

        // If real Spotify credentials are configured, layer in live "new
        // releases" style content via search as a simple stand-in (the
        // dedicated /browse/new-releases endpoint works the same way).
        if APIConfig.spotifyClientID != "YOUR_SPOTIFY_CLIENT_ID" {
            let results = await api.search(query: "top hits 2026")
            newReleases = results.albums
        }
    }
}

//
//  BrowserViewModel.swift
//  New Apps Test
//
//  Created by The Sebag Company on 13/04/2024.
//

import CoreLocation
import Foundation

class BrowserViewModel: ObservableObject {
    let currentUser: User
    
    @Published
    private(set) var friends: [User] = []
    @Published
    private(set) var albums: [Album] = []
    
    
    @Published
    var focusedPhoto: PhotoItem?
    @Published
    var selectedAlbumId: Int?
    @Published
    var selectedImageId: Int?
    @Published
    var selectedFriendId: Int?

    init() {
        self.currentUser = User(
            id: 0,
            username: "billyTheKid",
            profilePic: URL(string: "https://media.paperblog.fr/i/994/9942322/billy-joel-L-TkDHNB.jpeg"),
            albums: []
        )
        self.friends = makeFriends()
        self.albums = makeAlbums()
    }
}

// MARK: - Actions
extension BrowserViewModel {
    func selectAlbum(from photo: PhotoItem) {
        guard
            let album = albums.first(where: { $0.photos.contains(photo) })
        else {
            return
        }
        
        self.selectedAlbumId = album.id
    }
    
    func selectAlbum(from id: Int?) {
        guard
            id != nil,
            let selectedAlbum = albums.first(where: { $0.id == id })
        else {
            selectedImageId = 0
            selectedAlbumId = nil
            selectedFriendId = nil
            friends = makeFriends()
            albums = makeAlbums()
            return
        }
        
        selectedAlbumId = id
        friends = selectedAlbum.users
    }
    
    func getAlbumsForSelectedUser() -> [Album] {
        guard
            selectedFriendId != nil
        else {
            return makeAlbums()
        }
        
        return albums.filter { album in
            album.users.contains(where: { $0.id == selectedFriendId })
        }
    }
    
    func selectFriend(from id: Int?) {
        guard selectedAlbumId == nil else { return }
        guard
            id != nil,
            let selectedFriend = friends.first(where: { $0.id == id })
        else {
            friends = makeFriends()
            albums = makeAlbums()
            selectedFriendId = nil
            return
        }
        
        self.selectedFriendId = id
        albums = albums.filter { $0.users.contains(selectedFriend) }
        friends = [selectedFriend]
    }
    
    func sendMessage(_ body: String) {
        guard
            !body.isEmpty,
            let selectedAlbumIdx = albums.firstIndex(where: { $0.id == selectedAlbumId })
        else { return }
        
        albums[selectedAlbumIdx].messages.append(
            Message(
                id: (albums[selectedAlbumIdx].messages.last?.id ?? -1) + 1,
                body: body,
                sender: currentUser
            )
        )
    }
}

// MARK: - Dummy Data setup
private extension BrowserViewModel {
    func makeFriends() -> [User] {
        [
            janeFonda(),
            cindyLauper(),
            whitneyHouston(),
            neilDiamond(),
            stevieWonder(),
            kennyRogers(),
            phillCollins(),
            dollyParton()
        ]
    }
    
    func makeAlbums() -> [Album] {
        [
            Album(
                id: 0,
                name: "Road trip in Japan",
                photos: [
                    PhotoItem(
                        id: 0,
                        title: "Shibuya",
                        image: URL(string: "https://images.unsplash.com/photo-1542051841857-5f90071e7989?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location: CLLocation(latitude: 35.658514, longitude: 139.70133)
                    ),
                    PhotoItem(
                        id: 1,
                        title: "Kyoto's Street",
                        image: URL(string: "https://images.unsplash.com/photo-1528360983277-13d401cdc186?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location: CLLocation(latitude: 35.011665, longitude: 135.768326)
                    ),
                    PhotoItem(
                        id: 2,
                        title: "Akihabara",
                        image: URL(string: "https://images.unsplash.com/photo-1519057016395-76b7690327e0?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location: CLLocation(latitude: 35.6916972332, longitude: 139.769746921)
                    ),
                    PhotoItem(
                        id: 3,
                        title: "Tokyo Tower",
                        image: URL(string: "https://images.unsplash.com/photo-1536098561742-ca998e48cbcc?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location: CLLocation(latitude: 35.658581, longitude: 139.745438)
                    ),
                    PhotoItem(
                        id: 4,
                        title: "Fujiyoshida",
                        image: URL(string: "https://images.unsplash.com/photo-1526481280693-3bfa7568e0f3?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location: CLLocation(latitude: 35.487528, longitude: 138.807750)
                    ),
                    PhotoItem(
                        id: 5,
                        title: "Tori in the forest",
                        image: URL(string: "https://images.unsplash.com/photo-1601823984263-b87b59798b70?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location: CLLocation(latitude: 35.18945, longitude: 139.02649)
                    ),
                    PhotoItem(
                        id: 6,
                        title: "Tori in the Sea",
                        image: URL(string: "https://images.unsplash.com/photo-1504109586057-7a2ae83d1338?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location: CLLocation(latitude: 34.29083217, longitude: 132.318498726)
                    ),
                    PhotoItem(
                        id: 7,
                        title: "Just a picture",
                        image: URL(string: "https://images.unsplash.com/photo-1505069446780-4ef442b5207f?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location: CLLocation(latitude: 34.966996132, longitude: 135.770330252)
                    ),
                    PhotoItem(
                        id: 8,
                        title: "What's left.",
                        image: URL(string: "https://images.unsplash.com/photo-1574773774523-c8007253ef49?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location: CLLocation(latitude: 34.394593542, longitude: 132.454797056)
                    ),
                    PhotoItem(
                        id: 9,
                        title: "",
                        image: URL(string: "https://images.unsplash.com/photo-1617526762079-76fd969fe004?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location: CLLocation(latitude: 34.4027264, longitude: 132.4590474)
                    )

                ],
                users: [ neilDiamond(), phillCollins(), dollyParton(), cindyLauper() ],
                messages: [
                    Message(
                        id: 0,
                        body: "I can still feel it, coming in the air.",
                        sender: phillCollins()
                    ),
                    Message(
                        id: 1,
                        body: "HOLD ON",
                        sender: cindyLauper()
                    ),
                    Message(
                        id: 2,
                        body: "Japan was mesmerizing",
                        sender: dollyParton()
                    ),
                    Message(
                        id: 3,
                        body: "Far! We've been travelling far!",
                        sender: neilDiamond()
                    )
                ]
            ),
            Album(
                id: 1,
                name: "City of Love",
                photos: [
                    PhotoItem(
                        id: 10,
                        title: "Eiffel Tower",
                        image: URL(string: "https://images.unsplash.com/photo-1502602898657-3e91760cbb34?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location:
                            CLLocation(
                            latitude: 48.8584,
                            longitude: 2.2945
                        )
                    ),
                    PhotoItem(
                        id: 11,
                        title: "Wow",
                        image: URL(string: "https://plus.unsplash.com/premium_photo-1689523819186-cfe67633ad49?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location: CLLocation(
                            latitude: 48.8738,
                            longitude: 2.2950
                        )
                    ),
                    PhotoItem(
                        id: 12,
                        title: "Should we buy it?",
                        image: URL(string: "https://images.unsplash.com/photo-1551634979-2b11f8c946fe?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location: CLLocation(
                            latitude: 48.8606,
                            longitude: 2.3376
                        )
                    )
                ],
                users: [ kennyRogers(), dollyParton() ],
                messages: [
                    Message(
                        id: 0,
                        body: "I can still feel it, coming in the air.",
                        sender: phillCollins()
                    ),
                    Message(
                        id: 1,
                        body: "HOLD ON",
                        sender: cindyLauper()
                    ),
                    Message(
                        id: 2,
                        body: "Japan was mesmerizing",
                        sender: dollyParton()
                    ),
                    Message(
                        id: 3,
                        body: "Far! We've been travelling far!",
                        sender: neilDiamond()
                    )
                ]
            ),
            Album(
                id: 2,
                name: "West Coast",
                photos: [
                    PhotoItem(
                        id: 13,
                        title: "Pinky hour",
                        image: URL(string: "https://images.unsplash.com/photo-1580655653885-65763b2597d0?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location: CLLocation(
                            latitude: 34.098907,
                            longitude: -118.327759
                        )
                    ),
                    PhotoItem(
                        id: 14,
                        title: "GTA V",
                        image: URL(string: "https://images.unsplash.com/photo-1547516358-e98f85a80f20?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location: CLLocation(
                            latitude: 34.005166646,
                            longitude: -118.49249803
                        )
                    ),
                    PhotoItem(
                        id: 15,
                        title: "Venice",
                        image: URL(string: "https://images.unsplash.com/photo-1504731231146-c0f65dc6a950?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location: CLLocation(
                            latitude: 33.988270,
                            longitude: -118.472023
                        )
                    ),
                    PhotoItem(
                        id: 16,
                        title: "Hidden gem",
                        image: URL(string: "https://images.unsplash.com/photo-1606330978040-5e0ea51a6118?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location: CLLocation(
                            latitude: 34.0919452,
                            longitude: -118.6021321
                        )
                    ),
                    PhotoItem(
                        id: 17,
                        title: "Santa Paradise",
                        image: URL(string: "https://images.unsplash.com/photo-1562749536-5642fe7bb115?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location: CLLocation(
                            latitude: 34.420830,
                            longitude: -119.698189
                        )
                    ),
                    PhotoItem(
                        id: 18,
                        title: "Ocean view",
                        image: URL(string: "https://images.unsplash.com/photo-1598112662885-56d5dcbaca60?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location: CLLocation(
                            latitude: 36.55524,
                            longitude: -121.92329
                        )
                    ),
                    PhotoItem(
                        id: 19,
                        title: "Bumpin'",
                        image: URL(string: "https://images.unsplash.com/photo-1636086170815-0e5503c38a60?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        location: CLLocation(
                            latitude: 34.010124,
                            longitude: -118.415016
                        )
                    )
                ],
                users: [
                    janeFonda(),
                    phillCollins(),
                    cindyLauper(),
                    whitneyHouston(),
                    stevieWonder()
                ],
                messages: [
                    Message(
                        id: 0,
                        body: "I can still feel it, coming in the air.",
                        sender: phillCollins()
                    ),
                    Message(
                        id: 1,
                        body: "HOLD ON",
                        sender: cindyLauper()
                    ),
                    Message(
                        id: 2,
                        body: "Japan was mesmerizing",
                        sender: dollyParton()
                    ),
                    Message(
                        id: 3,
                        body: "Far! We've been travelling far!",
                        sender: neilDiamond()
                    )
                ]
            )
        ]
    }
    
    func billyJoel() -> User {
        User(
            id: 0,
            username: "billyTheKid",
            profilePic: URL(string: "https://media.paperblog.fr/i/994/9942322/billy-joel-L-TkDHNB.jpeg"),
            albums: []
        )
    }
    
    func janeFonda() -> User {
        User(
            id: 1,
            username: "janeFonda",
            profilePic: URL(string: "https://resize-elle.ladmedia.fr/rcrop/638,,forcex/img/var/plain_site/storage/images/loisirs/livres/dossiers/jane-fonda-une-vie-en-10-images-fortes/23703460-1-fre-FR/Jane-Fonda-une-vie-en-10-images-fortes.jpg"),
            albums: []
        )
    }
    
    func cindyLauper() -> User {
        User(
            id: 2,
            username: "cindy_lauper",
            profilePic: URL(string: "https://image.over-blog.com/L82JFbnIgkYIOtUUryuHXrj3wK4=/filters:no_upscale()/image%2F1038734%2F20231006%2Fob_c00ea6_cyndi-lauper-grande-2.jpg"),
            albums: []
        )
    }
    
    func whitneyHouston() -> User {
        User(
            id: 3,
            username: "witHouston",
            profilePic: URL(string: "https://media.nostalgie.fr/1900x1200/2017/06/whitney-houston_4657.jpg"),
            albums: []
        )
    }
    
    func neilDiamond() -> User {
        User(
            id: 4,
            username: "realDiamond",
            profilePic: URL(string: "https://www.liveabout.com/thmb/iHsqUQVVCQVzksj12vZ-z7iwOXo=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/neil-diamond-80s-5c5327804cedfd0001f91689.jpg"),
            albums: []
        )
    }
    
    func stevieWonder() -> User {
        User(
            id: 5,
            username: "wonderBro",
            profilePic: URL(string: "https://cdns-images.dzcdn.net/images/artist/b8138428e7b0ce78843106b4b83d4e77/264x264.jpg"),
            albums: []
        )
    }
    
    func kennyRogers() -> User {
        User(
            id: 6,
            username: "rogers78",
            profilePic: URL(string: "https://cdn.britannica.com/73/205073-050-4BEBDF80/Kenny-Rogers-1970.jpg"),
            albums: []
        )
    }
    
    func phillCollins() -> User {
        User(
            id: 7,
            username: "phill",
            profilePic: URL(string: "https://img.nrj.fr/OB_DNcruzqKvl-c3L5VVV4UHH98=/http%3A%2F%2Fmedia.cheriefm.fr%2F1900x1200%2F2017%2F07%2Fphil-collins_1366397.jpg"),
            albums: []
        )
    }
    
    func dollyParton() -> User {
        User(
            id: 8,
            username: "partonsDoll",
            profilePic: URL(string: "https://media.vogue.fr/photos/65579c3aefd07ba028561adf/2:3/w_2560%2Cc_limit/GettyImages-831441758.jpg"),
            albums: []
        )
    }
}

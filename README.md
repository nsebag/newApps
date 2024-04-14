Here we go again for another run at **Voodoo** product engineering test. The goal was set to create a new way to share photos between friends.

# Concept

When I think about memories and images with friends, there are usually two things coming to my mind, the place and eventually some song.
The idea I'm submitting today, is a social media were users create shared photo albums around a place, a trip etc.. But the place comes first. We all grew up meeting our friends in the same place almost every day. We all did the greatest trips of our lifes far from home, meeting strangers and building memories.

This app aims at marking this places with all our memories.

In many ways this idea is improvable and the UI/UX too. But I think this shows some other skills that I couldn't on the first time. It's something that I believe to be new, and to make sense.
***Hopefully next steps in the process will let me explain more***

# Vision

I see three main iterations on this app after this MVP vision:

 - Ability to discuss on an image separately than on an album
 - Implementing some way to link a music to an image and create a playlist out of an album. Memories come with music, at least to me.
 - Dig some way to create localised chat. For example, discussed with all of my friends that ever post in Paris, or in Tokyo. This could be an interesting way to create new interactions with people around me such as "Who's in town for a drink ? " or "Any tips for the best view on the city ?".

# Commits

- First commit made on Saturday it a first MVP, it represents around 7 hours of work. It doesn't contain the photo gallery nor some of the interactions. 
- A few improvements here on there on sunday morning. I'll end here, after 10 hours roughly. The code is getting a bit messy sorry for that, I tried to demonstrate my idea.

# Technicality

The app is built using full SwiftUI and will only support iOS 17 devices. 
For the map I had to build a "custom" clusterisation algorithm, please note that I used some tools such as a few medium posts and chatGPT to build a very thorough algorithm using the DBScan logic. The code is dirty, not optimised, and far from ideal I just needed that to implement my idea in full SwiftUI.

Compared to my first try at this test I would say that the code is "messier" in many ways its architecture could be improved. I believe that I already proved on that point, so I just focused on building my product.

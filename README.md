# iOS Founding Engineer Test

This small README to explain my basic thoughts doing this test.
## I sincerely hope I'll be able to move to the next steps in the process to have a more in-depth discussion about what I did.

## Removed precise instruction for Google Reference

The goal was to build a photo-centric social chat app.
There are two commits:
    - The one made at 4 hours of work, for you to see what I did in this time constraint
    - One more made after 1h30 more to improve a few things and add a chat-ui mock

There are a few notes in the codes explaining some decisions

## Concept

The app follows a very basic MVVM architecture. For the sake of speed, no real clean-architecture was implemented more than basic layer separation between views and data.

UX is TikTok inspired, it was the safest solution to build multiple screens in such a short time.
The idea, is that a user would scroll through random images from Unsplash, and if they want, send images to their friends in a conversation.

There are three screens in the app:
    - The fullscreen paged scrollview to go through each available image
    - The Album page that is basically the start point of messaging navigation. It's called Album in order to emphasize, the photo-centric experience
    - A very basic chat message (a mockup really) that aims at showing another way of implementing scroll based UIs in SwiftUI

Minimal component reusability was implemented, still for time save. In a real project, a ReusableComponents folder would have been created to avoid some code duplication

## What I Don't like

Screen data is not linked one another, I would have spent the extra hour but I'm already 1h30 hour ahead of schedule.
I would've loved working on a Custom Layout for images both for the Album view as well as for the ImageGallery View (that is not developed, but would be accessible from top-right button on chat view)
I think UX-wise I could've gone further. 

## What I like

I think I've been able to demonstrate a few things, such as List, Scrollviews, basic navigation, basic architecture, animations etc...
I think the result looks OK with the time constraint, even though HIGHLY improvable.


## Overall it was fun although a bit short in 4 hours.
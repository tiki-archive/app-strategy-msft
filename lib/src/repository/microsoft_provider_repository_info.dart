import 'package:microsoft_provider/src/model/info/microsoft_provider_info_model.dart';
import 'package:microsoft_provider/src/model/info/microsoft_provider_info_model_content.dart';
import 'package:microsoft_provider/src/model/info/microsoft_provider_info_model_content_body.dart';
import 'package:microsoft_provider/src/model/info/microsoft_provider_info_model_content_cta.dart';
import 'package:microsoft_provider/src/model/info/microsoft_provider_info_model_content_icon.dart';
import 'package:microsoft_provider/src/model/info/microsoft_provider_info_model_content_text.dart';
import 'package:microsoft_provider/src/model/info/microsoft_provider_info_model_cover.dart';
import 'package:microsoft_provider/src/model/info/microsoft_provider_info_model_cover_header.dart';
import 'package:microsoft_provider/src/model/info/microsoft_provider_info_model_cover_header_share.dart';

class MicrosoftProviderRepositoryInfo {
  static const List<MicrosoftProviderInfoModel> theyKnowInfo = [
    MicrosoftProviderInfoModel(
        cover: MicrosoftProviderInfoModelCover(
            header: MicrosoftProviderInfoModelCoverHeader(
                image: "google-round-logo",
                title: "Your Gmail account",
                share: MicrosoftProviderInfoModelCoverHeaderShare(
                    message:
                        "Gmail knows where you are when you read your emails. It's your data, start taking it back on https://www.mytiki.com",
                    image: "socialmedia1.png")),
            image: "where-you-are",
            subtitle: "Gmail knows...",
            bigTextLight: "Where you are ",
            bigTextDark: "when you read your emails.",
            text:
                "Your Gmail account tracks your location when you open your emails...\nEvery single time you do it."),
        content: MicrosoftProviderInfoModelContent(
            body: MicrosoftProviderInfoModelContentBody(
                explain: <MicrosoftProviderInfoModelContentText>[
                  MicrosoftProviderInfoModelContentText(
                      text: "Gmail records your ", url: null),
                  MicrosoftProviderInfoModelContentText(
                      text: "IP address",
                      url: "https://en.wikipedia.org/wiki/IP_address"),
                  MicrosoftProviderInfoModelContentText(
                      text:
                          " every time you open your inbox or send an email.\n\nMost Google products and almost all email services do this. Some, like Outlook, but NOT Gmail, will even send your IP address to the person receiving your email.\n\nThe most common use approximates your location, pinpointing you within 3-5 miles anywhere in the world. In extreme cases, like criminal investigations, your IP address can be tied to your exact device and location by working with an Internet Service Provider.",
                      url: null)
                ],
                theySay: <MicrosoftProviderInfoModelContentIcon>[
                  MicrosoftProviderInfoModelContentIcon(
                      image: "info-badge",
                      text: "Security monitoring to suspicious access"),
                  MicrosoftProviderInfoModelContentIcon(
                      image: "search-graph",
                      text:
                          "Analyzing patterns to develop new features and products")
                ],
                shouldKnow: [
                  MicrosoftProviderInfoModelContentIcon(
                      image: "np-tap",
                      text:
                          "Used advertisers for location-based targeting and surveillance"),
                  MicrosoftProviderInfoModelContentIcon(
                      image: "badge", text: "Used by law enforcement"),
                  MicrosoftProviderInfoModelContentIcon(
                      image: "worldwide",
                      text:
                          "Saved for 9 months, then obscured and kept permanently")
                ]),
            cta: MicrosoftProviderInfoModelContentCta(
                explain: <MicrosoftProviderInfoModelContentText>[
                  MicrosoftProviderInfoModelContentText(
                      text: "You can use a ", url: null),
                  MicrosoftProviderInfoModelContentText(
                      text: "VPN", url: "https://nordvpn.com"),
                  MicrosoftProviderInfoModelContentText(
                      text:
                          " to hide your IP address or, for true anonymity, switch to an ",
                      url: null),
                  MicrosoftProviderInfoModelContentText(
                      text: "encrypted email service",
                      url: "https://protonmail.com"),
                  MicrosoftProviderInfoModelContentText(
                      text:
                          ".\n\nGmail does not currently use additional location services.\n\nIf you just hate the ads, you can turn off ad personalization for your entire Google account. ",
                      url: null)
                ],
                buttonText: "AD PERSONALIZATION",
                buttonUrl: "https://adssettings.google.com"))),
    MicrosoftProviderInfoModel(
        cover: MicrosoftProviderInfoModelCover(
            header: MicrosoftProviderInfoModelCoverHeader(
                image: "google-round-logo",
                title: "Your Gmail account",
                share: MicrosoftProviderInfoModelCoverHeaderShare(
                    message:
                        "Gmail knows what you've written to your friends. Find out more on https://www.mytiki.com",
                    image: "socialmedia2.png")),
            image: "what-written",
            subtitle: "Gmail knows...",
            bigTextLight: "What you’ve written to ",
            bigTextDark: "your friends",
            text:
                "Gmail has all emails you’ve ever written to anyone. They look at the content in the emails, so they know you better."),
        content: MicrosoftProviderInfoModelContent(
            body: MicrosoftProviderInfoModelContentBody(explain: [
              MicrosoftProviderInfoModelContentText(
                  text:
                      "Gmail has access to your emails - it reads, stores and analyzes them.\n\nGoogle uses this information for targeted ads and what they call “smart features” like automatically adding your flight information to your calendar.\n\nIn their own words:\n\n\nCreepy.",
                  url: null)
            ], theySay: [
              MicrosoftProviderInfoModelContentIcon(
                  image: "airplane",
                  text:
                      "Travel assistance like itineraries, updates, and maps."),
              MicrosoftProviderInfoModelContentIcon(
                  image: "email",
                  text:
                      "Smart email with suggestions, nudges, prioritization, and filtering"),
              MicrosoftProviderInfoModelContentIcon(
                  image: "package",
                  text:
                      "Track packages, reservations, loyalty cards, and bills")
            ], shouldKnow: [
              MicrosoftProviderInfoModelContentIcon(
                  image: "np-tap",
                  text: "Used by advertisers for key word targetting"),
              MicrosoftProviderInfoModelContentIcon(
                  image: "hammer", text: "Used by law enforcement"),
              MicrosoftProviderInfoModelContentIcon(
                  image: "worldwide", text: "Disabled by default in Europe")
            ]),
            cta: MicrosoftProviderInfoModelContentCta(
                explain: [
                  MicrosoftProviderInfoModelContentText(
                      text: "You can turn off both,", url: null),
                  MicrosoftProviderInfoModelContentText(
                      url: "https://support.google.com/mail/answer/10079371",
                      text: " ad personalization "),
                  MicrosoftProviderInfoModelContentText(
                      text:
                          "and “smart features” to stop Google from scanning your emails.",
                      url: null)
                ],
                buttonText: "STOP READING MY EMAILS",
                buttonUrl: "https://support.google.com/mail/answer/10079371"))),
    MicrosoftProviderInfoModel(
        cover: MicrosoftProviderInfoModelCover(
            header: MicrosoftProviderInfoModelCoverHeader(
                image: "google-round-logo",
                title: "Your Gmail account",
                share: MicrosoftProviderInfoModelCoverHeaderShare(
                    message:
                        "Gmail knows what you've written to your friends. Find out more on https://www.mytiki.com",
                    image: "socialmedia2.png")),
            image: "everything-you-do",
            subtitle: "Gmail knows...",
            bigTextLight: "Everything\n",
            bigTextDark: "you do in your Gmail app",
            text:
                "Your Gmail app has quite a lot of analytics packed in and knows quite a few things...."),
        content: MicrosoftProviderInfoModelContent(
            body: MicrosoftProviderInfoModelContentBody(explain: [
              MicrosoftProviderInfoModelContentText(
                  url: null,
                  text:
                      "Gmail’s app is designed to track most of the things you do with it. It tracks each action you take, on which device, OS, and time of day.\n\nFor example, when you opened the app, what you searched for and if you saw an ad were all tracked.\n\nYour audio is recorded if you use voice search or assistant with Gmail.")
            ], theySay: [
              MicrosoftProviderInfoModelContentIcon(
                  image: "person-4", text: "Personalized experiences"),
              MicrosoftProviderInfoModelContentIcon(
                  image: "circle-badge",
                  text: "App and content recommendations"),
              MicrosoftProviderInfoModelContentIcon(
                  image: "search", text: "Faster Search")
            ], shouldKnow: [
              MicrosoftProviderInfoModelContentIcon(
                  image: "hat-n-glasses",
                  text: "Your activity is tracked even when logged out"),
              MicrosoftProviderInfoModelContentIcon(
                  image: "badge", text: "Used by law enforcement"),
              MicrosoftProviderInfoModelContentIcon(
                  image: "bomb",
                  text:
                      "You can set your history to auto delete after 3, 18, or 36 months")
            ]),
            cta: MicrosoftProviderInfoModelContentCta(
                explain: [
                  MicrosoftProviderInfoModelContentText(
                      text:
                          "You can delete all activities, individual activities, set it to auto-delete, or disable activity tracking entirely.",
                      url: null)
                ],
                buttonText: "MY ACTIVITY",
                buttonUrl: "https://myactivity.google.com")))
  ];
}

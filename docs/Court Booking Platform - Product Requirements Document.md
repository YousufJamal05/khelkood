

## Court Booking Platform - Product Requirements Document
## 1. Executive Summary
## Product Vision
A unified mobile app that modernizes indoor court bookings in Karachi by connecting court owners with
players, replacing inefficient WhatsApp-based booking systems with a streamlined digital solution.
## Problem Statement
Currently, booking indoor courts (cricket, futsal, padel) in Karachi is fragmented and inefficient. Users must
navigate multiple WhatsApp groups, wait for manual confirmations, and lack visibility into real-time
availability. Court owners struggle with double bookings, manual schedule management, and missed revenue
opportunities due to poor slot visibility.
## Target Market
Karachi has 50+ indoor cricket nets, 30+ futsal courts, and growing padel facilities. These sports are
experiencing rapid growth among the 18-35 age demographic, particularly in areas like DHA, Clifton, Gulshan,
and Bahria Town.
## Success Metrics
User Acquisition: 100 active users in first 2 months, 500+ in 6 months
Court Owner Onboarding: 5 courts in first month, 15+ courts within 6 months
Booking Volume: 50+ bookings per week by month 3
User Retention: 30%+ monthly active users returning
Booking Conversion: 50%+ of users who search complete a booking
Owner Satisfaction: 80%+ court owners rate platform as better than previous system
## Budget Constraint
Total development budget: PKR 15,000-20,000
This necessitates a lean, web-first MVP approach using low-cost/free tools and services.
## 2. Target Users
## Primary Users
- Players/Court Users

## Age: 18-35 (primary), 35-45 (secondary)
Play cricket, futsal, or padel recreationally
Located primarily in DHA, Clifton, Gulshan, Bahria Town, Malir Cantt
Tech-savvy, use smartphones regularly
Currently book through WhatsApp groups, Instagram DMs, or phone calls
Pain points: Waiting hours for responses, unclear availability, difficulty comparing prices across
venues
- Court Owners/Managers
Operate cricket nets (6-12 lanes), futsal courts (1-4 courts), or padel courts (2-6 courts)
Currently manage bookings manually via WhatsApp/calls/Instagram
Pain points: Double bookings, manual schedule tracking, payment collection delays, no analytics
Need: Better operational efficiency, reduced no-shows, faster payment collection
## Secondary Users
Tournament organizers needing bulk bookings
Corporate teams booking regular slots
Coaches seeking predictable court access
## 3. Product Requirements
3.1 User-Facing Features (MVP)
## Registration & Authentication
Sign up via phone number with OTP verification
Optional Google/Facebook social login
User profile creation (name, preferred sports, skill level)
Guest checkout option for first-time users
## Court Discovery & Search
Browse all available courts in Karachi
Filter by: sport type (cricket/futsal/padel), area (DHA, Clifton, Gulshan, etc.), price range, availability
View court details: photos, address, pricing per hour, available slots, basic amenities

Simple location display (address + embedded map)
Search by court name or area
## Booking Flow
Select date and view real-time slot availability
Choose time slot (typically 60-90 minute increments)
See transparent pricing with any additional fees
Add multiple slots in single transaction
Option to book recurring slots (e.g., every Tuesday 6-7 PM)
Booking confirmation with details sent via app notification and SMS
## Payment Integration
JazzCash/EasyPaisa mobile wallet integration (most used in Pakistan)
Bank transfer option with manual verification (for higher amounts)
Cash payment option (user pays at venue, owner confirms)
For MVP: Focus on cash payment + manual verification to avoid payment gateway complexity
Payment confirmation via screenshot upload (temporary solution)
Future: Automated JazzCash/EasyPaisa integration
## User Dashboard
View upcoming bookings
Access booking history
Cancel bookings (with cancellation policy display)
Rebook previous courts quickly
## Ratings & Reviews
Delayed to Phase 2 to simplify MVP
Initial version: Simple "verified booking" badge only

3.2 Court Owner Features (MVP)
## Owner Registration & Onboarding
Business registration with verification (name, address, documents)
Court setup: add multiple courts with details
Upload court photos (minimum 3, maximum 10 per court)
Define sports offered per court
## Inventory Management
Set operational hours (by day of week)
Define slot duration (30/60/90 minutes)
Set pricing: base rate, peak/off-peak pricing, weekend rates
Mark special closure dates (maintenance, holidays)
Set maximum advance booking window
## Booking Management Dashboard
Calendar view of all bookings
Real-time availability display
Manual booking creation (for walk-ins or phone bookings)
Booking modification capabilities
Mark slots as blocked/unavailable
## Financial Management
View revenue dashboard (daily, weekly, monthly)
Track pending payments
Payment settlement schedule (weekly/bi-weekly transfers)
Download financial reports
Commission structure visibility
## Settings & Policies
Set cancellation policy (time windows and refund percentages)

Minimum advance booking time
Payment terms (full/partial advance)
Amenities list (parking, changing rooms, equipment rental, etc.)
## 3.3 Admin Panel Features
## Platform Management
Approve/reject court owner applications
Monitor platform health metrics
User and court owner support ticketing system
Content moderation (reviews, photos)
## Financial Operations
Process payouts to court owners
Track platform commission
Generate financial reports
Handle refund requests
## Analytics & Reporting
User acquisition and retention metrics
Booking volume trends
Revenue analytics
Court utilization rates
Geographic demand mapping
## 4. Technical Requirements
## Platform - Flutter Mobile App
Cross-Platform Mobile Application
Single Flutter codebase for both iOS and Android
Native performance with cross-platform efficiency

Significantly cheaper than separate native apps
Simple web-based admin dashboard for court owners (optional Phase 2)
Technology Stack (Low/No Cost)
Frontend: Flutter (free, open-source)
Material Design for Android
Cupertino widgets for iOS
State Management: Provider or Riverpod (free)
Backend: Firebase or Supabase (free tier: up to 50,000 monthly users)
Recommend Firebase for better Flutter integration
## Database:
Firebase: Cloud Firestore (NoSQL, real-time)
Supabase: PostgreSQL (SQL, real-time subscriptions)
## Authentication:
Firebase Auth (includes phone OTP, Google Sign-In)
Supabase Auth (includes phone OTP, social logins)
## Storage:
Firebase Storage or Supabase Storage (for court images)
5GB free tier (sufficient for MVP)
## Push Notifications:
Firebase Cloud Messaging (FCM) - free, unlimited
## Payment:
JazzCash/EasyPaisa merchant SDK integration
Manual verification option for MVP
SMS: Local SMS gateway like Integrate.pk (~PKR 0.10-0.15 per SMS)
Maps: Google Maps Flutter plugin (free for basic usage)
Analytics: Firebase Analytics (free, comprehensive)
## Estimated Cost Breakdown
Google Play Console (one-time): PKR 3,000 (~$10 USD)

Apple Developer Account (yearly): PKR 30,000 (~$99 USD) - Optional for MVP
Firebase free tier: PKR 0
SMS credits (initial 200 messages): PKR 30
Development (self or freelancer): PKR 10,000-15,000
Testing devices: PKR 0 (use personal devices)
Total for Android-only launch: PKR 13,000-18,000
Total for Android + iOS: PKR 43,000-48,000
Recommendation: Launch Android-Only First
80%+ Pakistani smartphone users are on Android
Saves PKR 30,000 on Apple Developer fee
Test market fit before iOS investment
Add iOS in Phase 2 if successful
Flutter Packages (All Free)
firebase_core, firebase_auth, cloud_firestore - Firebase integration
firebase_storage - Image uploads
firebase_messaging - Push notifications
google_maps_flutter - Map integration
image_picker - Camera/gallery access
shared_preferences - Local data storage
http or dio - API calls
flutter_local_notifications - Local notifications
intl - Date/time formatting
cached_network_image - Image caching
provider or riverpod - State management
## Performance Requirements
App size: < 25MB (achievable with Flutter)
Cold start time: < 3 seconds

Page transitions: < 300ms
Real-time availability updates: < 5 second latency
99% uptime target (Firebase reliability)
Support for Android 6.0+ (API level 23+)
Support for iOS 12.0+ (when iOS version launches)
Handle up to 500 concurrent users
## Security
HTTPS for all network requests
Firebase Security Rules for database access
Secure phone OTP authentication
Local data encryption using flutter_secure_storage
Payment processing via established gateways (PCI compliant)
API key protection using environment variables
## Data Storage Strategy
## Firestore Collections:
users - user profiles and authentication data
courts - court details, images, pricing, amenities
bookings - all booking records with timestamps
availability - real-time slot availability
reviews - ratings and reviews (Phase 2)
payments - payment transaction records
notifications - notification history
## Offline Capabilities
View past bookings offline
Cache court information for faster loading
Queue booking requests when offline (with user notification)
Sync when connection restored

## 5. User Experience Requirements
Mobile App UX
Native feel with smooth animations
Gesture-based navigation (swipe, pull-to-refresh)
Bottom navigation bar for main sections
Booking completable in under 60 seconds
Maximum 4 taps from home to booking confirmation
Biometric authentication support (fingerprint/face ID) for quick login
Dark mode support (optional for MVP)
## App Sections
- Home/Explore - Browse and search courts
- Bookings - View upcoming and past bookings
- Favorites - Saved courts for quick access
- Profile - User settings and preferences
## Notifications
Push Notifications (Free via FCM):
Booking confirmation
Reminder 24 hours before booking
Cancellation alerts
Owner messages
Special offers (Phase 2)
SMS Backup (for critical events if push fails):
Booking confirmation (with booking ID)
Cancellations by owner
Payment confirmations

## Language Support
## Primary: English
Future: Urdu support for broader accessibility
Use easy_localization package for i18n
## Cancellation Policy
Users can cancel up to X hours before booking (court owner defined)
Refund processing within 5-7 business days
Clear display of refund amount based on cancellation timing
## 6. Business Model
Revenue Streams (Post-MVP)
- Commission: 8-12% commission on each booking (competitive for Pakistan market)
- Featured Listings: PKR 2,000-5,000/month for top placement
- No subscription model initially - keep it simple
## Pricing Strategy
Free for users to browse and book
Free for court owners for first 3 months (pilot period)
Court owners set their own pricing (typically PKR 1,500-3,500/hour depending on sport and location)
Platform commission starts after pilot period
No setup fees for court owners
## Initial Revenue Model
First 6 months: Focus on growth, no revenue collection
After 6 months: Introduce 8-10% commission
Keep it transparent: Show court owners exactly what they earn per booking

## 7. Launch Strategy
Phase 1: MVP (Months 1-2) - Budget: PKR 15-20k
Progressive Web App with core booking functionality
Manual payment verification (cash/screenshot)
3-5 pilot courts in DHA/Clifton area
Focus on one sport initially (cricket or futsal - whichever courts you can sign first)
Manual court owner onboarding and verification
Basic SMS notifications
Target: 50-100 users, 20+ bookings/week
Phase 2: Enhancement (Months 3-4) - Self-funded or Angel Investment
Expand to all three sports (cricket, futsal, padel)
Add 10-15 more courts across Karachi
Implement JazzCash/EasyPaisa payment integration
Rating and review system
Automated payment reconciliation
Target: 500+ users, 100+ bookings/week
Phase 3: Scale (Months 5-8)
Expand to 25+ courts citywide
Recurring bookings feature
Tournament booking capabilities
Mobile app (if revenue justifies cost)
Equipment rental marketplace
Corporate partnerships
Target: 2,000+ users, 500+ bookings/week
Phase 4: City Domination (Months 9-12)
50+ courts across all major areas

Multiple sports covered comprehensively
Consider expansion to Lahore or Islamabad
Premium features for court owners
Loyalty program for users
## 8. Success Criteria
User Success (Phase 1)
60%+ users successfully complete their first booking
50+ bookings in first month
Average user books 1.5+ times per month
70%+ of users say platform is easier than WhatsApp booking
Court Owner Success (Phase 1)
30%+ reduction in time spent on booking management
Zero double-bookings reported
100% of pilot court owners continue after free period
Owners receive bookings within 2 hours of listing going live
Business Success (Phase 1)
Break-even by month 12 (including deferred commission)
25% month-over-month growth in bookings
Customer Acquisition Cost (CAC) < PKR 100 per user (via organic/social)
3-5 courts signed up by end of month 1
## 9. Risks & Mitigations
RiskImpactMitigation
Low court owner adoptionHighOffer 3-month free period, personally onboard first 5 courts, show clear
time savings
Users don't trust cash payment
model
MediumOffer booking confirmation SMS, display court owner contact, start
with reputable venues

RiskImpactMitigation
Technical issues with free tier
limits
MediumMonitor usage closely, upgrade to paid plans when approaching limits
Competition from WhatsApp
groups
HighFocus on superior convenience, instant confirmation, no waiting for
replies
Payment collection disputesHighClear terms, SMS confirmations, escrow for online payments in Phase 2
Limited budget constrains growthHighBootstrap with revenue, seek small angel investment after proving
concept
Court owners reluctant to pay
commission
MediumDemonstrate value through increased bookings, start with very low 5-
8% commission
## 10. Open Questions
- Should we start with cricket, futsal, or padel first? (Recommend starting with whichever sport you have
personal connections to)
- Cash payment at venue vs. online payment for MVP? (Recommend cash for MVP to reduce complexity)
- What commission rate will court owners accept? (Test with 5% first, gradually increase)
- How do we handle no-shows? Advance payment requirement? (For MVP, let court owners handle this
their way)
- Should we take any advance deposit from users? (No for MVP - keep it simple)
- What's our customer support strategy with zero budget? (Personal WhatsApp number initially)
- How do we acquire first 5 court owners? (Personal network, direct visits, offer free service)
- Which area of Karachi should we launch in first? (DHA Phase 5-8 or Clifton - high concentration of
courts)
## 11. Timeline & Development Approach
Pre-Development (Week 1)
Set up development environment (Flutter SDK, Android Studio/VS Code)
Create Firebase project and configure
Register Google Play Console account (PKR 3,000)
Design app UI/UX (use Figma - free)

Create wireframes and user flows
Identify and contact 10 potential pilot courts
Set up version control (GitHub/GitLab)
Development Sprint (Week 2-6)
## Week 2: Foundation
Set up Flutter project structure
Implement Firebase integration
Build authentication flow (phone OTP)
Create basic navigation structure
Set up state management
## Week 3: Core User Features
Court listing and search screen
Court detail page with image gallery
Filter and sort functionality
Google Maps integration
User profile screen
## Week 4: Booking Flow
Calendar view for slot selection
Real-time availability checking
Booking confirmation flow
Payment method selection (cash/online)
Booking history screen
## Week 5: Court Owner Features
Owner registration and verification
Court management dashboard
Add/edit court details and photos

Availability calendar management
Booking notifications
## Week 6: Polish & Integration
Push notifications setup
SMS integration
Error handling and edge cases
Loading states and animations
Firebase security rules
App icon and splash screen
Testing Phase (Week 7-8)
Internal testing on multiple Android devices
Fix critical bugs
Test on different screen sizes
Test booking flow end-to-end with test users
Performance optimization
Onboard 2-3 pilot courts
Get 10-20 test bookings
Launch Preparation (Week 9)
Create Google Play Store listing
App screenshots (5-8 required)
App description and keywords
Privacy policy (use online generator)
Feature graphic
Submit app for review (takes 1-3 days)
Prepare launch marketing materials
Brief pilot court owners
Soft Launch (Week 10)

Release on Google Play Store
Install on personal phones
Share with immediate network
Monitor crash reports and analytics
Gather initial feedback
Target: 20-30 installs, 5-10 bookings
Iteration & Growth (Week 11-16)
Weekly app updates based on feedback
Fix bugs reported by users
Onboard 5-10 more courts
Gradual marketing ramp-up
Monitor Firebase costs (should remain free)
Target: 100+ installs by week 16
iOS Launch Consideration (Month 4-5)
If Android version successful (500+ users)
Invest in Apple Developer Account (PKR 30,000)
Test on iOS devices (borrow or use simulator)
Submit to App Store
Typically takes 1-2 weeks for approval
## 12. Appendix
Marketing Strategy (Zero Budget)
- Instagram/Facebook: Create business page, post court highlights, user testimonials
- WhatsApp Status: Use personal status to promote platform
- Direct Outreach: Visit courts personally, demo the platform to owners
- Sports Groups: Join Karachi cricket/futsal WhatsApp and Facebook groups, subtly promote
- Word of Mouth: Incentivize early users (every 5th booking free, or similar)

- Google My Business: Free listing to appear in local searches
- Content: Create Reels/TikToks showing booking process, court highlights
Competitive Landscape in Karachi
Current State: Mostly WhatsApp-based booking with no unified platform
Potential Competitors: None identified yet in Karachi for multi-venue booking
International Examples: PlaySpots (UAE), Playo (India) - but not operating in Pakistan
Advantage: First-mover in Karachi market
Key Karachi Court Areas to Target
- Phase 1 Focus: DHA Phase 5-8, Clifton
Highest concentration of courts
Tech-savvy user base
Higher income demographic
## 2. Phase 2 Expansion: Gulshan, Malir Cantt, Bahria Town
Growing sports infrastructure
Price-conscious but active user base
- Phase 3: North Karachi, Gulistan-e-Jauhar, Korangi
Larger population, more price-sensitive
Requires established brand credibility
Technical Architecture (Flutter + Firebase)
## Mobile App: Flutter
## Mobile App: Flutter
## ├── Presentation Layer
## ├── Presentation Layer
│   ├── Screens (Home, Court Detail, Booking, Profile, Owner Dashboard)
│   ├── Screens (Home, Court Detail, Booking, Profile, Owner Dashboard)
│   ├── Widgets (Reusable UI components)
│   ├── Widgets (Reusable UI components)
│   └── Theme (Colors, typography, spacing)
│   └── Theme (Colors, typography, spacing)
## ├── Business Logic Layer
## ├── Business Logic Layer
│   ├── State Management (Provider/Riverpod)
│   ├── State Management (Provider/Riverpod)
│   ├── Services (Auth, Booking, Payment)
│   ├── Services (Auth, Booking, Payment)
│   └── Models (User, Court, Booking)
│   └── Models (User, Court, Booking)
## └── Data Layer
## └── Data Layer


├── Repositories (Firebase abstraction)
├── Repositories (Firebase abstraction)


└── Local Storage (Shared Preferences)
└── Local Storage (Shared Preferences)

## Flutter Project Structure
## Backend: Firebase
## Backend: Firebase
## ├── Authentication
## ├── Authentication
│   ├── Phone Number + OTP
│   ├── Phone Number + OTP
│   ├── Google Sign-In
│   ├── Google Sign-In
│   └── Anonymous auth (guest mode)
│   └── Anonymous auth (guest mode)
## ├── Firestore Database
## ├── Firestore Database
│   ├── users collection
│   ├── users collection
│   ├── courts collection
│   ├── courts collection
│   ├── bookings collection
│   ├── bookings collection
│   ├── availability sub-collections
│   ├── availability sub-collections
│   └── Real-time listeners
│   └── Real-time listeners
## ├── Cloud Storage
## ├── Cloud Storage
│   ├── Court images
│   ├── Court images
│   ├── User profile pictures
│   ├── User profile pictures
│   └── Payment screenshots (temporary)
│   └── Payment screenshots (temporary)
├── Cloud Messaging (FCM)
├── Cloud Messaging (FCM)
│   ├── Push notifications
│   ├── Push notifications
│   └── Topic-based messaging
│   └── Topic-based messaging
├── Cloud Functions (Minimal usage to stay free)
├── Cloud Functions (Minimal usage to stay free)
│   ├── Send booking confirmations
│   ├── Send booking confirmations
│   ├── Update availability on booking
│   ├── Update availability on booking
│   └── Process scheduled tasks
│   └── Process scheduled tasks
## └── Analytics
## └── Analytics


├── User behavior tracking
├── User behavior tracking


├── Conversion funnel analysis
├── Conversion funnel analysis


└── Crash reporting
└── Crash reporting
Third-Party Integrations:
Third-Party Integrations:
## ├── Google Maps Flutter Plugin
## ├── Google Maps Flutter Plugin
├── SMS Gateway API (Integrate.pk)
├── SMS Gateway API (Integrate.pk)
├── JazzCash/EasyPaisa SDK (Phase 2)
├── JazzCash/EasyPaisa SDK (Phase 2)
## └── Image Picker & Compression
## └── Image Picker & Compression
App Architecture Pattern: Clean Architecture / MVVM
App Architecture Pattern: Clean Architecture / MVVM
├── Separation of concerns
├── Separation of concerns
├── Testable code structure
├── Testable code structure
├── Easy to maintain and scale
├── Easy to maintain and scale
└── Clear dependency flow
└── Clear dependency flow
lib/
lib/

## Key Flutter Screens & Features
## User App Screens:
- Splash Screen - App logo with loading indicator
- Onboarding - 3-4 slides explaining app (first time only)
- Auth Screen - Phone number input + OTP verification
- Home Screen - Featured courts, search bar, sport filters
- Court List - Grid/list view with filters
- Court Detail - Image carousel, info, availability calendar
- Booking Screen - Date/time selection, price summary
├── main.dart
├── main.dart
├── app/
├── app/
│   ├── routes.dart
│   ├── routes.dart
│   └── theme.dart
│   └── theme.dart
├── core/
├── core/
│   ├── constants/
│   ├── constants/
│   ├── utils/
│   ├── utils/
│   └── widgets/
│   └── widgets/
├── features/
├── features/
│   ├── auth/
│   ├── auth/
│   │   ├── screens/
│   │   ├── screens/
│   │   ├── widgets/
│   │   ├── widgets/
│   │   └── providers/
│   │   └── providers/
│   ├── courts/
│   ├── courts/
│   │   ├── screens/
│   │   ├── screens/
│   │   ├── widgets/
│   │   ├── widgets/
│   │   ├── models/
│   │   ├── models/
│   │   └── providers/
│   │   └── providers/
│   ├── bookings/
│   ├── bookings/
│   │   ├── screens/
│   │   ├── screens/
│   │   ├── widgets/
│   │   ├── widgets/
│   │   └── providers/
│   │   └── providers/
│   └── owner/
│   └── owner/
│       ├── screens/
│       ├── screens/
│       └── providers/
│       └── providers/
└── services/
└── services/


├── firebase_service.dart
├── firebase_service.dart


├── payment_service.dart
├── payment_service.dart


└── notification_service.dart
└── notification_service.dart

- Payment Screen - Method selection, confirmation
- My Bookings - Upcoming/past tabs
- Profile Screen - Settings, logout, support
## Court Owner Screens:
- Owner Dashboard - Today's bookings, revenue stats
- Court Management - Add/edit courts
- Calendar View - Weekly/monthly booking overview
- Booking Details - Individual booking management
- Earnings - Revenue tracking and reports
Firebase Security Rules (Example)
javascript

## Recommended First Steps
- This Week (Planning & Setup):
Install Flutter and set up development environment
Create Firebase project and configure for Android
Design UI mockups in Figma (or use existing templates)
Visit 3-5 courts in DHA and gauge interest
Create feature list and prioritize for MVP
- Week 2-3 (Core Development):
If you code Flutter: Start with authentication and Firebase setup
If hiring: Post on Rozee.pk/Upwork with detailed requirements
Budget: PKR 10,000-15,000
rules_version
rules_version
## =
## =


## '2'
## '2'
## ;
## ;
service cloud
service cloud
## .
## .
firestore
firestore


## {
## {
match
match
## /
## /
databases
databases
## /
## /
## {
## {
database
database
## }
## }
## /
## /
documents
documents
## {
## {


// Users can read/write their own data
// Users can read/write their own data
match
match
## /
## /
users
users
## /
## /
## {
## {
userId
userId
## }
## }


## {
## {
allow read
allow read
## :
## :


if
if
request
request
## .
## .
auth
auth


## !=
## !=


null
null
## ;
## ;
allow write
allow write
## :
## :


if
if
request
request
## .
## .
auth
auth
## .
## .
uid
uid


## ==
## ==
userId
userId
## ;
## ;


## }
## }




// Courts are readable by all, writable by owners
// Courts are readable by all, writable by owners
match
match
## /
## /
courts
courts
## /
## /
## {
## {
courtId
courtId
## }
## }


## {
## {
allow read
allow read
## :
## :


if
if


true
true
## ;
## ;
allow create
allow create
## :
## :


if
if
request
request
## .
## .
auth
auth


## !=
## !=


null
null
## ;
## ;
allow update
allow update
## ,
## ,


delete
delete
## :
## :


if
if
request
request
## .
## .
auth
auth
## .
## .
uid
uid


## ==
## ==
resource
resource
## .
## .
data
data
## .
## .
ownerId
ownerId
## ;
## ;


## }
## }




// Bookings readable by user and owner
// Bookings readable by user and owner
match
match
## /
## /
bookings
bookings
## /
## /
## {
## {
bookingId
bookingId
## }
## }


## {
## {
allow read
allow read
## :
## :


if
if
request
request
## .
## .
auth
auth
## .
## .
uid
uid


## ==
## ==
resource
resource
## .
## .
data
data
## .
## .
userId
userId




## ||
## ||
request
request
## .
## .
auth
auth
## .
## .
uid
uid


## ==
## ==
resource
resource
## .
## .
data
data
## .
## .
ownerId
ownerId
## ;
## ;
allow create
allow create
## :
## :


if
if
request
request
## .
## .
auth
auth


## !=
## !=


null
null
## ;
## ;
allow update
allow update
## :
## :


if
if
request
request
## .
## .
auth
auth
## .
## .
uid
uid


## ==
## ==
resource
resource
## .
## .
data
data
## .
## .
ownerId
ownerId
## ;
## ;


## }
## }


## }
## }
## }
## }

Show mockups and feature list
Ask for Flutter + Firebase experience
Request portfolio of previous apps
Set up Git repository for version control
Create basic navigation and home screen
- Week 4-5 (Feature Development):
Build court listing and detail screens
Implement booking flow
Set up Firebase Firestore collections
Test on multiple devices
Create court owner dashboard
- Week 6-7 (Testing & Refinement):
Internal testing on various Android devices
Onboard 2-3 pilot courts
Fix bugs and improve UX
Prepare Play Store assets
Create privacy policy
- Week 8-9 (Launch Preparation):
Submit to Google Play Store
While waiting for approval (1-3 days):
Create Instagram/Facebook pages
Prepare launch announcement
Brief pilot court owners
First week post-launch: Monitor closely, fix critical issues
## Development Resources
Flutter Tutorials: flutter.dev/docs, YouTube (Maximilian Schwarzmüller, The Net Ninja)
Firebase Setup: firebase.google.com/docs/flutter/setup
UI Inspiration: dribbble.com, mobbin.com (booking apps)
Free Assets: unsplash.com (images), flaticon.com (icons)

Testing: Use Firebase Test Lab (free for limited use)
Hiring a Flutter Developer (If Needed)
Where to Find:
Rozee.pk (Pakistani developers)
## Upwork Pakistan
## Fiverr Pakistan
Local Flutter community groups
What to Look For:
1-2 years Flutter experience
Firebase integration experience
Portfolio with at least 2 published apps
Understanding of state management
Communication in English/Urdu
## Job Post Template:

Title: Flutter Developer for Court Booking App (MVP)
Title: Flutter Developer for Court Booking App (MVP)
Budget: PKR 10,000-15,000
Budget: PKR 10,000-15,000
Duration: 4-5 weeks
Duration: 4-5 weeks
## Requirements:
## Requirements:
- Build cross-platform mobile app using Flutter
- Build cross-platform mobile app using Flutter
- Firebase backend integration (Firestore, Auth, Storage, FCM)
- Firebase backend integration (Firestore, Auth, Storage, FCM)
- User authentication with phone OTP
- User authentication with phone OTP
- Court listing, search, and booking flow
- Court listing, search, and booking flow
- Court owner dashboard
- Court owner dashboard
- Push notifications
- Push notifications
- Google Maps integration
- Google Maps integration
- Clean, modern UI with smooth animations
- Clean, modern UI with smooth animations
## Deliverables:
## Deliverables:
- Complete source code
- Complete source code
- Published on Google Play Store
- Published on Google Play Store
- Documentation for future updates
- Documentation for future updates
- 2 weeks bug fix support post-launch
- 2 weeks bug fix support post-launch
Must have:
Must have:
- 1+ year Flutter experience
- 1+ year Flutter experience
- Previous Firebase projects
- Previous Firebase projects
- Available for weekly check-ins
- Available for weekly check-ins
- Portfolio of published apps
- Portfolio of published apps
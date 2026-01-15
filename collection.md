# Firestore Collection Schema

This document outlines the Firestore collection structure and field definitions for the KhelKood Court Booking Platform.

---

## 1. `users`
Stores user profiles and authentication-related data for both players and court owners.

| Field | Type | Description |
| :--- | :--- | :--- |
| `uid` | String | Unique identifier from Firebase Auth |
| `phoneNumber` | String | User's phone number |
| `displayName` | String | Full name of the user |
| `email` | String | (Optional) Email address |
| `role` | String | User role: `player`, `owner`, or `admin` |
| `preferredSports` | Array<String> | List of sports the user is interested in (e.g., `["cricket", "futsal"]`) |
| `skillLevel` | String | (Optional) Skill level for matchmaking/profile |
| `profileImageUrl` | String | URL to profile picture in Firebase Storage |
| `favorites` | Array<String> | List of `courtId`s saved as favorites |
| `fcmToken` | String | FCM token for push notifications |
| `createdAt` | Timestamp | Account creation timestamp |
| `lastLoginTime` | Timestamp | Last login timestamp |

---

## 2. `courts`
Contains details about each sports facility/court.

| Field | Type | Description |
| :--- | :--- | :--- |
| `courtId` | String | Unique identifier |
| `ownerId` | String | `uid` of the court owner |
| `name` | String | Name of the facility |
| `description` | String | Detailed description of the court |
| `sportTypes` | Array<String> | Types of sports: `["cricket", "futsal"]` |
| `area` | String | Geographic area in Karachi (e.g., `DHA`, `Clifton`) |
| `address` | String | Physical address |
| `location` | String | Google Maps location link (URL) |
| `pricing` | Map | Pricing details: `{ "base": 2500, "peak": 3500, "weekend": 3000 }` |
| `photos` | Array<String> | List of URLs to court images |
| `amenities` | Array<String> | List of amenities (e.g., `["parking", "washroom", "drinking_water"]`) |
| `operationalHours` | Map | Weekly schedule: `{ "mon": { "open": "09:00", "close": "22:00" }, ... }` |

| `maxAdvanceBooking` | Number | Maximum days in advance a user can book |
| `cancellationPolicy`| Map | Details: `{ "noticeHours": 24, "refundPercentage": 50 }` |
| `isVerified` | Boolean | Whether the court is verified by admin |
| `rating` | Number | Average rating (calculated) |
| `reviewCount` | Number | Total number of reviews |
| `createdAt` | Timestamp | Document creation timestamp |

---

## 3. `bookings`
Records all booking transactions.

| Field | Type | Description |
| :--- | :--- | :--- |
| `bookingId` | String | Unique identifier |
| `userId` | String | `uid` of the player who booked |
| `courtId` | String | ID of the booked court |
| `ownerId` | String | `uid` of the court owner |
| `bookingDate` | Timestamp | The date for which the booking is made |
| `startTime` | Timestamp | Start time of the session |
| `endTime` | Timestamp | End time of the session |
| `slots` | Array<String> | List of reserved slots (e.g., `["18:00", "19:00"]`) |
| `totalPrice` | Number | Final price paid |
| `paymentStatus` | String | `pending`, `confirmed`, `rejected`, `refunded` |
| `bookingStatus` | String | `upcoming`, `completed`, `cancelled` |
| `paymentMethod` | String | `cash`, `jazzcash`, `easypaisa`, `bank_transfer` |
| `paymentScreenshot`| String | URL to payment verification screenshot |
| `createdAt` | Timestamp | When the booking was created |
| `updatedAt` | Timestamp | When the booking was last updated |

---

## 4. `courts/{courtId}/availability`
A sub-collection under each court to track real-time slot availability for specific dates.

| Field | Type | Description |
| :--- | :--- | :--- |
| `date` | String | ISO Date string (e.g., `2024-01-20`) |
| `slots` | Map | Reserved slots: `{ "18:00": { "isAvailable": false, "bookingId": "..." } }` |

---

## 5. `reviews` (Phase 2)
User-generated reviews for courts.

| Field | Type | Description |
| :--- | :--- | :--- |
| `reviewId` | String | Unique identifier |
| `courtId` | String | ID of the reviewed court |
| `userId` | String | `uid` of the reviewer |
| `rating` | Number | Rating score (1-5) |
| `comment` | String | User's feedback text |
| `createdAt` | Timestamp | Review timestamp |

---

## 6. `payments`
Auditable record of payment transactions.

| Field | Type | Description |
| :--- | :--- | :--- |
| `transactionId` | String| Unique transaction identifier |
| `bookingId` | String | Associated booking ID |
| `userId` | String | `uid` of the payer |
| `amount` | Number | Transaction amount |
| `method` | String | Payment method used |
| `status` | String | `pending`, `success`, `failed` |
| `metadata` | Map | Additional data (gateway response, etc.) |
| `createdAt` | Timestamp | Transaction timestamp |

---

## 7. `notifications`
History of push and SMS notifications sent to users.

| Field | Type | Description |
| :--- | :--- | :--- |
| `notificationId` | String | Unique identifier |
| `userId` | String | `uid` of the recipient |
| `title` | String | Notification title |
| `body` | String | Notification message body |
| `type` | String | `booking_confirmation`, `reminder`, `cancellation` |
| `isRead` | Boolean | Whether the user has seen the notification |
| `createdAt` | Timestamp | Sent timestamp |

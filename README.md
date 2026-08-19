# PakVista 🇵🇰

### Explore Pakistan. Discover Experiences. Plan Smarter.

PakVista is a Flutter-based tourism and travel guide application designed to help users explore Pakistan's tourist destinations, discover local experiences, find places to stay and eat, view locations on an interactive map, and generate personalized travel plans using AI.

---

## 📱 About the Project

Pakistan has a diverse range of tourism destinations, from the mountains of Gilgit-Baltistan and Khyber Pakhtunkhwa to the historical landmarks and cultural heritage of Punjab and Sindh.

PakVista brings important travel information into a single mobile application and provides an AI-powered trip planning experience to make travel planning easier and more personalized.

---

## ✨ Features

### 🗺️ Explore Tourist Destinations
- Discover tourist attractions across Pakistan
- View destination details
- Explore locations through an interactive map
- Browse destination information in an easy-to-use interface

### 🤖 AI Trip Planner
- Generate personalized travel plans
- Provide destination and trip preferences
- AI-powered recommendations
- OpenRouter API integration
- Fallback handling for AI requests

### ❤️ Favourites
- Save preferred destinations
- Quickly access saved places

### 🍽️ Food & Dining
- Explore food-related recommendations
- Discover local Pakistani cuisine and dining experiences

### 🏨 Places to Stay
- Explore accommodation-related information
- Discover suitable places to stay during trips

### 🛡️ Safety Information
- Access travel safety information
- Display important safety alerts and recommendations

### 📍 Interactive Maps
- Location-based tourism exploration
- Interactive map interface
- Tourist destination markers

### 👤 User Profile
- Dedicated profile interface
- User-related application information

### 🎨 Modern Flutter UI
- Mobile-first interface
- Custom tourism-focused screens
- Smooth navigation
- Responsive design

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform application development |
| Dart | Application programming language |
| OpenRouter API | AI-powered trip planning |
| Flutter Map | Interactive maps |
| Geolocator | Location services |
| HTTP | API communication |
| Android Studio | Android development |
| Git & GitHub | Version control |

---

## 🏗️ Project Structure

```text
lib/
├── main.dart
├── detail_screen.dart
│
├── screens/
│   ├── ai_trip_planner_card.dart
│   ├── explore_screen.dart
│   ├── favourites_screen.dart
│   ├── food_card.dart
│   ├── home_screen.dart
│   ├── login_screen.dart
│   ├── map_screen.dart
│   ├── profile_screen.dart
│   ├── safety_alerts_card.dart
│   ├── splash_screen.dart
│   ├── stay_card.dart
│   ├── tourist_spot.dart
│   └── tourist_spots_data.dart
│
└── services/
    └── ai_trip_planner_service.dart
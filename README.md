# Crewmeister Absence Manager

A Flutter web and mobile application for managing employee absences, built using Clean Architecture and Riverpod.

## 🛠 Features

- Filterable and paginated list of absences
- View detailed absence information
- Export absences to `.ics` calendar format
- Caching and local data management
- Light And Dark Mode
- Web and Mobile Supoprt

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
clone the repo
change into the repo
```

### 2. Install Flutter Dependencies
Make sure you have Flutter installed. Then run:

```bash
flutter pub get
```

### 3. Run the Project

#### Web:

```bash
flutter run -d chrome
```

#### Mobile:

Connect your emulator or device and run:

```bash
flutter run
```

---

## 🧪 Running Tests

To run all unit and widget tests:

```bash
flutter test
```

---

## 📂 Project Structure

```
lib/
├── core/                  # Shared utilities and constants
├── features/absence_manager/
│   ├── data/              # Models and repositories
│   ├── domain/            # Entities and abstract repositories
│   ├── presentation/      # UI and view logic
├── services/              # File + calendar services
```

---

## 📦 Tech Stack

- Flutter (Web & Mobile)
- Riverpod for state management
- Clean Architecture
- Path Provider & Intl packages

---

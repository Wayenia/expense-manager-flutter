

## English Version

# Expense Tracker

## Personal Expense Management Mobile Application

---

### Project Context

This project constitutes the **final certification work** of the **IBM Flutter and Dart Mobile Apps Development for iOS and Android** program. It demonstrates the acquisition and mastery of skills required for professional cross-platform mobile application development.

---

### Abstract

**Expense Tracker** is a Flutter-based mobile application providing comprehensive personal finance management. It offers structured expense recording, categorization, visualization, local data persistence, and reactive user interface.

---

### Core Features

| Feature | Description |
|---------|-------------|
| **Quick Entry** | Record expenses with amount, payee, category, and optional notes |
| **Smart Organization** | Group expenses by date or category |
| **Custom Management** | Create and modify categories and tags |
| **Local Storage** | Offline-capable data persistence via `localstorage` |
| **Intuitive Deletion** | Swipe-to-delete functionality |
| **Ergonomic Interface** | Modern design with color coding and tab navigation |

---

### Technical Architecture

#### Project Structure

```
lib/
├── main.dart                 # Entry point, provider configuration
├── models/                   # Business entities
│   ├── expense.dart          # Expense model (JSON serializable)
│   ├── expense_category.dart # Category model
│   └── tag.dart              # Tag model
├── providers/                # State and business logic
│   └── expense_provider.dart # Centralized management (ChangeNotifier)
├── screens/                  # Main views
│   ├── home_screen.dart      # Main screen with tabs
│   ├── add_expense_screen.dart # Create/edit expense
│   ├── category_management_screen.dart
│   └── tag_management_screen.dart
└── widgets/                  # Reusable components
    ├── add_category_dialog.dart
    └── add_tag_dialog.dart
```

#### Design Patterns

| Pattern | Implementation |
|---------|----------------|
| **MVVM** | Models / Providers (ViewModel) / Screens (View) separation |
| **Observer** | `ChangeNotifier` + `Consumer` for reactivity |
| **Repository** | `ExpenseProvider` as single source of truth |
| **Factory Method** | `fromJson` / `toJson` for serialization |

#### Data Flow

```
User → Screen → Provider (state) → Models → LocalStorage
              ↓
         notifyListeners()
              ↓
         Rebuild UI (Consumer)
```

---

### Technical Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| flutter | SDK | UI Framework |
| provider | ^6.0.0 | State management |
| localstorage | ^4.0.0 | Local persistence |
| intl | ^0.18.0 | Date formatting |
| collection | ^1.17.0 | Data grouping (`groupBy`) |

---

### Installation and Execution

```bash
# Clone repository
git clone [repo-url]

# Navigate to project
cd expense_manager

# Fetch dependencies
flutter pub get

# Run application
flutter run
```

---

### Technical Specifications

| Aspect | Implementation |
|--------|----------------|
| **State Management** | Provider with `ChangeNotifier` |
| **Serialization** | Manual JSON via `toJson` / `fromJson` |
| **Identifiers** | UNIX timestamp (`millisecondsSinceEpoch`) |
| **Navigation** | Named routes (`/`, `/manage_categories`, `/manage_tags`) |
| **Validation** | Required field checking before submission |
| **Lifecycle** | `initState` / `dispose` for controllers |

---

### Demonstrated Competencies (IBM Certification)

| Competency | Project Implementation |
|------------|------------------------|
| **Flutter Development** | Complete functional mobile application creation |
| **State Management** | Provider pattern with `ChangeNotifier` and `Consumer` |
| **Dart Programming** | Classes, inheritance, mixins, generics, async/await |
| **Local Persistence** | `localstorage` integration and usage |
| **Navigation** | Named routes and parameter passing between screens |
| **Forms** | `TextEditingController`, validation, `showDialog` |
| **Date Manipulation** | `DateTime`, `showDatePicker`, `intl` formatting |
| **Collections** | `groupBy`, `fold`, `map`, `where`, `removeWhere` |
| **UI/UX** | `TabBar`, `ListView`, `Dismissible`, `Drawer`, `FloatingActionButton` |

---

### Testing and Validation

The application has been tested on the following configurations:

| Platform | Environment | Result |
|----------|-------------|--------|
| iOS | Simulator (iPhone 14) | ✅ Functional |
| Android | Emulator (Pixel 6) | ✅ Functional |
| Web | Chrome (debug) | ✅ Functional |

---

### Project Deliverables

- Complete application source code
- Technical documentation (README)
- MVVM structure following Flutter best practices
- Reactive state management without excessive boilerplate
- Responsive and intuitive user interface

---

### Conclusion

This IBM certification project demonstrates my ability to:

1. **Design** a complete mobile application from scratch
2. **Implement** a professional architecture (MVVM)
3. **Integrate** third-party packages appropriately
4. **Manage** state and data persistence
5. **Produce** maintainable, documented, and testable code

---

### Contact Information

**Program** : IBM Flutter and Dart Mobile Apps Development for iOS and Android  
**Type** : Final certification project  
**Year** : 2024-2025

---

**Built with Flutter** — Single codebase, two platforms (iOS & Android)
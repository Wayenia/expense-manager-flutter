# Expense Tracker

## Application Mobile de Gestion des Dépenses Personnelles

---

### Contexte du Projet

Ce projet constitue le **travail de certification final** du programme **IBM Flutter and Dart Mobile Apps Development for iOS and Android**, validé par la certification suivante :

| Certification | Détails |
|---------------|---------|
| **Intitulé** | Flutter and Dart: Developing iOS, Android, and Mobile Apps |
| **Émetteur** | IBM (via Coursera) |
| **Bénéficiaire** | Souleymane Sebgo |
| **Date d'obtention** | 4 mars 2026 |
| **Certificat** | [Voir le certificat (PNG)](./Completion.png) |
| **Lien de vérification** | [coursera.org/verify/4GvQBZOXU91G](https://coursera.org/verify/4GvQBZOXU91G) |

Cette certification atteste de l'acquisition et de la maîtrise des compétences nécessaires au développement d'applications mobiles cross-platform professionnelles.

---

### Résumé

L'application **Expense Tracker** est une solution mobile développée avec Flutter permettant la gestion complète des finances personnelles. Elle offre un système structuré d'enregistrement, de catégorisation et de visualisation des dépenses, avec persistance locale des données et interface utilisateur réactive.

---

### Fonctionnalités Principales

| Fonctionnalité | Description |
|----------------|-------------|
| **Saisie rapide** | Enregistrement des dépenses avec montant, bénéficiaire, catégorie et note optionnelle |
| **Organisation intelligente** | Regroupement des dépenses par date ou par catégorie |
| **Gestion personnalisée** | Création et modification de catégories et d'étiquettes (tags) |
| **Stockage local** | Persistance des données via `localstorage`, fonctionnement hors ligne |
| **Suppression intuitive** | Suppression par glissement (swipe-to-delete) |
| **Interface ergonomique** | Design moderne avec code couleur et navigation par onglets |

---

### Architecture Technique

#### Structure du projet

```
lib/
├── main.dart                 # Point d'entrée, configuration des providers
├── models/                   # Entités métier
│   ├── expense.dart          # Modèle de dépense (JSON serializable)
│   ├── expense_category.dart # Modèle de catégorie
│   └── tag.dart              # Modèle d'étiquette
├── providers/                # État et logique métier
│   └── expense_provider.dart # Gestion centralisée (ChangeNotifier)
├── screens/                  # Vues principales
│   ├── home_screen.dart      # Écran principal avec onglets
│   ├── add_expense_screen.dart # Création/édition de dépense
│   ├── category_management_screen.dart
│   └── tag_management_screen.dart
└── widgets/                  # Composants réutilisables
    ├── add_category_dialog.dart
    └── add_tag_dialog.dart
```

#### Patrons de conception implémentés

| Patron | Implémentation |
|--------|----------------|
| **MVVM** | Séparation Models (données) / Providers (ViewModel) / Screens (View) |
| **Observer** | `ChangeNotifier` + `Consumer` pour la réactivité |
| **Repository** | `ExpenseProvider` comme source unique de vérité |
| **Factory Method** | `fromJson` / `toJson` pour la sérialisation |

#### Flux de données

```
Utilisateur → Screen → Provider (état) → Models → LocalStorage
                ↓
           notifyListeners()
                ↓
           Rebuild UI (Consumer)
```

---

### Dépendances Techniques

| Package | Version | Utilisation |
|---------|---------|-------------|
| flutter | SDK | Framework UI |
| provider | ^6.0.0 | Gestion d'état |
| localstorage | ^4.0.0 | Persistance locale |
| intl | ^0.18.0 | Formatage des dates |
| collection | ^1.17.0 | Regroupement de données (`groupBy`) |

---

### Installation et Exécution

```bash
# Cloner le dépôt
git clone [url-du-repo]

# Accéder au projet
cd expense_manager

# Récupérer les dépendances
flutter pub get

# Lancer l'application
flutter run
```

---

### Spécifications Techniques Complémentaires

| Aspect | Implémentation |
|--------|----------------|
| **Gestion d'état** | Provider avec `ChangeNotifier` |
| **Sérialisation** | JSON manuelle via `toJson` / `fromJson` |
| **Identifiants** | Timestamp UNIX (`millisecondsSinceEpoch`) |
| **Navigation** | Nommée (`/`, `/manage_categories`, `/manage_tags`) |
| **Validation** | Contrôle des champs requis avant soumission |
| **Cycle de vie** | `initState` / `dispose` pour controllers |

---

### Compétences Démontrées (Certification IBM)

| Compétence | Mise en œuvre dans le projet |
|------------|------------------------------|
| **Développement Flutter** | Création complète d'une application mobile fonctionnelle |
| **Gestion d'état** | Provider pattern avec `ChangeNotifier` et `Consumer` |
| **Programmation Dart** | Classes, héritage, mixins, génériques, async/await |
| **Persistance locale** | Intégration et utilisation de `localstorage` |
| **Navigation** | Routes nommées et passage de paramètres entre écrans |
| **Formulaires** | `TextEditingController`, validation, `showDialog` |
| **Manipulation de dates** | `DateTime`, `showDatePicker`, `intl` formatting |
| **Collections** | `groupBy`, `fold`, `map`, `where`, `removeWhere` |
| **UI/UX** | `TabBar`, `ListView`, `Dismissible`, `Drawer`, `FloatingActionButton` |

---

### Tests et Validation

L'application a été testée sur les configurations suivantes :

| Plateforme | Environnement | Résultat |
|------------|---------------|----------|
| iOS | Simulateur (iPhone 14) | ✅ Fonctionnel |
| Android | Émulateur (Pixel 6) | ✅ Fonctionnel |
| Web | Chrome (debug) | ✅ Fonctionnel |

---

### Livrables du Projet

- Code source complet de l'application
- Documentation technique (README)
- Structure MVVM respectant les bonnes pratiques Flutter
- Gestion d'état réactive sans boilerplate excessif
- Interface utilisateur responsive et intuitive

---

### Conclusion

Ce projet de certification IBM (sur Coursera) atteste de ma capacité à :

1. **Concevoir** une application mobile complète de zéro
2. **Implémenter** une architecture professionnelle (MVVM)
3. **Intégrer** des packages tiers de manière appropriée
4. **Gérer** l'état et la persistance des données
5. **Produire** un code maintenable, documenté et testable

---

### Informations de Contact

**Programme** : IBM Flutter and Dart Mobile Apps Development for iOS and Android  
**Type** : Projet final de certification  
**Année** : 2024-2025

---

**Développé avec Flutter** — Une codebase, deux plateformes (iOS & Android)

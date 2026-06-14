## 3.0.0

### Added
- Complete UI/UX redesign with modern Material Design 3 principles.
- Smooth month transition animations with scale and fade effects.
- Gradient backgrounds for selected and today dates.
- Swipe gestures for month navigation (left/right swipe).
- Year skip navigation buttons (double arrows for ±1 year).
- Card-style calendar container with rounded corners and elevation shadow.
- Tooltip support for dates (prepares for holiday features).
- Responsive dialog with improved mobile/desktop layouts.
- Google Fonts Poppins integration for better typography.
- Visual feedback with animated containers on date selection.

### Changed
- **Breaking:** Converted all calendar tables from StatelessWidget to StatefulWidget.
- **Breaking:** Updated dialog styling from AlertDialog to custom Dialog with rounded corners.
- **Breaking:** Replaced table-based calendar layout with modern GridView.builder.
- Enhanced visual hierarchy with dividers and improved spacing.
- Improved Sunday/Friday highlighting with distinct colors (red for special days).
- Modernized navigation buttons with Material InkWell effects.
- Updated today header with gradient background and tap-to-jump functionality.
- Streamlined OK/Cancel buttons with consistent styling across all calendars.
- Calendar now auto-closes when selecting date (configurable behavior).

### Fixed
- Fixed Ethiopian calendar Sunday detection (now correctly identifies Sunday as 1).
- Fixed Hijri calendar Friday detection for holy day highlighting.
- Fixed month navigation edge cases (year boundaries).
- Fixed overflow issues on small screen devices.
- Fixed year range validation for disabled dates.

### Removed
- Removed internal holiday logic (now handled externally if needed).
- Removed legacy dropdown-based month navigation.
- Removed old table-based grid system.

### Upgrade Notes
- All calendar widgets now require StatefulWidget implementation.
- Custom dialog styling may affect existing implementations.
- Migration recommended for better UX and modern design.
## 2.3.0
### Added
- New responsive month navigation with arrow buttons
- Year dropdown now separated from month navigation
- Month names can now be truncated with ellipsis on small screens
- Added Material Design arrow buttons with ripple effect

### Changed
- Replaced month dropdown with arrow-based month navigation
- Improved layout: Year dropdown on first row, month navigation on second row
- Month names now use Flexible widget to prevent overflow
- Year always remains fully visible while month name can be truncated

### Fixed
- Fixed overflow issues on small screen devices
- Improved touch targets for month navigation arrows

## 2.2.0
- Make month names as Dropdown

## 2.1.6
- update month name

## 2.1.5
- update month selector

## 2.1.4
- remove asset

## 2.1.3
- update screenshot

## 2.1.2
- dart formated

## 2.1.1
- use initial initialVaulue instead of value
- make selected date in bigger circle

## 2.1.0
- code refactor
- make selected code to be shown in circle

## 2.0.2
- follow dart formattng

## 2.0.1
- Fix Screenshots (use )

## 2.0.0
### Added
- New screenshot images for Amharic, Arabic, and English date pickers.
- Refactored localization logic (`app_localizations.dart` and `localization_service.dart`).
- Cleaned up unnecessary braces in string interpolation.
- Added support for multi-platform localization (Windows, macOS, Linux).

### Changed
- Updated structure of date picker widgets.

### Fixed
- Bug fixes and performance improvements.

## 1.1.3
- Fix documentation

## 1.1.2
- Fix bug in README

## 1.1.1
- Centering Month year selecter
- Show full name of ethiopian months

## 1.1.0
- Responsive for small screen device
- Customize some layout

## 1.0.0
- ✅ Unified calendar picker for Gregorian, Hijri, and Ethiopian
- 🖼️ Added screenshots and fully custom dialogs
- ♻️ Cleaned up file structure
- 📦 Ready for release
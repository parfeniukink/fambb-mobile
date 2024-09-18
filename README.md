# Family Budget Bot Mobile Application

**in progress...**

## 🌲 Widgets Tree

_About_

There is a menu in botton of the screen. It represents main pages that you can vavigate through. Each page encapsulates nested or/and other pages references, shared widgets, etc.

_UI components tree_

- Pages

  - `RootPage` - hidden

  - `HomePage` - encapsulates `EquitySection`, `LastTransactionsSection`

    - `EquitySection`
    - `LastTransactionsSection`
    - `OperationsSection`
      - `AddIncomeButton`
        - `CreateIncomeForm`
      - `AddCostButton` - create `Cost` form
        - `CreateCostForm`
      - `ExchangeButton` - create `Exchange` form
        - `CreateExchangeForm`

  - `AnalyticsPage`

    - `BasicAnalyticsSection`, ...

  - `ShortcutsPage`

    - `CreateShortcutButton` - on top. rerect
      - `CreateShortcutForm`

  - `SettingsPage`
    - `SettingsListSection` - https://api.flutter.dev/flutter/cupertino/CupertinoListSection-class.html

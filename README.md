EN
### PowerShell Script Documentation for Realistic Mouse Movement and Sleep Prevention

This PowerShell script provides realistic mouse cursor movement across the entire screen (including multiple monitors) and prevents Windows from going to sleep.

**Script Components:**

1. **Definition of `Mouse` and `StayAwake` classes:**
   - The `Mouse` class provides the `SetCursorPos` method to set the cursor position and other methods to simulate clicks.
   - The `StayAwake` class uses the `SetThreadExecutionState` function to prevent Windows from going to sleep.

2. **`Get-ScreenResolution` function:**
   - Gets the dimensions of the entire desktop, including multiple monitors, using the `GetSystemMetrics` API.
   - Returns an object containing the width, height, and position (top-left corner).

3. **Function `Move-Cursor-Smooth`:**
   - Performs smooth mouse movement between two points with random pauses (1-5 ms).
   - Parameters:
   - `$startX`, `$startY`: Starting coordinates.
   - `$endX`, `$endY`: Destination coordinates.
   - `$steps`: Number of steps to interpolate between points (default: 60).

4. **Function `Prevent-Sleep`:**
   - Calls `SetThreadExecutionState` to prevent Windows from going to sleep.

5. **Function `Get-CursorPosition`:**
   - Gets the current cursor position using the `GetCursorPos` API.

6. **Function `Generate-RandomPosition`:**
   - Generates random coordinates within a specified range:
   - `$minX`, `$maxX`: Range for X coordinate.
   - `$minY`, `$maxY`: Range for Y coordinate.

7. **Main loop:**
   - All functions are called in an infinite loop:
      1. Prevent sleep by calling `Prevent-Sleep`.
      2. Get current cursor position via `Get-CursorPosition`.
      3. Generate random target position via `Generate-RandomPosition`.
      4. Move cursor to target position smoothly via `Move-Cursor-Smooth`.
      5. Pause between moves (500-1500 ms).

#### **Key Features and Methods:**

1. **Realistic Mouse Movement:**
   - The script interpolates the movement between points and adds subtle pauses to make the movement look natural.

2. **Multi-Monitor Support:**
   - The script takes into account the total resolution of the desktop, including multiple monitors.

3. **Sleep Prevention:**
   - Using the `SetThreadExecutionState` function ensures that the system remains active even without user interaction.

#### **Using the script:**

1. Open PowerShell with administrator privileges.
2. Save the script to a file (e.g. `MouseMovement.ps1`).
3. Run the script using:

   'powershell -ExecutionPolicy Bypass -File "C:\path\to\file\MouseMovement.ps1'

#### **Customization:**

- **Movement speed:**
   - By increasing or decreasing the `$steps` value in the `Move-Cursor-Smooth` function.

- **Movement range:**
   - You can change the `$minX`, `$maxX`, `$minY`, `$maxY` values.

- **Pauses between movements:**
   - By adjusting the range in `Start-Sleep -Milliseconds (Get-Random -Minimum 500 -Maximum 1500)`.

#### **Notes:**

- The script is optimized for Windows.
- It uses native operating system functions, so no external software tools are required.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

SK
### Dokumentácia k PowerShell skriptu na realistický pohyb myši a prevenciu spánku

Tento PowerShell skript zabezpečuje realistický pohyb kurzora myši na celé obrazovke (vrátane viacerých monitorov) a zabraňuje prechodu systému Windows do spánku.

**Komponenty skriptu:**

1. **Definícia tried `Mouse` a `StayAwake`:**
   - Trieda `Mouse` poskytuje metódu `SetCursorPos` na nastavenie pozície kurzora a ďalšie metódy pre simuláciu kliknutí.
   - Trieda `StayAwake` používa funkciu `SetThreadExecutionState`, ktorá zabraňuje prechodu systému Windows do režimu spánku.

2. **Funkcia `Get-ScreenResolution`:**
   - Získa rozmery celej pracovnej plochy vrátane viacerých monitorov pomocou API `GetSystemMetrics`.
   - Vracia objekt obsahujúci šírku, výšku, a pozíciu (ľavý horný roh).

3. **Funkcia `Move-Cursor-Smooth`:**
   - Realizuje plynulý pohyb myši medzi dvoma bodmi s náhodnými pauzami (1-5 ms).
   - Parametre:
     - `$startX`, `$startY`: Počiatočné súradnice.
     - `$endX`, `$endY`: Cieľové súradnice.
     - `$steps`: Počet krokov na interpoláciu medzi bodmi (predvolené: 60).

4. **Funkcia `Prevent-Sleep`:**
   - Volá `SetThreadExecutionState` na zabránenie prechodu Windows do spánku.

5. **Funkcia `Get-CursorPosition`:**
   - Získa aktuálnu pozíciu kurzora pomocou API `GetCursorPos`.

6. **Funkcia `Generate-RandomPosition`:**
   - Generuje náhodné súradnice v určenom rozsahu:
     - `$minX`, `$maxX`: Rozsah pre súradnicu X.
     - `$minY`, `$maxY`: Rozsah pre súradnicu Y.

7. **Hlavný cyklus:**
   - Všetky funkcie sa volajú v nekonečnom cykle:
     1. Zabráni spánku volaním `Prevent-Sleep`.
     2. Získa aktuálnu pozíciu kurzora cez `Get-CursorPosition`.
     3. Vygeneruje náhodnú cieľovú pozíciu pomocou `Generate-RandomPosition`.
     4. Plynulo presunie kurzor na cieľovú pozíciu pomocou `Move-Cursor-Smooth`.
     5. Pauza medzi pohybmi (500-1500 ms).

#### **Kľúčové funkcie a metódy:**

1. **Realistický pohyb myši:**
   - Skript interpoluje pohyb medzi bodmi a pridáva jemné pauzy, aby pohyb vyzeral prirodzene.

2. **Podpora viac monitorov:**
   - Skript zohľaduje celkové rozlíšenie pracovnej plochy vrátane viacerých monitorov.

3. **Prevencia spánku:**
   - Použitie funkcie `SetThreadExecutionState` zabezpečuje, že systém zostane aktívny aj bez činnosti užívateľa.

#### **Použitie skriptu:**

1. Otvorte PowerShell s oprávneniami administrátora.
2. Uložte skript do súboru (napr. `MouseMovement.ps1`).
3. Spustite skript pomocou:
  
   'powershell -ExecutionPolicy Bypass -File "C:\cesta\k\suboru\MouseMovement.ps1'

#### **Prispôsobenie:**

- **Rýchlosť pohybu:**
  - Zvýšením alebo zmenšením hodnoty `$steps` vo funkcii `Move-Cursor-Smooth`.

- **Rozsah pohybu:**
  - Môžete zmeniť hodnoty `$minX`, `$maxX`, `$minY`, `$maxY`.

- **Pauzy medzi pohybmi:**
  - Upravením rozsahu v `Start-Sleep -Milliseconds (Get-Random -Minimum 500 -Maximum 1500)`.

#### **Poznámky:**

- Skript je optimalizovaný pre Windows.
- Používa natívne funkcie operačného systému, preto nie je potrebné žiadne externé softvérové nástroje.


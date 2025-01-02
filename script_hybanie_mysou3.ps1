Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class Mouse {
    [DllImport("user32.dll")]
    public static extern bool SetCursorPos(int X, int Y);
    [DllImport("user32.dll")]
    public static extern void mouse_event(int dwFlags, int dx, int dy, int cButtons, int dwExtraInfo);
    public const int MOUSEEVENTF_LEFTDOWN = 0x02;
    public const int MOUSEEVENTF_LEFTUP = 0x04;
    public static void LeftClick(int x, int y) {
        SetCursorPos(x, y);
        mouse_event(MOUSEEVENTF_LEFTDOWN, x, y, 0, 0);
        mouse_event(MOUSEEVENTF_LEFTUP, x, y, 0, 0);
    }
}

public class StayAwake {
    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern uint SetThreadExecutionState(uint esFlags);

    public const uint ES_CONTINUOUS = 0x80000000;
    public const uint ES_DISPLAY_REQUIRED = 0x00000002;
    public const uint ES_SYSTEM_REQUIRED = 0x00000001;

    public static void PreventSleep() {
        SetThreadExecutionState(ES_CONTINUOUS | ES_DISPLAY_REQUIRED | ES_SYSTEM_REQUIRED);
    }
}
"@

# Function to get screen resolution including multiple monitors - Funkcia na získanie rozlíšenia obrazovky vrátane viacerých monitorov
function Get-ScreenResolution {
    Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class Screen {
        [DllImport("user32.dll")]
        public static extern int GetSystemMetrics(int nIndex);

        public static int GetScreenWidth() {
            return GetSystemMetrics(78); // SM_CXVIRTUALSCREEN
        }

        public static int GetScreenHeight() {
            return GetSystemMetrics(79); // SM_CYVIRTUALSCREEN
        }

        public static int GetScreenLeft() {
            return GetSystemMetrics(76); // SM_XVIRTUALSCREEN
        }

        public static int GetScreenTop() {
            return GetSystemMetrics(77); // SM_YVIRTUALSCREEN
        }
    }
"@
    return @{
        Width  = [Screen]::GetScreenWidth()
        Height = [Screen]::GetScreenHeight()
        Left   = [Screen]::GetScreenLeft()
        Top    = [Screen]::GetScreenTop()
    }
}

# Smooth cursor movement function - Funkcia na plynulý pohyb kurzora
function Move-Cursor-Smooth {
    param (
        [int]$startX,
        [int]$startY,
        [int]$endX,
        [int]$endY,
        [int]$steps = 60
    )
    $deltaX = ($endX - $startX) / $steps
    $deltaY = ($endY - $startY) / $steps

    for ($i = 1; $i -le $steps; $i++) {
        $currentX = [math]::Round($startX + ($deltaX * $i))
        $currentY = [math]::Round($startY + ($deltaY * $i))
        [Mouse]::SetCursorPos($currentX, $currentY)
        Start-Sleep -Milliseconds (Get-Random -Minimum 1 -Maximum 5)
    }
}

# Sleep prevention function - Funkcia na zabránenie režimu spánku
function Prevent-Sleep {
    [StayAwake]::PreventSleep()
}

# Function to get the current cursor position - Funkcia na získanie aktuálnej polohy kurzora
function Get-CursorPosition {
    Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class CursorPosition {
        [StructLayout(LayoutKind.Sequential)]
        public struct POINT {
            public int X;
            public int Y;
        }

        [DllImport("user32.dll")]
        public static extern bool GetCursorPos(out POINT lpPoint);

        public static POINT GetPosition() {
            POINT point;
            GetCursorPos(out point);
            return point;
        }
    }
"@
    $point = [CursorPosition]::GetPosition()
    return @{ X = $point.X; Y = $point.Y }
}

# Generating random coordinates across the entire screen - Generovanie náhodných súradníc v rámci celej obrazovky
function Generate-RandomPosition {
    param (
        [int]$minX,
        [int]$maxX,
        [int]$minY,
        [int]$maxY
    )
    $x = Get-Random -Minimum $minX -Maximum $maxX
    $y = Get-Random -Minimum $minY -Maximum $maxY
    return @{ X = $x; Y = $y }
}

# Getting the overall screen resolution - Získanie celkového rozlíšenia obrazovky
$screen = Get-ScreenResolution
$minX = $screen.Left
$maxX = $screen.Left + $screen.Width
$minY = $screen.Top
$maxY = $screen.Top + $screen.Height

# Infinite loop for realistic cursor movement - Nekonečný cyklus na realistický pohyb kurzora
while ($true) {
    Prevent-Sleep

    # Get the current cursor position - Získanie aktuálnej pozície kurzora
    $currentPosition = Get-CursorPosition

    # Generating a random target position - Generovanie náhodnej cieľovej pozície
    $targetPosition = Generate-RandomPosition -minX $minX -maxX $maxX -minY $minY -maxY $maxY

    # Smooth mouse movement - Plynulý pohyb myši
    Move-Cursor-Smooth -startX $currentPosition.X -startY $currentPosition.Y `
                       -endX $targetPosition.X -endY $targetPosition.Y `
                       -steps (Get-Random -Minimum 50 -Maximum 100)

    # Random pause between movements - Náhodná pauza medzi pohybmi
    Start-Sleep -Milliseconds (Get-Random -Minimum 500 -Maximum 1500)
}

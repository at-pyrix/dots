# dots

There are the configuration files for my KDE Plasma setup as featured on [Reddit](https://www.reddit.com/r/unixporn/comments/1g5im30/kde_plasma_minimalist_monochrome_because_color_is/).

|            |            |
|------------|------------|
| ![1](https://i.imgur.com/bcZbSTr.png) | ![2](https://i.imgur.com/QrZU29g.png) |
| ![3](https://i.imgur.com/FXnsKEo.png) | ![4](https://i.imgur.com/KY3s0MB.png) |
| ![5](https://i.imgur.com/8L21bdn.png) | ![6](https://i.imgur.com/tHCXoKp.png) |

## ✅ Installation

### 👉🏻 Method-1: Copying dotfiles

> [!NOTE]
> Make a backup of your `~` directory first!

   ```
   git clone https://github.com/at-pyrix/dots/
   cd dots
   cp -r ./*  ~
   ``` 


### 👉🏻 Method-2: Using Konsave

First of all, download this [konsave config](https://mega.nz/file/F79WDCaS#Ywmar72a-wkqZ4pgAiTe9p0L3kI73kXI64lTSYqdsmA).

1. Install [konsave](https://github.com/Prayag2/konsave)
2. Fire up a terminal, type `konsave -i "/path/to/black.knsv"`
3. Check if "black" appears in `konsave -l`.
4. Type `konsave -a black` to apply the theme.
5. Restart your computer.

### 🌎 Firefox

   1. Copy the two files inside `firefox/chrome-black` (`userChrome.css` & `userContent.css`)
   2. Open up Firefox. In the address bar, type `about:profiles`. Look for the one that says "This is the profile in use and it cannot be deleted.". Now click the "Open Directory" button (Root Directory).
   3. Create folder named `chrome`.
   4. Inside the `chrome` folder, paste the two files which we've copied.
   5. Restart Firefox.

## 👀 Screenshot Meta

### Running apps

- Konsole
- Firefox
- Dolphin

### Terminal utilities

- zsh
- unimatrix
- pipes.sh
- neofetch

### KDE

- **Application style:** Breeze
- **Plasma Style:** Breeze
- **Window Decorations:** Breeze
- **Icons:** Tela circle black dark
- **Cursor**: Dracula
- **Login Screen (SDDM):** [Where is my SDDM theme?](https://github.com/stepanzubkov/where-is-my-sddm-theme)

### Other

[Wallpaper](wallpaper.png)

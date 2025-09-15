use super::MOD_KEY;
use super::TERMINAL;
use pinnacle_api::input;
use pinnacle_api::input::Bind;
use pinnacle_api::input::Keysym;
use pinnacle_api::input::Mod;
use pinnacle_api::process::Command;
use pinnacle_api::snowcap;
use pinnacle_api::util::Direction;
use pinnacle_api::window;

struct WindowFocus {
    key: char,
    direction: Direction,
}

impl WindowFocus {
    fn register(self) {
        let Self { key, direction } = self;
        input::keybind(MOD_KEY, key)
            .on_press(move || {
                if let Some(closest) = window::get_focused()
                    .map(|x| x.in_direction(direction))
                    .and_then(|mut x| x.next())
                {
                    closest.set_focused(true);
                }
            })
            .group("Move window focus")
            .description(format!("move focus to {direction:#?} window"));
    }

    fn register_all() {
        [
            WindowFocus {
                key: 'h',
                direction: Direction::Left,
            },
            WindowFocus {
                key: 'l',
                direction: Direction::Right,
            },
            WindowFocus {
                key: 'j',
                direction: Direction::Down,
            },
            WindowFocus {
                key: 'k',
                direction: Direction::Up,
            },
        ]
        .into_iter()
        .for_each(|x| x.register());
    }
}

pub fn keybinds() {
    input::keybind(MOD_KEY, '/')
        .on_press(|| {
            snowcap::BindOverlay::new().show();
        })
        .group("Compositor")
        .description("Show the bindings overlay");

    input::keybind(MOD_KEY | Mod::SHIFT, 'q')
        .set_as_quit()
        .group("Compositor")
        .description("Quit Pinnacle");

    {
        // `mod_key + shift + q` shows the quit prompt
        input::keybind(MOD_KEY | Mod::SHIFT, 'q')
            .on_press(|| {
                snowcap::QuitPrompt::new().show();
            })
            .group("Compositor")
            .description("Show quit prompt");

        // `mod_key + ctrl + shift + q` for the hard shutdown
        input::keybind(MOD_KEY | Mod::CTRL | Mod::SHIFT, 'q')
            .set_as_quit()
            .group("Compositor")
            .description("Quit Pinnacle without prompt");
    }

    input::keybind(MOD_KEY | Mod::SHIFT, 'r')
        .set_as_reload_config()
        .group("Compositor")
        .description("Reload the config");

    input::keybind(MOD_KEY | Mod::SHIFT, 'k')
        .on_press(|| {
            if let Some(window) = window::get_focused() {
                window.close();
            }
        })
        .group("Window")
        .description("Close the focused window");

    WindowFocus::register_all();

    input::keybind(MOD_KEY, 'p')
        .on_press(move || {
            Command::new("bemenu-run")
                .args([
                    "--center",
                    "--hp",
                    "20",
                    "--cw",
                    "2",
                    "--ch",
                    "30",
                    "--fn",
                    "'firacode 14'",
                    "--single-instance",
                    "--line-height",
                    "50",
                    "--margin",
                    "50",
                    "--border-radius",
                    "20",
                    "--border",
                    "2",
                ])
                .spawn();
        })
        .group("Process")
        .description("spawn app launcher");

    input::keybind(MOD_KEY, Keysym::Return)
        .on_press(move || {
            Command::new(TERMINAL).spawn();
        })
        .group("Process")
        .description("Spawn a terminal");

    input::keybind(MOD_KEY, 'm')
        .on_press(move || {
            Command::new("firefox").spawn();
        })
        .group("Process")
        .description("Spawn a firefox window");

    input::keybind(MOD_KEY | Mod::SHIFT, 'm')
        .on_press(move || {
            Command::new("firefox").arg("--private-window").spawn();
        })
        .group("Process")
        .description("Spawn a firefox window");

    // `mod_key + ctrl + space` toggles floating
    input::keybind(MOD_KEY | Mod::CTRL, Keysym::space)
        .on_press(|| {
            if let Some(window) = window::get_focused() {
                window.toggle_floating();
                window.raise();
            }
        })
        .group("Window")
        .description("Toggle floating on the focused window");

    input::keybind(MOD_KEY, 'f')
        .on_press(|| {
            if let Some(window) = window::get_focused() {
                window.toggle_fullscreen();
                window.raise();
            }
        })
        .group("Window")
        .description("Toggle fullscreen on the focused window");

    input::keybind(MOD_KEY | Mod::SHIFT, 'f')
        .on_press(|| {
            if let Some(window) = window::get_focused() {
                window.toggle_maximized();
                window.raise();
            }
        })
        .group("Window")
        .description("Toggle maximized on the focused window");
}

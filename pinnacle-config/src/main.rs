use std::sync::Arc;
use std::sync::Mutex;

use pinnacle_api::experimental::snowcap_api::widget::Color;
use pinnacle_api::process::Command;
use pinnacle_api::snowcap::FocusBorder;
use pinnacle_api::{
    input::{self, Bind, Keysym, Mod, MouseButton},
    layout::{
        self, LayoutGenerator, LayoutNode, LayoutResponse,
        generators::{
            Corner, CornerLocation, Cycle, Dwindle, Fair, Floating, MasterSide, MasterStack, Spiral,
        },
    },
    output,
    signal::{OutputSignal, WindowSignal},
    tag,
    util::{Axis, Batch},
    window,
};

mod keybinds;

const MOD_KEY: Mod = Mod::SUPER;
const TERMINAL: &str = "alacritty";
const TAG_NAMES: [&str; 9] = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];

async fn config() {
    mousebinds();
    keybinds::keybinds();
    layouts();
    workspace_tags();

    Command::new("dunst").once().spawn();
    Command::new("waybar")
        .arg("-c")
        .arg("/home/eltahawy/magit/dotfiles/waybar/config")
        .once()
        .spawn();
}

fn workspace_tags() {
    // Setup all monitors with tags "1" through "9"
    output::for_each_output(move |output| {
        let mut tags = tag::add(output, TAG_NAMES);
        tags.next().unwrap().set_active(true);
    });

    for tag_name in TAG_NAMES {
        // `mod_key + 1-9` switches to tag "1" to "9"
        input::keybind(MOD_KEY, tag_name)
            .on_press(move || {
                if let Some(tag) = tag::get(tag_name) {
                    tag.switch_to();
                }
            })
            .group("Tag")
            .description(format!("Switch to tag {tag_name}"));

        // `mod_key + ctrl + 1-9` toggles tag "1" to "9"
        input::keybind(MOD_KEY | Mod::CTRL, tag_name)
            .on_press(move || {
                if let Some(tag) = tag::get(tag_name) {
                    tag.toggle_active();
                }
            })
            .group("Tag")
            .description(format!("Toggle tag {tag_name}"));

        // `mod_key + shift + 1-9` moves the focused window to tag "1" to "9"
        input::keybind(MOD_KEY | Mod::SHIFT, tag_name)
            .on_press(move || {
                if let Some(tag) = tag::get(tag_name)
                    && let Some(win) = window::get_focused()
                {
                    win.move_to_tag(&tag);
                }
            })
            .group("Tag")
            .description(format!("Move the focused window to tag {tag_name}"));

        // `mod_key + ctrl + shift + 1-9` toggles tag "1" to "9" on the focused window
        input::keybind(MOD_KEY | Mod::CTRL | Mod::SHIFT, tag_name)
            .on_press(move || {
                if let Some(tg) = tag::get(tag_name)
                    && let Some(win) = window::get_focused()
                {
                    win.toggle_tag(&tg);
                }
            })
            .group("Tag")
            .description(format!("Toggle tag {tag_name} on the focused window"));
    }

    input::libinput::for_each_device(|device| {
        // Enable natural scroll for touchpads
        if device.device_type().is_touchpad() {
            device.set_natural_scroll(true);
        }
    });

    for win in window::get_all() {
        decorate_window(&win);
    }

    window::add_window_rule(move |win| {
        match win.app_id().as_str() {
            TERMINAL | "Mozilla Firefox" => {
                win.set_maximized(true);
            }
            "Picture-in-Picture" => {
                win.set_floating(true);
            }
            _ => (),
        }
        win.set_decoration_mode(window::DecorationMode::ServerSide);
        decorate_window(&win);
    });

    // Enable sloppy focus
    window::connect_signal(WindowSignal::PointerEnter(Box::new(|win| {
        win.set_focused(true);
    })));

    // Focus outputs when the pointer enters them
    output::connect_signal(OutputSignal::PointerEnter(Box::new(|output| {
        output.focus();
    })));

    if let Some(error) = pinnacle_api::pinnacle::take_last_error() {
        // Show previous crash messages
        pinnacle_api::snowcap::ConfigCrashedMessage::new(error).show();
    } else {
        // Or show the bind overlay on startup
        pinnacle_api::snowcap::BindOverlay::new().show();
    }
}

fn decorate_window(win: &window::WindowHandle) {
    let mut fb = FocusBorder::new(win);
    fb.focused_color = Color::rgba(153., 255., 119., 0.69);
    fb.thickness = 4;
    fb.unfocused_color = Color::rgba(165., 138., 141., 0.19);
    fb.decorate();
}

// Pinnacle supports a tree-based layout system built on layout nodes.
//
// To determine the tree used to layout windows, Pinnacle requests your config for a tree data structure
// with nodes containing gaps, directions, etc. There are a few provided utilities for creating
// a layout, known as layout generators.
//
// ### Layout generators ###
// A layout generator is a table that holds some state as well as
// the `layout` function, which takes in a window count and computes
// a tree of layout nodes that determines how windows are laid out.
//
// There are currently six built-in layout generators, one of which delegates to other
// generators as shown below.
fn layouts() {
    fn into_box<'a, T: LayoutGenerator + Send + 'a>(
        generator: T,
    ) -> Box<dyn LayoutGenerator + Send + 'a> {
        Box::new(generator) as _
    }

    // Create a cycling layout generator that can cycle between layouts on different tags.
    let cycler = Arc::new(Mutex::new(Cycle::new([
        into_box(MasterStack::default()),
        into_box(MasterStack {
            master_side: MasterSide::Right,
            ..Default::default()
        }),
        into_box(MasterStack {
            master_side: MasterSide::Top,
            ..Default::default()
        }),
        into_box(MasterStack {
            master_side: MasterSide::Bottom,
            ..Default::default()
        }),
        into_box(Dwindle::default()),
        into_box(Spiral::default()),
        into_box(Corner::default()),
        into_box(Corner {
            corner_loc: CornerLocation::TopRight,
            ..Default::default()
        }),
        into_box(Corner {
            corner_loc: CornerLocation::BottomLeft,
            ..Default::default()
        }),
        into_box(Corner {
            corner_loc: CornerLocation::BottomRight,
            ..Default::default()
        }),
        into_box(Fair::default()),
        into_box(Fair {
            axis: Axis::Horizontal,
            ..Default::default()
        }),
        into_box(Floating::default()),
    ])));

    // Use the cycling layout generator to manage layout requests.
    // This returns a layout requester that allows you to request layouts manually.
    let layout_requester = layout::manage({
        let cycler = cycler.clone();
        move |args| {
            let Some(tag) = args.tags.first() else {
                return LayoutResponse {
                    root_node: LayoutNode::new(),
                    tree_id: 0,
                };
            };

            let mut cycler = cycler.lock().unwrap();
            cycler.set_current_tag(tag.clone());

            let root_node = cycler.layout(args.window_count);
            let tree_id = cycler.current_tree_id();
            LayoutResponse { root_node, tree_id }
        }
    });

    // `mod_key + space` cycles to the next layout
    input::keybind(MOD_KEY, Keysym::space)
        .on_press({
            let cycler = cycler.clone();
            let requester = layout_requester.clone();
            move || {
                let Some(focused_op) = output::get_focused() else {
                    return;
                };
                let Some(first_active_tag) = focused_op
                    .tags()
                    .batch_find(|tag| Box::pin(tag.active_async()), |active| *active)
                else {
                    return;
                };

                cycler
                    .lock()
                    .unwrap()
                    .cycle_layout_forward(&first_active_tag);
                requester.request_layout_on_output(&focused_op);
            }
        })
        .group("Layout")
        .description("Cycle the layout forward");

    // `mod_key + shift + space` cycles to the previous layout
    input::keybind(MOD_KEY | Mod::SHIFT, Keysym::space)
        .on_press(move || {
            let Some(focused_op) = output::get_focused() else {
                return;
            };
            let Some(first_active_tag) = focused_op
                .tags()
                .batch_find(|tag| Box::pin(tag.active_async()), |active| *active)
            else {
                return;
            };

            cycler
                .lock()
                .unwrap()
                .cycle_layout_backward(&first_active_tag);
            layout_requester.request_layout_on_output(&focused_op);
        })
        .group("Layout")
        .description("Cycle the layout backward");
}

fn mousebinds() {
    // `mod_key + left click` starts moving a window
    input::mousebind(MOD_KEY, MouseButton::Left)
        .on_press(|| {
            window::begin_move(MouseButton::Left);
        })
        .group("Mouse")
        .description("Start an interactive window move");

    // `mod_key + right click` starts resizing a window
    input::mousebind(MOD_KEY, MouseButton::Right)
        .on_press(|| {
            window::begin_resize(MouseButton::Right);
        })
        .group("Mouse")
        .description("Start an interactive window resize");
}

pinnacle_api::main!(config);

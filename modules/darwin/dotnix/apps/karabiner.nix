{
  config,
  pkgs-unstable,
  pkgs,
  lib,
  dotnix-utils,
  ...
}: let
  default_profile = {
    name = "Default profile";
    devices = [
      {
        ignore = false;
        identifiers = {
          is_game_pad = false;
          is_keyboard = false;
          is_pointing_device = true;
          # Logi M650 L
          product_id = 45098;
          vendor_id = 1133;
        };
        mouse_flip_vertical_wheel = true;
      }
      {
        ignore = false;
        identifiers = {
          is_game_pad = false;
          is_keyboard = false;
          is_pointing_device = true;
          # Logi M650 L
          product_id = 50504;
          vendor_id = 1133;
        };
        mouse_flip_vertical_wheel = true;
      }
      {
        ignore = false;
        identifiers = {
          is_game_pad = false;
          is_keyboard = false;
          is_pointing_device = true;
          # Logi M650 L
          product_id = 45108;
          vendor_id = 1133;
        };
        mouse_flip_vertical_wheel = true;
      }
      {
        disable_built_in_keyboard_if_exists = true;
        fn_function_keys = [];
        game_pad_swap_sticks = false;
        identifiers = {
          is_game_pad = false;
          is_keyboard = true;
          is_pointing_device = false;
          # iqunix zone x75
          product_id = 20754;
          vendor_id = 12815;
        };
        ignore = false;
        manipulate_caps_lock_led = true;
        mouse_flip_horizontal_wheel = false;
        mouse_flip_vertical_wheel = false;
        mouse_flip_x = false;
        mouse_flip_y = false;
        mouse_swap_wheels = false;
        mouse_swap_xy = false;
        simple_modifications = [
          {
            from = {key_code = "left_option";};
            to = [{key_code = "left_command";}];
          }
          {
            from = {key_code = "left_command";};
            to = [{key_code = "left_option";}];
          }
          {
            from = {key_code = "right_option";};
            to = [{key_code = "right_command";}];
          }
        ];
        treat_as_built_in_keyboard = false;
      }
    ];
    fn_function_keys = [
      {
        from.key_code = "f1";
        to = [{key_code = "f1";}];
      }
      {
        from.key_code = "f2";
        to = [{key_code = "f2";}];
      }
      {
        from.key_code = "f3";
        to = [{key_code = "f3";}];
      }
      {
        from.key_code = "f4";
        to = [{key_code = "f4";}];
      }
      {
        from.key_code = "f5";
        to = [{key_code = "f5";}];
      }
      {
        from.key_code = "f6";
        to = [{key_code = "f6";}];
      }
      {
        from.key_code = "f7";
        to = [{key_code = "f7";}];
      }
      {
        from.key_code = "f8";
        to = [{key_code = "f8";}];
      }
      {
        from.key_code = "f9";
        to = [{key_code = "f9";}];
      }
      {
        from.key_code = "f10";
        to = [{key_code = "f10";}];
      }
      {
        from.key_code = "f11";
        to = [{key_code = "f11";}];
      }
      {
        from.key_code = "f12";
        to = [{key_code = "f12";}];
      }
    ];
    complex_modifications = {
      rules = [
        {
          description = "RIGHT_CMD to SUPER";
          manipulators = [
            {
              type = "basic";
              parameters = {
                "basic.to_if_held_down_threshold_milliseconds" = 10;
              };
              from = {
                key_code = "right_command";
              };
              to_if_alone = [
                {
                  key_code = "f19";
                }
              ];
              to_if_held_down = [
                {
                  key_code = "left_command";
                  modifiers = [
                    "left_shift"
                    "left_option"
                    "left_control"
                  ];
                  lazy = true;
                }
              ];
            }
          ];
          conditions = [
            {
              type = "device_if";
              identifiers = [
                {
                  vendor_id = 1452;
                }
              ];
            }
          ];
        }
        {
          description = "CAPS_LOCK to CTRL";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "caps_lock";
              };
              to = [
                {
                  key_code = "left_control";
                }
              ];
            }
          ];
        }
        {
          description = "ALT+E: layout bsp";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "e";
                modifiers = {
                  mandatory = [
                    "left_option"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m space --layout bsp";
                }
              ];
            }
          ];
        }
        {
          description = "ALT+f: layout float";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "f";
                modifiers = {
                  mandatory = [
                    "left_option"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m space --layout float";
                }
              ];
            }
          ];
        }
        {
          description = "ALT+S: layout stack";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "s";
                modifiers = {
                  mandatory = [
                    "left_option"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m space --layout stack";
                }
              ];
            }
          ];
        }
        {
          description = "SUPER+tab: next window in stack";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "tab";
                modifiers = {
                  mandatory = [
                    "left_command"
                    "left_shift"
                    "left_option"
                    "left_control"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m window --focus stack.next || ${pkgs-unstable.yabai}/bin/yabai -m window --focus stack.first";
                }
              ];
            }
          ];
        }
        {
          description = "SUPER+h: Focus left";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "h";
                modifiers = {
                  mandatory = [
                    "left_command"
                    "left_shift"
                    "left_option"
                    "left_control"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m window --focus west";
                }
              ];
            }
          ];
        }
        {
          description = "SUPER+j: Focus down";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "j";
                modifiers = {
                  mandatory = [
                    "left_command"
                    "left_shift"
                    "left_option"
                    "left_control"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m window --focus south";
                }
              ];
            }
          ];
        }
        {
          description = "SUPER+k: Focus up";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "k";
                modifiers = {
                  mandatory = [
                    "left_command"
                    "left_shift"
                    "left_option"
                    "left_control"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m window --focus north";
                }
              ];
            }
          ];
        }
        {
          description = "SUPER+l: Focus right";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "l";
                modifiers = {
                  mandatory = [
                    "left_command"
                    "left_shift"
                    "left_option"
                    "left_control"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m window --focus east";
                }
              ];
            }
          ];
        }
        {
          description = "SUPER+w: Close current space";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "w";
                modifiers = {
                  mandatory = [
                    "left_command"
                    "left_shift"
                    "left_option"
                    "left_control"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m space --destroy";
                }
              ];
            }
          ];
        }
        {
          description = "ALT+1: Switch to space 1";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "1";
                modifiers = {
                  mandatory = [
                    "left_option"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m space --focus 1";
                }
              ];
            }
          ];
        }
        {
          description = "ALT+2: Switch to space 2";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "2";
                modifiers = {
                  mandatory = [
                    "left_option"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m space --focus 2";
                }
              ];
            }
          ];
        }
        {
          description = "ALT+3: Switch to space 3";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "3";
                modifiers = {
                  mandatory = [
                    "left_option"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m space --focus 3";
                }
              ];
            }
          ];
        }
        {
          description = "ALT+4: Switch to space 4";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "4";
                modifiers = {
                  mandatory = [
                    "left_option"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m space --focus 4";
                }
              ];
            }
          ];
        }
        {
          description = "ALT+5: Switch to space 5";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "5";
                modifiers = {
                  mandatory = [
                    "left_option"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m space --focus 5";
                }
              ];
            }
          ];
        }
        {
          description = "ALT+6: Switch to space 6";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "6";
                modifiers = {
                  mandatory = [
                    "left_option"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m space --focus 6";
                }
              ];
            }
          ];
        }
        {
          description = "ALT+r: Switch to rencent space";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "r";
                modifiers = {
                  mandatory = [
                    "left_option"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m space --focus recent";
                }
              ];
            }
          ];
        }
        {
          description = "CMD+SHIFT+1: Send current window to space 1";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "1";
                modifiers = {
                  mandatory = [
                    "left_command"
                    "left_shift"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m window --space 1";
                }
              ];
            }
          ];
        }
        {
          description = "CMD+SHIFT+2: Send current window to space 2";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "2";
                modifiers = {
                  mandatory = [
                    "left_command"
                    "left_shift"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m window --space 2";
                }
              ];
            }
          ];
        }
        {
          description = "CMD+SHIFT+3: Send current window to space 3";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "3";
                modifiers = {
                  mandatory = [
                    "left_command"
                    "left_shift"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m window --space 3";
                }
              ];
            }
          ];
        }
        {
          description = "CMD+SHIFT+4: Send current window to space 4";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "4";
                modifiers = {
                  mandatory = [
                    "left_command"
                    "left_shift"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m window --space 4";
                }
              ];
            }
          ];
        }
        {
          description = "CMD+SHIFT+5: Send current window to space 5";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "5";
                modifiers = {
                  mandatory = [
                    "left_command"
                    "left_shift"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m window --space 5";
                }
              ];
            }
          ];
        }
        {
          description = "CMD+SHIFT+6: Send current window to space 6";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "6";
                modifiers = {
                  mandatory = [
                    "left_command"
                    "left_shift"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m window --space 6";
                }
              ];
            }
          ];
        }
        {
          description = "CMD+SHIFT+z: Send current window to next space";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "z";
                modifiers = {
                  mandatory = [
                    "left_command"
                    "left_shift"
                  ];
                };
              };
              to = [
                {
                  shell_command = "${pkgs-unstable.yabai}/bin/yabai -m window --space next";
                }
              ];
            }
          ];
        }
        {
          description = "SUPER+n: Send current window to a new desktop";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "n";
                modifiers = {
                  mandatory = [
                    "left_command"
                    "left_shift"
                    "left_option"
                    "left_control"
                  ];
                };
              };
              to = [
                {
                  shell_command = ''
                    ${pkgs-unstable.yabai}/bin/yabai -m space --create && index="$(${pkgs-unstable.yabai}/bin/yabai -m query --spaces --display | ${pkgs.jq}/bin/jq '.| length')" && ${pkgs-unstable.yabai}/bin/yabai -m window --space "''${index}" && ${pkgs-unstable.yabai}/bin/yabai -m space --focus "''${index}" && ${pkgs-unstable.yabai}/bin/yabai -m space --layout bsp
                  '';
                }
              ];
            }
          ];
        }
        {
          description = "Double tap right shift to send f18";
          manipulators = [
            {
              type = "basic";
              conditions = [
                {
                  name = "right_shift_pressed";
                  type = "variable_if";
                  value = 1;
                }
              ];
              from = {
                key_code = "right_shift";
                modifiers.optional = ["any"];
              };
              to = [
                {
                  key_code = "right_shift";
                }
              ];
              to_if_alone = [
                {
                  key_code = "f18";
                }
                {
                  set_variable = {
                    name = "right_shift_pressed";
                    value = 0;
                  };
                }
              ];
              parameters = {
                "basic.to_if_alone_timeout_milliseconds" = 500;
              };
            }
            {
              type = "basic";
              from = {
                key_code = "right_shift";
                modifiers.optional = ["any"];
              };
              to = [
                {
                  key_code = "right_shift";
                }
              ];
              to_if_alone = [
                {
                  set_variable = {
                    name = "right_shift_pressed";
                    value = 1;
                  };
                }
                {
                  key_code = "right_shift";
                }
              ];
              to_delayed_action = {
                to_if_invoked = [
                  {
                    set_variable = {
                      name = "right_shift_pressed";
                      value = 0;
                    };
                  }
                ];
                to_if_canceled = [
                  {
                    set_variable = {
                      name = "right_shift_pressed";
                      value = 0;
                    };
                  }
                ];
              };
              parameters = {
                "basic.to_delayed_action_delay_milliseconds" = 500;
                "basic.to_if_alone_timeout_milliseconds" = 500;
              };
            }
          ];
        }
      ];
    };
  };
  json = {
    global = {
      ask_for_confirmation_before_quitting = true;
      check_for_updates_on_startup = false;
      show_in_menu_bar = true;
      show_profile_name_in_menu_bar = false;
      unsafe_ui = false;
    };
    profiles = [
      default_profile
    ];
  };

  cfg = config.dotnix.apps.karabiner;
in {
  options.dotnix.apps.karabiner = {
    enable = lib.mkEnableOption "Karabiner-Elements";
  };
  config = lib.mkIf cfg.enable {
    homebrew = {
      casks = ["karabiner-elements"];
    };

    home-manager = dotnix-utils.hm.hmConfig {
      xdg.configFile."karabiner/karabiner.json" = {
        text = builtins.toJSON json;
        force = true;
      };
    };
  };
}

FONTSIZE_LEVELS = [([3300, 3500], 16)]


def on_resize(boss, window, data=None):
    if getattr(boss, "font_size_multiplier", None) is None:
        boss.font_size_multiplier = 0

    if data is None:
        data = boss.cached_geometry
    else:
        boss.cached_geometry = data

    # try to show about 200 columns of text
    width = data["new_geometry"].right

    new_font_size = None
    for level in FONTSIZE_LEVELS:
        if level[0][0] < width < level[0][1]:
            new_font_size = level[1]
            break

    if new_font_size is not None:
        boss.set_font_size(new_font_size * (1 + (0.3 * boss.font_size_multiplier)))


def on_set_user_var(boss, window, data):
    if getattr(boss, "font_size_multiplier", None) is None:
        boss.font_size_multiplier = 0

    if data["key"] == "var:KITTY_ADJUST_FONT_SIZE_OFFSET":
        value = data["value"]
        if value == "up":
            boss.font_size_multiplier += 1
        elif value == "down":
            boss.font_size_multiplier -= 1

        on_resize(boss, window)


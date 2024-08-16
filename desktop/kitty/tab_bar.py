from kitty.fast_data_types import Screen, get_options
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_title, as_rgb
from kitty.utils import color_as_int

left_round = '◖'
right_round = '◗'

opts = get_options()

fg = as_rgb(color_as_int(opts.color15))
bg = as_rgb(color_as_int(opts.color0))
active_fg = as_rgb(color_as_int(opts.color1))

def draw_tab(
    draw_data: DrawData, screen: Screen, tab: TabBarData,
    before: int, max_title_length: int, index: int, is_last: bool,
    extra_data: ExtraData
) -> int:
    def _do_round(text: str):
        screen.cursor.bg = bg
        screen.cursor.fg = fg
        screen.draw(text)
        screen.cursor.bg = fg
        screen.cursor.fg = bg

    def _do_title():
        if tab.needs_attention:
            screen.draw(f'!{tab.title}!')
        else:
            screen.draw(tab.title)

    orig_fg = screen.cursor.fg
    orig_bg = screen.cursor.bg
    is_first = before == 0

    screen.cursor.bg = fg
    screen.cursor.fg = bg

    if is_first:
        screen.draw(' ')
    else:
        screen.draw('｜ ')

    if tab.is_active:
        screen.cursor.fg = active_fg
        screen.cursor.bold = True
        _do_title()
        screen.cursor.bold = False
    else:
        _do_title()

    if is_last:
        screen.draw(' ' * (screen.columns - screen.cursor.x))
    else:
        screen.draw(f' ')

    screen.cursor.bg = orig_bg
    screen.cursor.fg = orig_fg

    return screen.cursor.x

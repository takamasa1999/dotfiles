# ~/.config/kitty/tab_bar.py
"""
Custom kitty tab bar.

Layout:
  [󰙴 <session>] [tab1] [tab2] ...
   ↑ dedicated    ↑ normal powerline tabs
     session block

When index == 1 this function draws TWO powerline blocks:
  1. A compact session-name-only block (no tab title)
  2. The actual first tab

All other indices draw a single powerline block as normal.

Required kitty.conf:
  tab_bar_style       custom
  tab_powerline_style round   # or slanted
  tab_bar_min_tabs    1
"""

from kitty.fast_data_types import Screen, wcswidth
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_tab_with_powerline

# 󰙴  Nerd Fonts kitty icon (U+F39B). Replace if your font lacks Nerd Fonts.
SESSION_ICON = "󰙴"


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_tab_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    if index == 1:
        session_name = (
            tab.active_session_name
            or tab.session_name
            or "no session"
        )
        session_title = f"{SESSION_ICON} {session_name}"

        # ── Block 1: session name only ───────────────────────────────────────
        session_tab = tab._replace(
            title=session_title,
            is_active=False,   # inactive styling keeps it visually distinct
            tab_id=-1,         # synthetic — not a real tab
        )

        # next_tab for the session block is the real first tab so the
        # powerline separator colour is computed correctly.
        session_ed = ExtraData()
        session_ed.prev_tab = None
        session_ed.next_tab = tab
        session_ed.for_layout = extra_data.for_layout

        # Reserve just enough space for the session block content.
        # wcswidth gives the correct terminal display width for Unicode.
        session_max = wcswidth(session_title) + 4   # +4 for leading space, trailing space, separator
        session_end = draw_tab_with_powerline(
            draw_data, screen, session_tab,
            before, session_max, index, False, session_ed,
        )

        # ── Block 2: actual first tab ─────────────────────────────────────────
        actual_ed = ExtraData()
        actual_ed.prev_tab = session_tab
        actual_ed.next_tab = extra_data.next_tab
        actual_ed.for_layout = extra_data.for_layout

        remaining = max(1, before + max_tab_length - session_end)
        return draw_tab_with_powerline(
            draw_data, screen, tab,
            session_end, remaining, index, is_last, actual_ed,
        )

    # ── All other tabs: normal powerline ─────────────────────────────────────
    return draw_tab_with_powerline(
        draw_data, screen, tab,
        before, max_tab_length, index, is_last, extra_data,
    )

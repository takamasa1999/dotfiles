# ~/.config/kitty/tab_bar.py
"""
Custom kitty tab bar.

Renders the active session name + first tab title together inside the
first powerline block:

  [󰙴 rag-system │ editor] [server] [logs]

session_name / active_session_name are read from TabBarData
(confirmed in kitty/tab_bar.py: TabBarData.session_name and
TabBarData.active_session_name are both string fields).

Required kitty.conf:
  tab_bar_style          custom
  tab_powerline_style    round   # or slanted
  tab_bar_min_tabs       1
"""

from kitty.fast_data_types import Screen
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_tab_with_powerline

# 󰙴  — Nerd Fonts kitty icon (U+F39B).
# If your font doesn't include Nerd Fonts, replace with any text you prefer.
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
    """
    Called once per tab by kitty's TabBar.update().

    For index == 1 (first tab) we embed the active session name into the
    title so it appears inside the same powerline block as the tab title.

    For all other tabs we delegate straight to draw_tab_with_powerline.
    """

    if index == 1:
        # Prefer active_session_name (session of the focused tab) which is
        # consistent across all draw_tab calls for a single render pass.
        # Fall back to session_name (session this tab itself belongs to).
        session_name = (
            tab.active_session_name
            or tab.session_name
            or "no session"
        )

        # Compose: "󰙴 <session> │ <tab_title>"
        combined_title = f"{SESSION_ICON} {session_name} │ {tab.title}"
        modified_tab = tab._replace(title=combined_title)

        # Set active_title_template=None so it falls back to title_template
        # ("{title}").  Without this, a user-set active_tab_title_template
        # like "{session_name} {title}" would prepend the session name again,
        # producing "session  󰙴 session │ editor".
        modified_draw_data = draw_data._replace(active_title_template=None)

        return draw_tab_with_powerline(
            modified_draw_data, screen, modified_tab,
            before, max_tab_length, index, is_last, extra_data,
        )

    return draw_tab_with_powerline(
        draw_data, screen, tab,
        before, max_tab_length, index, is_last, extra_data,
    )

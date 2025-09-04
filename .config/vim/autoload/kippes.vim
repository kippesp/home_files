" kippes.vim

let s:colors = {
      \ "bright_red": { "gui": "#FF240E", "cterm": "196", "cterm16": "1" },
      \ "red": { "gui": "#FF0000", "cterm": "204", "cterm16": "1" },
      \ "dark_red": { "gui": "#BE5046", "cterm": "196", "cterm16": "9" },
      \ "column_dark_red": { "gui": "#1C0001", "cterm": "52", "cterm16": "1" },
      \
      \ "bright_yellow": { "gui": "#FFFF00", "cterm": "11", "cterm16": "11" },
      \ "butter": { "gui": "#FFFF87", "cterm": "228", "cterm16": "11" },
      \ "golden_delicious": { "gui": "#D7D787", "cterm": "186", "cterm16": "11" },
      \ "yellow": { "gui": "#F9E231", "cterm": "180", "cterm16": "3" },
      \ "yew": { "gui": "#AFAF00", "cterm": "142", "cterm16": "3" },
      \ "bright_orange": { "gui": "#FF6500", "cterm": "202", "cterm16": "9" },
      \ "dark_yellow": { "gui": "#D19A66", "cterm": "173", "cterm16": "11" },
      \
      \ "bold_bright_green": { "gui": "#00FF13", "cterm": "10", "cterm16": "10" },
      \ "plunge_pool": { "gui": "#00FFD7", "cterm": "50", "cterm16": "14" },
      \ "green": { "gui": "#00BF02", "cterm": "10", "cterm16": "2" },
      \ "terminal_green": { "gui": "#01BB05", "cterm": "28", "cterm16": "2" },
      \ "dark_green": { "gui": "#006600", "cterm": "22", "cterm16": "2" },
      \ "background_green": { "gui": "#002501", "cterm": "22", "cterm16": "0" },
      \
      \ "bright_cyan": { "gui": "#00FFFF", "cterm": "14", "cterm16": "14" },
      \ "cyan": { "gui": "#19CAB7", "cterm": "38", "cterm16": "6" },
      \ "azure": { "gui": "#0087FF", "cterm": "33", "cterm16": "4" },
      \ "blue_cola": { "gui": "#0087D7", "cterm": "32", "cterm16": "4" },
      \ "blue": { "gui": "#61AFEF", "cterm": "39", "cterm16": "4" },
      \
      \ "purple": { "gui": "#C678DD", "cterm": "170", "cterm16": "5" },
      \
      \ "status_white": { "gui": "#FFFFFF", "cterm": "15", "cterm16": "15" },
      \ "white": { "gui": "#ABB2BF", "cterm": "145", "cterm16": "15" },
      \
      \ "digital": { "gui": "#626262", "cterm": "242", "cterm16": "8" },
      \ "thunder": { "gui": "#4E4E4E", "cterm": "59", "cterm16": "7" },
      \ "special_grey": { "gui": "#3B4048", "cterm": "238", "cterm16": "7" },
      \ "cursor_grey": { "gui": "#2C323C", "cterm": "236", "cterm16": "0" },
      \ "dark_tone_ink": { "gui": "#121212", "cterm": "235", "cterm16": "0" },
      \ "black": { "gui": "#000000", "cterm": "0", "cterm16": "0" },
      \ "background": { "gui": "#000000", "cterm": "0", "cterm16": "0" },
      \}

function! kippes#GetColors()
  return s:colors
endfunction
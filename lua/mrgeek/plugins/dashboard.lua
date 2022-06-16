local present, db = pcall(require, "dashboard")

if not present then
  return
end

db.disable_statusline = 1
db.preview_file_height = 12
db.preview_file_width = 80
db.custom_header = {
  "    ▐███████████████████████████████████  ▐██████▌▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓L      ",
  "    ▐███████████████████████████████████  ███████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▀'      ",
  '    ▐██████████████████████████████████▌  ███████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▀"          ',
  '    ▐██████▀*`              `"└▀███████▌  ████████▓▓▓▓▓▀▀└^`               ',
  "    ▐██▀`     ,                   \'████L  ▀▀*\"\"\"                          ",
  "    ▐██▄-▄▄█▀   -                 ,████▄,,                                 ",
  "    ▐██████`  ▄▌                ██████████▓▓▓▀   ▄▄                        ",
  " ,╖ ▐█████Γ  ██▌         ██     ████████████   ██          ██▌  ▐▓▓▓▓ ┌┐.  ",
  "╓▓█  █████   ███▄      ,▄██     ███████████▌   ██▌        ┌██▌   ▓▓▓▌ ▓▓█▌ ",
  "▓▓█L █████▌  '████████████     ,████████████   └███▄,  .┌███▀   ⌠▓▓▓▌ ▌▓▓█▌",
  '▓▓▓▌ ██████▄   `▀▀████▀"      ,██████████████    "▀██████▀▀    ▄▓▓▓▓  ▌▓██▌',
  "▓▓▓▌ ████████,              ,▄████████████████▄,             +▓▓▓▓▓▓  ▓███ ",
  "`▓▓█ ▐██████████▄,.     ,┌▄███████████████████████▄,,,,,,≤▄▓▓▓▓▓▓▓▓▓ ▐███' ",
  "  ▓█ ▐████████████████████████████████████████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▌ ▐█▀   ",
  "   ▀  ███████████████████████████▓▓▓▓▓▓▓██████████████▓▓▓▓▓▓▓▓▓▓▓▓▓` ▓`    ",
  "      █████████████████████████ `▓▓▓▓▓▓▓▀▐████████████▓▓▓▓▓▓▓▓▓▓▓▓▓        ",
  "      ▐█████████████████████████▄.'└┘\".▄██████████████▓▓▓▓▓▓▓▓▓▓▓▓▌       ",
  "       ██████████████████████████████████████████████▌▓▓▓▓▓▓▓▓▓▓▓▓         ",
  "       ▐█████████████████████████████████████████████▓▓▓▓▓▓▓▓▓▓▓▓▌         ",
  "        ████████████████████████████████████████████▓▓▓▓▓▓▓▓▓▓▓▓▓          ",
  "         ███████████████████\"^'  `             ▓███▓▓▓▓▓▓▓▓▓▓▓▓▓Γ         ",
  "         '████████████████████████████▄▄▄▄▄▄╖╖▄██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▀           ",
  "          `███████████████████████████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓┘            ",
  '            "▀███████████████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▀"              ',
  '                ^▀▀████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▀"`                 ',
  '                      ` ^"▀▀▀▀▀▀▓▓▓▓▓▓▓▓▓▓▀▀▀▀▀╜""`                        ',
  "                                                  ,╓                       ",
  "                     +-,,,,        .,,,-,=╕▄▄▄▓▓▓▓▓▓                       ",
  "                     █████████████████████▓▓▓▓▓▓▓▓▓▓                       ",
  "                     ████████████████████▌▓▓▓▓▓▓▓▓▓▓∩                      ",
  "                     ████████████████████▓▓▓▓▓▓▓▓▓▓▓▌                      ",
  "                     ████████████████████▓▓▓▓▓▓▓▓▓▓▓▌                      ",
  "                     ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀                      ",
}

db.custom_center = {
  {
    icon = "  ",
    desc = "Recently last session                   ",
    shortcut = "SPC s l",
    action = "SessionLoad",
  },
  {
    icon = "  ",
    desc = "Recently opened files                   ",
    action = "Telescope oldfiles",
    shortcut = "SPC f o",
  },
  {
    icon = "  ",
    desc = "Find  File                              ",
    action = "Telescope find_files",
    shortcut = "SPC f f",
  },
  {
    icon = "  ",
    desc = "File Browser                            ",
    action = "Telescope file_browser",
    shortcut = "SPC f b",
  },
  {
    icon = "  ",
    desc = "Find  word                              ",
    aciton = "Telescope live_grep",
    shortcut = "SPC f w",
  }
}

db.custom_footer = {
  "   ",
}

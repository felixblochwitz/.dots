-- the lazy module import has to go first
-- Otherwise some of my config might not work, because for some of the
-- config, modules need to be loaded.
require("config.lazy")

require("config.color")
require("config.diagnostics")
require("config.options")
require("config.trans")
require("config.ui")

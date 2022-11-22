-- Global base config script   
-- IT'S NOT A GOOD IDEA TO CHANGE THINGS IN HERE UNLESS
-- YOU KNOW WHAT YOU'RE DOING, but reading this file over
-- is a good way to get to know how DSB works.

-- If you want to add new functions/variables to your
-- dungeon, it's a much better idea to put them in your
-- own dungeon's startup.lua.

-- where to put things
NORTH = 0
EAST = 1
SOUTH = 2
WEST = 3

-- flooritems and wallitems use similar location structure
NORTHWEST = 0
NORTHEAST = 1
SOUTHEAST = 2
SOUTHWEST = 3

-- spell it either way
CENTER = 4
CENTRE = 4

-- xp data
xp_classes = 4
xp_subskills = {4, 4, 4, 4}
xp_classnames = { "FIGHTER", "NINJA", "PRIEST", "WIZARD" }
xp_levels = 15		
xp_levelnames = { "NEOPHYTE", "NOVICE", "APPRENTICE",
	"JOURNEYMAN", "CRAFTSMAN", "ARTISAN", "ADEPT",
	"EXPERT", "a MASTER", "b MASTER", "c MASTER",
	"d MASTER", "e MASTER", "f MASTER", "ARCHMASTER" }		
xp_levelamounts = { 500, 1000, 2000, 
	4000, 8000, 16000, 32000, 
	64000, 128000, 256000, 512000, 
	1024000, 2048000, 4096000, 8192000 } 

barnames = { "HEALTH", "STAMINA", "MANA" }

statnames = { "STRENGTH", "DEXTERITY", "WISDOM", 
	"VITALITY", "ANTI-MAGIC", "ANTI-FIRE" }
	
msg_resurrected = " RESURRECTED."
msg_reincarnated = " REINCARNATED."

powchar = { "a", "b", "c", "d", "e", "f" }

-- Special "Level" targets
PARTY = -1
IN_OBJ = -2
CHARACTER = -3
MOUSE_HAND = -4
LIMBO = -5

-- Messages
-- Message ids above 100000 are reserved for the base code
-- Feel free to use anything below that
M_ACTIVATE = 100000
M_DEACTIVATE = 100001
M_TOGGLE = 100002
M_NEXTTICK = 100003
M_TEMPORARY_REVERSE = 100004
M_ALT_NEXTTICK = 100004
M_GRABMOREAMMO = 100005
M_STOPATTACK = 100007
M_CLEANUP = 100007
M_BASH = 100008
M_TINT = 100009
M_REARRANGE = 100100
M_TURN = 100101
M_ATTACK_MELEE = 100110
M_ATTACK_RANGED = 100111
M_ALIGNED = 100120
M_DESTROY = 100255

-- System Message Targets
-- These are set by the core; trying to use an undefined
-- value will result in nothing happening!
SYSTEM = -1
SYS_METHOD_OBJ = 1
SYS_METHOD_SEL = 2
SYS_METHOD_CLEAR = 3
SYS_MOVE_ARROW = 4
SYS_MAGIC_PPOS = 11
SYS_MAGIC_RUNE = 12
SYS_MAGIC_BACK = 13
SYS_MAGIC_CAST = 14

-- AI Messages
AI_FEAR = 1
AI_DELAY_ACTION = 2
AI_STUN = 3
AI_HAZARD = 4
AI_WALL_BELIEF = 5
AI_ATTACK_BMP = 6
AI_MOVE_NOW = 16
AI_SEE_PARTY = 32
AI_TARGET = 33
AI_UNGROUP = 34
AI_MOVE = 512
AI_TURN = 513
AI_TIMER = 514

-- Special AI parameters
UNDEFINE = -16
QUERY = -6000

-- missiles
MISSILE_MISC = 1
MISSILE_ARROW = 2
MISSILE_ROCK = 3
MISSILE_DART = 4
MISSILE_STAR = 5
MISSILE_DAGGER = 6
MISSILE_MAGIC = 999

-- condition attributes
INDIVIDUAL = -255

-- DEPRECATED: Please use the condition flags instead.
BAD_INDIVIDUAL = -254

-- condition flags
COND_MOUTH_RED = 1
COND_MOUTH_GREEN = 2
COND_EYE_RED = 4
COND_EYE_GREEN = 8

-- special fetch mode
TABLE = 1

-- special tag for colorconvert and objects
VARIABLE = -1

-- Graphics flags
GF_ALT_ICON = 1
GF_INACTIVE = 2
GF_BASHED = 4
GF_ATTACKING = 8
GF_UNMOVED = 16
GF_FLIP = 32

-- Game flags
GAME_WINDOW = 1
--GAME_FREEZELIFE = 2 (DEPRECATED)
_GAME_RESERVED = 2
GAME_PARTY_INVIS = 4
GAME_CSB_REINCARNATION = 32
GAME_GAMEOVER_ON_EMPTY = 64
GAME_CYAN_GLOW = 16777216

-- Mparty flags
MPARTY_SPLIT = 1
MPARTY_COLLIDE = 2

-- Game locking flags
LOCK_ACTUATORS = 1
LOCK_MOVEMENT = 2
LOCK_MOUSE = 4
LOCK_MAGIC = 8
LOCK_INVENTORY = 16
LOCK_ATTACK = 32
LOCK_FLYERS = 64
LOCK_CONDITIONS = 128
LOCK_MESSAGES = 256
LOCK_MONSTERS = 512
LOCK_MONSTERS_ALL = 1024

-- inventory locations
INV_R_HAND = 0
INV_L_HAND = 1
INV_HEAD = 2
INV_TORSO = 3
INV_LEGS = 4
INV_FEET = 5
INV_NECK = 6
INV_POUCH = 7
INV_POUCH2 = 8
INV_QUIVER = 9
INV_QUIV2 = 10
INV_QUIV3 = 11
INV_QUIV4 = 12
INV_PACK = 13
MAX_INV_SLOTS = 30

mouse_throwing_hand = INV_R_HAND

-- basic stats
STAT_STR = 0
STAT_DEX = 1
STAT_WIS = 2
STAT_VIT = 3
STAT_AMA = 4
STAT_AFI = 5
STAT_LUC = 6 -- hidden

-- classes
CLASS_FIGHTER = 0
CLASS_NINJA = 1
CLASS_PRIEST = 2
CLASS_WIZARD = 3

-- subskills
SKILL_SWINGING = 1
SKILL_STABBING = 2
SKILL_BASHING = 3
SKILL_DEFENSE = 4

SKILL_CLIMBING = 1
SKILL_MARTIALARTS = 2
SKILL_THROWING = 3
SKILL_SHOOTING = 4

SKILL_LUCK = 1
SKILL_POTIONS = 2
SKILL_FEAR = 3
SKILL_SHIELDS = 4

SKILL_FIRE = 1
SKILL_AIR = 2
SKILL_DES = 3
SKILL_POISON = 4

-- bars
HEALTH = 0
STAMINA = 1
MANA = 2

-- Monster attack types
ATTACK_STEAL = 0
ATTACK_ANTI_FIRE = 1
_ATTACK_RESERVED = 2
ATTACK_PHYSICAL = 3
ATTACK_PIERCING = 4
ATTACK_ANTI_MAGIC = 5
ATTACK_WISDOM = 6

player_colors = {
	{0, 222, 0},
	{255, 255, 0},
	{255, 0, 0},
	{0, 0, 255}
}

system_color = {0, 222, 222}
debug_color = {255, 160, 0}
scroll_color = {0, 0, 0}

-- for text (CENTER is also used)
LEFT = 0
RIGHT = 1
MULTILINE = 128

-- for blitting
PATTERN_MODE = 1
SHADOW_MODE = 2

magic_system_colors = {
	{0, 0, 0},
	{255, 255, 255},
	system_color,
	system_color,
	{0, 64, 64}     -- disabled rune
}
magic_runes = {
	"a", "b", "c", "d", "e", "f",
	"g", "h", "i", "j", "k", "l",
	"m", "n", "o", "p", "q", "r",
	"s", "t", "u", "v", "w", "x"
}
power_multipliers = { 1.0, 1.5, 2.0, 2.5, 3.0, 3.5 }
rune_costs = {
	10, 20, 30, 40, 50, 60,
	20, 30, 40, 50, 60, 70,
	40, 50, 60, 70, 70, 90,
	20, 20, 30, 40, 60, 70
}
runes_per_set = 6
rune_sets = 4

g_disabled_runes = {
	false, false, false, false, false, false,
	false, false, false, false, false, false,
	false, false, false, false, false, false,
	false, false, false, false, false, false
}

-- alias to a renamed function, for old code
dsb_update_strings = dsb_update_system

-- The following files will be parsed, in this order.
-- You can also include a lua_manifest in your own custom
-- dungeon's startup.lua, if you want to break your script
-- up across multiple files.
lua_manifest = {
	"graphics.lua",
	"util.lua",
	"triggers.lua",
	"conditions.lua",
	"monster.lua",
	"monster_ai.lua",
	"methods.lua",
	"damage.lua",
	"xp.lua",
	"magic.lua",
	"msg_handlers.lua",
	"hooks.lua",
	"system.lua",
	"render.lua"
}

--startup function
function global_startup()
	dsb_viewport(0, 66)
end
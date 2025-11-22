TaskRooms = {}    
  
TaskRooms = {    
    [1] = {    
        {    
            name = "Goblin",    
            position = Position(940, 1040, 5),
            displayPosition = Position(938, 1040, 5),
            displayCreature = "Goblin",
            displayDirection = DIRECTION_EAST,
            killsRequired = 10,    
            creatures = {"goblin", "goblin scavenger", "goblin assassin"},    
            rewards = {    
                exp = 5000,    
                gold = 10000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room1.Goblin.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room1.Goblin.counter    
            }    
        },   
        {    
            name = "Troll",    
            position = Position(941, 1037, 5),  
            displayPosition = Position(941, 1035, 5),
            displayCreature = "troll",
            displayDirection = DIRECTION_SOUTH,
            killsRequired = 15,    
            creatures = {"troll", "troll champion"},    
            rewards = {    
                exp = 7500,    
                gold = 15000,
                items = {  
                    { id = 28724, count = 1 }
                } 
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room1.Troll.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room1.Troll.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room1.Goblin.quest  
        },    
        {    
            name = "Rotworm",    
            position = Position(946, 1035, 5),  
            displayPosition = Position(946, 1033, 5),
            displayCreature = "rotworm",
            displayDirection = DIRECTION_SOUTH,
            killsRequired = 20,    
            creatures = {"rotworm", "carrion worm"},    
            rewards = {    
                exp = 10000,    
                gold = 20000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room1.Rotworm.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room1.Rotworm.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room1.Troll.quest  
        },
        {    
            name = "Minotaur",    
            position = Position(952, 1035, 5),  
            displayPosition = Position(952, 1033, 5),
            displayCreature = "Minotaur",
            displayDirection = DIRECTION_SOUTH,
            killsRequired = 20,    
            creatures = {"minotaur", "minotaur guard", "minotaur archer", "minotaur mage"},    
            rewards = {    
                exp = 10000,    
                gold = 20000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room1.Minotaur.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room1.Minotaur.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room1.Rotworm.quest  
        },
        {    
            name = "Elf",    
            position = Position(958, 1035, 5),  
            displayPosition = Position(958, 1033, 5),
            displayCreature = "elf",
            displayDirection = DIRECTION_SOUTH,
            killsRequired = 20,    
            creatures = {"elf", "elf arcanist", "elf scout"},    
            rewards = {    
                exp = 10000,    
                gold = 20000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room1.Elf.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room1.Elf.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room1.Minotaur.quest  
        },
        {    
            name = "Dwarf",    
            position = Position(962, 1039, 5),  
            displayPosition = Position(964, 1039, 5),
            displayCreature = "dwarf",
            displayDirection = DIRECTION_WEST,
            killsRequired = 20,    
            creatures = {"dwarf", "dwarf soldier", "dwarf geomancer", "dwarf guard"},    
            rewards = {    
                exp = 10000,    
                gold = 20000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room1.Dwarf.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room1.Dwarf.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room1.Elf.quest  
        },
        {    
            name = "Amazon",    
            position = Position(964, 1044, 5),  
            displayPosition = Position(966, 1044, 5),
            displayCreature = "amazon",
            displayDirection = DIRECTION_WEST,
            killsRequired = 20,    
            creatures = {"amazon", "valkyrie"},
            rewards = {    
                exp = 10000,    
                gold = 20000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room1.Amazon.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room1.Amazon.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room1.Dwarf.quest  
        },
        {    
            name = "Barbarian",    
            position = Position(961, 1047, 5),  
            displayPosition = Position(961, 1049, 5),
            displayCreature = "Barbarian Brutetamer",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 20,    
            creatures = {"Barbarian Brutetamer", "barbarian bloodwalker", "barbarian headsplitter", "barbarian skullhunter"},    
            rewards = {    
                exp = 10000,    
                gold = 20000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room1.Barbarian.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room1.Barbarian.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room1.Amazon.quest  
        },
        {    
            name = "Corym",    
            position = Position(956, 1049, 5),  
            displayPosition = Position(956, 1051, 5),
            displayCreature = "corym vanguard",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 20,    
            creatures = {"corym vanguard", "corym skirmisher", "corym charlatan"},    
            rewards = {    
                exp = 10000,    
                gold = 20000
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room1.Corym.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room1.Corym.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room1.Barbarian.quest  
        },
        {    
            name = "Magician",    
            position = Position(950, 1049, 5),  
            displayPosition = Position(950, 1051, 5),
            displayCreature = "Dark Magician",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 20,    
            creatures = {"Dark Magician", "Dark apprentice"},    
            rewards = {    
                exp = 10000,    
                gold = 20000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room1.Magician.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room1.Magician.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room1.Corym.quest  
        },                                          
        {    
            name = "Dworc",    
            position = Position(946, 1045, 5),  
            displayPosition = Position(946, 1047, 5),
            displayCreature = "dworc voodoomaster",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 20,    
            creatures = {"dworc fleshhunter", "dworc shadowstalker", "dworc venomsniper", "dworc voodoomaster"},    
            rewards = {    
                exp = 10000,    
                gold = 20000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room1.Dworc.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room1.Dworc.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room1.Magician.quest  
        },                                           
        {    
            name = "Cyclops",    
            position = Position(941, 1043, 5),  
            displayPosition = Position(941, 1045, 5),
            displayCreature = "Cyclops",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 20,    
            creatures = {"Cyclops", "Cyclops Drone", "Cyclops Smith"},    
            rewards = {    
                exp = 10000,    
                gold = 20000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room1.Cyclops.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room1.Cyclops.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room1.Dworc.quest  
        }                                                    
    },    
        
    [2] = {    
        {    
            name = "Cults",    
            position = Position(886, 1040, 5), 
            displayPosition = Position(884, 1040, 5),
            displayCreature = "Acolyte of the Cult",
            displayDirection = DIRECTION_EAST,
            killsRequired = 25,    
            creatures = {"Acolyte of the Cult", "Adept of the Cult", "Enlightened of the Cult",
                         "Cult Believer", "Cult Enforcer", "Cult Scholar"},    
            rewards = {    
                exp = 15000,    
                gold = 30000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room2.Cults.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room2.Cults.counter    
            }    
        },
        {    
            name = "Asuras",    
            position = Position(887, 1037, 5), 
            displayPosition = Position(887, 1035, 5),
            displayCreature = "Dawnfire Asura",
            displayDirection = DIRECTION_SOUTH,
            killsRequired = 350,    
            creatures = {"Midnight Asura", "Frost Flower Asura", "Dawnfire Asura"},    
            rewards = {    
                exp = 25000,    
                gold = 50000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room2.Asuras.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room2.Asuras.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room2.Cults.quest    
        },
        {    
            name = "Orcs",    
            position = Position(892, 1035, 5), 
            displayPosition = Position(892, 1033, 5),
            displayCreature = "Orc Berserker",
            displayDirection = DIRECTION_SOUTH,
            killsRequired = 350,    
            creatures = {"Orc Berserker", "Orc Cult Fanatic", "Orc Cult Inquisitor", "Orc Cult Minion",
                         "Orc Cult Priest", "Orc Cultist", "Orc Leader", "Orc Warlord"},
            rewards = {    
                exp = 25000,    
                gold = 50000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room2.Orcs.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room2.Orcs.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room2.Asuras.quest
        },
        {    
            name = "Pirat",    
            position = Position(898, 1035, 5), 
            displayPosition = Position(898, 1033, 5),
            displayCreature = "Pirat Mate",
            displayDirection = DIRECTION_SOUTH,
            killsRequired = 350,    
            creatures = {"Pirat Bombardier", "Pirat Cutthroat", "Pirat Scoundrel", "Pirat Mate"},
            rewards = {    
                exp = 25000,    
                gold = 50000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room2.Pirat.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room2.Pirat.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room2.Orcs.quest
        },
        {    
            name = "Barkless",    
            position = Position(904, 1035, 5), 
            displayPosition = Position(904, 1033, 5),
            displayCreature = "Barkless Devotee",
            displayDirection = DIRECTION_SOUTH,
            killsRequired = 350,    
            creatures = {"Barkless Devotee", "Barkless Fanatic"},
            rewards = {    
                exp = 25000,    
                gold = 50000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room2.Barkless.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room2.Barkless.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room2.Pirat.quest
        },
        {    
            name = "Hero",    
            position = Position(908, 1039, 5), 
            displayPosition = Position(910, 1039, 5),
            displayCreature = "Hero",
            displayDirection = DIRECTION_WEST,
            killsRequired = 350,    
            creatures = {"Hero", "Renegade Knight", "Vicious Squire", "Vile Grandmaster"},
            rewards = {    
                exp = 25000,    
                gold = 50000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room2.Hero.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room2.Hero.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room2.Pirat.quest
        },
        {    
            name = "Deepling",    
            position = Position(910, 1044, 5), 
            displayPosition = Position(912, 1044, 5),
            displayCreature = "Deepling Guard",
            displayDirection = DIRECTION_WEST,
            killsRequired = 350,    
            creatures = {"Deepling Elite", "Deepling Guard", "Deepling Scout", "Deepling Spellsinger", "Deepling Warrior"},
            rewards = {    
                exp = 25000,    
                gold = 50000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room2.Deepling.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room2.Deepling.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room2.Hero.quest
        },
        {    
            name = "Dragon",    
            position = Position(907, 1047, 5), 
            displayPosition = Position(907, 1049, 5),
            displayCreature = "Dragon",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 350,    
            creatures = {"Dragon Lord", "Dragon", "Dragon Hatchling", "Dragon Lord Hatchling"},
            rewards = {    
                exp = 25000,    
                gold = 50000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room2.Dragon.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room2.Dragon.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room2.Deepling.quest
        },
        {    
            name = "Draken",    
            position = Position(902, 1049, 5), 
            displayPosition = Position(902, 1051, 5),
            displayCreature = "Draken Warmaster",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 350,    
            creatures = {"Draken Warmaster", "Draken spellweaver"},
            rewards = {    
                exp = 25000,
                gold = 50000
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room2.Draken.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room2.Draken.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room2.Dragon.quest
        },
        {    
            name = "Werebear",    
            position = Position(896, 1049, 5), 
            displayPosition = Position(896, 1051, 5),
            displayCreature = "Werebear",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 350,    
            creatures = {"Werebear", "Wereboar", "Werefox", "Werewolf"},
            rewards = {    
                exp = 25000,    
                gold = 50000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room2.Werebear.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room2.Werebear.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room2.Draken.quest
        },
        {    
            name = "Spider",    
            position = Position(892, 1045, 5), 
            displayPosition = Position(892, 1047, 5),
            displayCreature = "Exotic Cave Spider",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 350,    
            creatures = {"Exotic Cave Spider", "GianT Spider"},
            rewards = {    
                exp = 25000,    
                gold = 50000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room2.Spider.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room2.Spider.counter    
            },    
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room2.Werebear.quest
        },
        {    
            name = "Lizard",    
            position = Position(887, 1043, 5), 
            displayPosition = Position(887, 1045, 5),
            displayCreature = "Lizard Zaogun",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 350,    
            creatures = {"Lizard Zaogun", "Lizard Legionnaire", "Lizard High Guard"},
            rewards = {    
                exp = 25000,    
                gold = 50000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room2.Lizard.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room2.Lizard.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room2.Spider.quest
        }
    },    
        
    [3] = {    
        {    
            name = "Cathedral",    
            position = Position(903, 990, 5),  
            displayPosition = Position(901, 990, 5),
            displayCreature = "Burster Spectre",
            displayDirection = DIRECTION_EAST,
            killsRequired = 400,    
            creatures = {"Arachnophobica", "Burster Spectre", "Ripper Spectre", "Gazer Spectre"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room3.Cathedral.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room3.Cathedral.counter    
            }    
        },    
        {    
            name = "Falcon",    
            position = Position(904, 987, 5),  
            displayPosition = Position(904, 985, 5),
            displayCreature = "Falcon Paladin",
            displayDirection = DIRECTION_SOUTH,
            killsRequired = 400,    
            creatures = {"Falcon Paladin", "Falcon Knight"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room3.Falcon.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room3.Falcon.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room3.Cathedral.quest   
        },    
        {    
            name = "Court",    
            position = Position(909, 985, 5),  
            displayPosition = Position(909, 983, 5),
            displayCreature = "Crazed Summer Rearguard",
            displayDirection = DIRECTION_SOUTH,
            killsRequired = 400,    
            creatures = {"Crazed Summer Rearguard", "Crazed Summer Vanguard", "Crazed Winter Rearguard", "Crazed Winter Vanguard"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room3.Court.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room3.Court.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room3.Falcon.quest
        },  
        {    
            name = "Cobra",    
            position = Position(915, 985, 5),  
            displayPosition = Position(915, 983, 5),
            displayCreature = "Cobra Assassin",
            displayDirection = DIRECTION_SOUTH,
            killsRequired = 400,    
            creatures = {"Cobra Vizier", "Cobra Scout", "Cobra Assassin"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room3.Cobra.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room3.Cobra.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room3.Court.quest  
        },    
        {    
            name = "Crypt",    
            position = Position(921, 985, 5),  
            displayPosition = Position(921, 983, 5),
            displayCreature = "Crypt Warden",
            displayDirection = DIRECTION_SOUTH,
            killsRequired = 400,    
            creatures = {"Crypt Warden", "Sphinx", "Lamassu"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room3.Crypt.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room3.Crypt.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room3.Cobra.quest
        },    
        {    
            name = "Deathling",    
            position = Position(925, 989, 5),  
            displayPosition = Position(927, 989, 5),
            displayCreature = "Deathling Scout",
            displayDirection = DIRECTION_WEST,
            killsRequired = 400,    
            creatures = {"Deathling Scout", "Deathling Spellsinger"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room3.Deathling.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room3.Deathling.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room3.Crypt.quest
        },    
        {    
            name = "Prison",    
            position = Position(927, 994, 5),  
            displayPosition = Position(929, 994, 5),
            displayCreature = "Demon Outcast",
            displayDirection = DIRECTION_WEST,
            killsRequired = 400,    
            creatures = {"Demon Outcast", "Dark Torturer"},
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room3.Prison.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room3.Prison.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room3.Deathling.quest
        },    
        {    
            name = "Dragolisk",    
            position = Position(924, 997, 5),  
            displayPosition = Position(924, 999, 5),
            displayCreature = "Dragolisk",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 400,    
            creatures = {"Dragolisk", "Mega Dragon", "Wardragon"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room3.Dragolisk.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room3.Dragolisk.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room3.Prison.quest
        },    
        {    
            name = "Ingol",    
            position = Position(919, 999, 5),  
            displayPosition = Position(919, 1001, 5),
            displayCreature = "Rhindeer",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 400,    
            creatures = {"Rhindeer", "Liodile", "Harpy", "Crape Man", "Carnivostrich", "Boar Man"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room3.Ingol.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room3.Ingol.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room3.Dragolisk.quest
        },    
        {    
            name = "Roshamuul",    
            position = Position(913, 999, 5),  
            displayPosition = Position(913, 1001, 5),
            displayCreature = "Guzzlemaw",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 400,    
            creatures = {"Guzzlemaw", "Silencer", "shock head"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room3.Roshamuul.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room3.Roshamuul.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room3.Ingol.quest
        },    
        {    
            name = "Naga",    
            position = Position(909, 995, 5),  
            displayPosition = Position(909, 997, 5),
            displayCreature = "Naga Warrior",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 400,    
            creatures = {"Naga Archer", "Naga Warrior"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room3.Naga.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room3.Naga.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room3.Roshamuul.quest
        },    
        {    
            name = "Goanna",    
            position = Position(904, 993, 5),  
            displayPosition = Position(904, 995, 5),
            displayCreature = "Adult Goanna",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 400,    
            creatures = {"Adult Goanna", "Young Goanna"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room3.Goanna.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room3.Goanna.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room3.Naga.quest
        }   
   
    },    
        
    [4] = {    
        {    
            name = "Ice",    
            position = Position(901, 941, 5),  
            displayPosition = Position(899, 941, 5),
            displayCreature = "Icecold book",
            displayDirection = DIRECTION_EAST,
            killsRequired = 400,    
            creatures = {"Squid Warden", "Animated Feather", "Icecold book"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room4.Ice.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room4.Ice.counter    
            }    
        },    
        {    
            name = "Fire",    
            position = Position(902, 938, 5),  
            displayPosition = Position(902, 936, 5),
            displayCreature = "Burning book",
            displayDirection = DIRECTION_SOUTH,
            killsRequired = 400,    
            creatures = {"Burning book", "rage squid", "guardian of tales", "Ink Blob"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room4.Fire.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room4.Fire.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room4.Ice.quest   
        },    
        {    
            name = "Energy",    
            position = Position(907, 936, 5),  
            displayPosition = Position(907, 934, 5),
            displayCreature = "Energetic Book",
            displayDirection = DIRECTION_SOUTH,
            killsRequired = 400,    
            creatures = {"Brain Squid", "Crazed Summer Vanguard", "Energetic Book", "Energuardian Of Tales"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room4.Energy.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room4.Energy.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room4.Fire.quest
        },  
        {    
            name = "Furious Crater",    
            position = Position(913, 936, 5),  
            displayPosition = Position(913, 934, 5),
            displayCreature = "Cloak Of Terror",
            displayDirection = DIRECTION_SOUTH,
            killsRequired = 400,    
            creatures = {"Cloak Of Terror", "Courage Leech", "Vibrant Phantom"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room4.FuriousCrater.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room4.FuriousCrater.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room4.MirroredNightmare.quest  
        },    
        {    
            name = "Mirrored Nightmare",    
            position = Position(919, 936, 5),  
            displayPosition = Position(919, 934, 5),
            displayCreature = "Many Faces",
            displayDirection = DIRECTION_SOUTH,
            killsRequired = 400,    
            creatures = {"Distorted Phantom", "Many Faces", "knight's apparition", "Monk's Apparition", "Paladin's Apparition",
                         "Druid's Apparition", "Sorcerer's Apparition"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room4.MirroredNightmare.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room4.MirroredNightmare.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room4.FuriousCrater.quest
        },    
        {    
            name = "Rotten Wasteland",    
            position = Position(923, 940, 5),  
            displayPosition = Position(925, 940, 5),
            displayCreature = "Rotten Golem",
            displayDirection = DIRECTION_WEST,
            killsRequired = 400,    
            creatures = {"Branchy Crawler", "Mould Phantom", "Rotten Golem"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room4.RottenWasteland.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room4.RottenWasteland.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room4.FuriousCrater.quest
        },    
        {    
            name = "Claustrophobic Inferno",    
            position = Position(925, 945, 5),  
            displayPosition = Position(927, 945, 5),
            displayCreature = "Infernal Demon",
            displayDirection = DIRECTION_WEST,
            killsRequired = 400,    
            creatures = {"Brachiodemon", "Infernal Demon", "Infernal Phantom"},
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room4.ClaustrophobicInferno.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room4.ClaustrophobicInferno.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room4.RottenWasteland.quest
        },    
        {    
            name = "Crystal Enigma",    
            position = Position(922, 948, 5),  
            displayPosition = Position(922, 950, 5),
            displayCreature = "Noxious Ripptor",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 400,    
            creatures = {"Noxious Ripptor", "Headpecker", "Mantosaurus", "Mercurial Menace", "Shrieking Cry-Stal"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room4.CrystalEnigma.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room4.CrystalEnigma.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room4.ClaustrophobicInferno.quest
        },    
        {    
            name = "Monster Graveyard",    
            position = Position(917, 950, 5),  
            displayPosition = Position(917, 952, 5),
            displayCreature = "Undertaker",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 400,    
            creatures = {"Undertaker", "Sulphur Spouter", "Sulphider", "Stalking Stalk", "Nighthunter"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room4.MonsterGraveyard.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room4.MonsterGraveyard.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room4.CrystalEnigma.quest
        },    
        {    
            name = "Sparkling Pools",    
            position = Position(911, 950, 5),  
            displayPosition = Position(911, 952, 5),
            displayCreature = "Hulking Prehemoth",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 400,    
            creatures = {"Hulking Prehemoth", "Emerald Tortoise", "Gore Horn", "Gorerilla", "Hulking Prehemoth", "Sabretooth"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room4.SparklingPools.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room4.SparklingPools.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room4.MonsterGraveyard.quest
        },    
        {    
            name = "Jaded Roots",    
            position = Position(907, 946, 5),  
            displayPosition = Position(907, 948, 5),
            displayCreature = "Sopping Corpus",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 400,    
            creatures = {"Bloated Man-Maggot", "Mycobiontic Beetle", "Oozing Corpus", "Sopping Corpus"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room4.JadedRoots.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room4.JadedRoots.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room4.SparklingPools.quest
        },    
        {    
            name = "Darklight Core",    
            position = Position(902, 944, 5),  
            displayPosition = Position(902, 946, 5),
            displayCreature = "Darklight Source",
            displayDirection = DIRECTION_NORTH,
            killsRequired = 400,    
            creatures = {"Darklight Matter", "Darklight Source", "Darklight Striker", "Walking Pillar"},    
            rewards = {    
                exp = 35000,    
                gold = 70000    
            },    
            storage = {    
                quest = Storage.Quest.U15_20.TaskRooms.Room4.DarklightCore.quest,    
                counter = Storage.Quest.U15_20.TaskRooms.Room4.DarklightCore.counter    
            },
            prerequisite = Storage.Quest.U15_20.TaskRooms.Room4.JadedRoots.quest
        }   
    }    
}    
    
-- Funciones Helper para el Sistema de Tasks      
local function spawnTaskDisplays()  
    for roomId, tasks in ipairs(TaskRooms) do  
        for _, task in ipairs(tasks) do  
            if task.displayCreature and task.displayPosition then  
                local creature = Game.createMonster(  
                    task.displayCreature,   
                    task.displayPosition,   
                    false,   
                    true  
                )  
                if creature then  
                    creature:setDirection(task.displayDirection or DIRECTION_SOUTH)  
                    creature:setDirectionLocked(true)  
                    creature:setMoveLocked(true)  
                end  
            end  
        end  
    end  
end

function Player.hasActiveTask(self)    
    local activeTasks = self:getActiveTasks()    
    return #activeTasks > 0    
end    
    
function getTaskByStorage(storage)    
    for roomId, tasks in pairs(TaskRooms) do    
        for _, task in ipairs(tasks) do    
            if task.storage.quest == storage then    
                return task, roomId    
            end    
        end    
    end    
    return nil    
end    
    
function getTasksByRoom(roomId)    
    return TaskRooms[roomId] or {}    
end    
    
function Player.hasCompletedRoom(self, roomId)    
    local tasks = getTasksByRoom(roomId)    
    for _, task in ipairs(tasks) do    
        if self:getStorageValue(task.storage.quest) ~= 2 then    
            return false    
        end    
    end    
    return true    
end    
    
function Player.getActiveTasks(self)    
    local activeTasks = {}    
        
    for roomId, tasks in ipairs(TaskRooms) do    
        for _, task in ipairs(tasks) do    
            local questStatus = self:getStorageValue(task.storage.quest)    
            if questStatus == 1 then      
                table.insert(activeTasks, task)    
            end    
        end    
    end    
        
    return activeTasks    
end  
    
function Player.canStartTask(self, task)  
    if self:hasActiveTask() then  
        return false  
    end  
      
    local questStatus = self:getStorageValue(task.storage.quest)  
    if questStatus >= 1 then  
        return false  
    end  
      
    if task.prerequisite then  
        -- Verificar que el prerequisito tenga recompensa reclamada (>= 3)  
        if self:getStorageValue(task.prerequisite) < 3 then  
            return false  
        end  
    end  
      
    return true  
end
  
-- Iniciar task (establece storage = 1)  
function Player.startTask(self, task)  
    if not task then  
        return false  
    end  
      
    -- Establecer storage de quest a 1 (activa)  
    self:setStorageValue(task.storage.quest, 1)  
    -- Inicializar contador en 0  
    self:setStorageValue(task.storage.counter, 0)  
      
    return true  
end  
    
-- Esta función YA NO SE USA - las recompensas se entregan en task_action.lua  
function Player.completeTask(self, task)    
    if not task then    
        return false    
    end    
        
    if self:getStorageValue(task.storage.counter) < task.killsRequired then    
        return false    
    end    
        
    -- Solo actualizar storage - las recompensas se dan en task_action.lua  
    self:setStorageValue(task.storage.quest, 2)    
        
    return true    
end    
    
function Player.clearTask(self)    
    local activeTasks = self:getActiveTasks()    
    if #activeTasks == 0 then    
        return false, "You don't have any active task."    
    end    
        
    for _, task in ipairs(activeTasks) do    
        self:setStorageValue(task.storage.quest, -1)    
        self:setStorageValue(task.storage.counter, 0)    
    end    
        
    return true, "Your active task has been cleared."    
end
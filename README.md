# Quadroppler

> Drop dem!

## Gameplay

### Scoring

https://tetris.wiki/Scoring#Recent_guideline_compatible_games

|Action			|Points
|---------------|-------
|Lines
|Single			|100 x level
|Double			|300 x level
|Triple			|500 x level
|Quadrople		|800 x level; difficulty
|Drop
|Soft			|1 per cell
|Hard			|2 per cell
|Perfect Clear
|Single			|800 x level
|Double			|1200 x level
|Triple			|1800 x level
|Quadrople		|2000 x level

## Development

### Version Control

#### Commits

📡 = Github actions

### GDScript

**Naming conventions**

|Type         |Convention    |Info								|
|-------------|--------------|----------------------------------|
|File names   |snake_case    |yaml_parsed.gd 					|
|class_name   |PascalCase	 |YAMLParser						|
|Node names   |PascalCase	 |									|
|Functions    |snake_case	 |									|
|Variables	  |snake_case	 |									|
|Signals	  |snake_case	 |always in past tense "door_opened"|
|Constants	  |CONSTANT_CASE |									|
|enum names	  |PascalCase	 |									|
|enum members |CONSTANT_CASE |									|


**Code order**

01. tool
02. class_name
03. extends
04. \# docstring
05. signals
06. enums
07. constants
08. exported variables
09. public variables
10. private variables
11. onready variables
12. optional built-in virtual _init method
13. built-in virtual _ready method
14. remaining built-in virtual methods
15. public methods
16. private methods


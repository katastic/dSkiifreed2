/++ 
 * Zones
 	Snowy Mountain
	Dirt Cave
	Research Facility
		set off a nuke
	Lava Volcano
 +/
import std.stdio;
import toml;

struct Viewport {
	float x, y, w, h, ox, oy;
}

class BaseObject {
	pair pos, vel;
}

struct pair {
	float x, y;
}

struct rect {
	float x, y, w, h;
}

struct bitmap {
}

class AICom {
}

class PhysicsCom {
}

class GraphicsCom {
}

class Unit {
	PhysicsCom phy;
	GraphicsCom gfx;

	void onTick() {
	}

	void onDraw(Viewport v) {
	}
}

class PlayerUnit : Unit {
	//weaponsList
	//upgradesList
}

class EnemyUnit : Unit {
	AICom ai;
}

struct physicalParticle {
	pair pos, vel;
	bitmap* bmp;
}

struct particle {
	pair pos, vel;
	bitmap* bmp;
}

class PlayerStats {
	int money;
}

class World {
	Unit[] units;

	this() {
		loadStage();
	}

	void parseMap(string mapPath) {
		import std.file, std.conv;

		auto data = parseTOML(cast(string) read(mapPath));
		writefln("file [%s]=[%s]", mapPath, data);
		string name = data["general"]["name"].str;
		writeln(name);
	}

	void parseMapEntities(string entityPath) {
		import std.file, std.conv;

		auto data = parseTOML(cast(string) read(entityPath));
		writefln("file [%s]=[%s]", entityPath, data);
		string name = data["general"]["name"].str;
		writeln(name);
	}

	final void loadStage(string mapPath = "map.toml", string entityPath = "mapentities.toml") {
		parseMap(mapPath);
		parseMapEntities(entityPath);
	}

	/+		long numberScreens = data["general"]["screens"].integer;

		for (int i = 0; i < numberScreens; i++)
		{
			auto d = data["screen%u".format(i)];
			writeln("\t", d);
			Screen s = Screen(cast(int) d["width"].integer, cast(int) d["height"].integer, cast(int) d["nEntryZones"]
					.integer);
			writeln(s);
		}
		writefln("%s %s", name, numberScreens);+/

	void onTick() {
	}

	void onDraw(Viewport V) {
	}
}

void main(string[] args) {
	PlayerStats[] playerStats; 
	World world = new World(); // putting these here prevents any direct access except through passed references.
	Viewport[] viewports;
	viewports ~= Viewport(0, 0, 320, 240, 0, 0);
	viewports ~= Viewport(320, 0, 320, 240, 0, 0);
	world.onTick();
	world.onDraw(viewports[0]);
	world.onDraw(viewports[1]);
	writeln("End of line.");
}

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
//import molto;

struct Viewport
{
	float x, y, w, h, ox, oy;
}

class BaseObject
{
	pair pos, vel;
}

struct pair
{
	float x, y;
}

struct rect
{
	float x, y, w, h;
}

struct bitmap
{
}

class AICom
{
}

class PhysicsCom
{
	pair pos;
	pair vel;
}

class GraphicsCom
{
}

class Unit
{
	PhysicsCom phy;
	GraphicsCom gfx;

	void onTick()
	{
	}

	void onDraw(Viewport v)
	{
	}
}

class PlayerUnit : Unit
{
	//weaponsList
	//upgradesList
}

class EnemyUnit : Unit
{
	AICom ai;
}

struct physicalParticleType
{
	float damage;
	float speed;
	bitmap* bmp;
	bool isTracking;
	float rotationSpeed; /// for tracking
}

enum PHY_PARTICLE
{
	pistolBullet = 0,
	rifleBullet = 1,
}

float atan2(pair vector)
{
	import std.math : atan2;

	return atan2(vector.y, vector.x);
}

float angleTo(pair A, pair B)
{
	import std.math : atan2;

	return atan2(B.y - A.y, B.x - A.y);
}

struct physicalParticle
{ /// Bullets, rockets, etc
	pair pos, vel;
	bitmap* bmp;

	physicalParticleType myType;
	//	int type; or type number?
	Unit myTarget; /// if tracking, what unit are we tracking

	void handleTracking()
	{
		if (myType.isTracking)
		{
			if (myTarget !is null)
			{
				import std.math;

				float angle = atan2(vel);
				float mag = sqrt(vel.x ^^ 2 + vel.y ^^ 2);
				float angle2 = angleTo(pos, myTarget.phy.pos);
				if (angle < angle2)
				{
					angle += myType.rotationSpeed;
				}
				if (angle > angle2)
				{
					angle -= myType.rotationSpeed;
				}
			}
			else
			{
				// just keep moving forward till we time out.
			}
		}

		void onTick()
		{
			handleTracking();
			pos.x += vel.x;
			pos.y += vel.y;
		}
	}

	bool onDraw(Viewport v)
	{
		return false;
	}
}

struct particle
{
	pair pos, vel;
	bitmap* bmp;
}

class PlayerStats
{
	int money;
}

class World
{
	Unit[] units;

	this()
	{
		loadStage();
	}

	void parseMap(string mapPath)
	{
		import std.file, std.conv;

		auto data = parseTOML(cast(string) read(mapPath));
		writefln("file [%s]=[%s]", mapPath, data);
		string name = data["general"]["name"].str;
		writeln(name);
	}

	void parseMapEntities(string entityPath)
	{
		import std.file, std.conv;

		auto data = parseTOML(cast(string) read(entityPath));
		writefln("file [%s]=[%s]", entityPath, data);
		string name = data["general"]["name"].str;
		writeln(name);
	}

	final void loadStage(string mapPath = "map.toml", string entityPath = "mapentities.toml")
	{
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

	void onTick()
	{
	}

	void onDraw(Viewport V)
	{
	}
}

void main(string[] args)
{
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

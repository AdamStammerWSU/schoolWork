package com.as.game.menu;

import java.util.ArrayList;

import com.gb.game.Game;
import com.gb.game.graphics.Screen;

public abstract class Menu {

	protected Screen screen = Game.getScreen();
	private ArrayList<MenuObject> objs = new ArrayList<MenuObject>();
	protected Menu parent;
	public long start;

	public Menu() {
		init();
	}

	public abstract void init();

	public void tick() {
		for (MenuObject o : objs)
			o.tick();
	}

	public void render() {
		for (MenuObject o : objs) {
			o.render();
		}
	}

	public void addObject(MenuObject m) {
		objs.add(m);
	}

	public static int screenCenter(String s) {
		return (800 - (s.length() * 20)) / 2;
	}
}
